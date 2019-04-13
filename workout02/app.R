library(shiny)
library(ggplot2)
library(rsconnect)

#Include input and output functions here
ui <- fluidPage(
  titlePanel("Savings Simulations"),
  fluidRow(
    column(4, sliderInput(inputId = "init_amount",
                          label = "Initial Amount",
                          min = 0,
                          max = 100000,
                          step = 500,
                          value = 1000
                          )
    ),
    column(4, sliderInput(inputId = "return_rate",
                          label = "Return rate (in %)",
                          min = 0,
                          max = 20,
                          step = 0.1,
                          value = 5
                          )
    ),
    column(4, sliderInput(inputId = "years",
                          label = "Years",
                          min = 0,
                          max = 50,
                          step = 1,
                          value = 20
                         )
    )
  ),
  fluidRow(
    column(4, sliderInput(inputId = "annual_contrib",
                          label = "Annual Contribution",
                          min = 0,
                          max = 50000,
                          step = 500,
                          value = 2000
                          )
    ),
    column(4, sliderInput(inputId = "growth_rate",
                          label = "Growth Rate (in %)",
                          min = 0,
                          max = 20,
                          step = 0.1,
                          value = 2
                          )
    ),
    column(4, selectInput(inputId = "facet", 
                          label = h5("Facet?"), 
                          choices = list("No" = "No", "Yes" = "Yes"), 
                          selected = "No"
                          )
    )
  ),
  fluidRow(
    column(12,
      h4("Timelines"),
      wellPanel(
        plotOutput(outputId = "savings_plot")
      )
    )
  ), 
  fluidRow(
    column(12,
      h4("Balances"),
      wellPanel(
        tableOutput(outputId = "savings_table")
      )
    )
  )
)

#Server assembles inputs with outputs
server <- function(input, output) {
  future_value <- function(amount, rate, years) {
    return(amount * (1 + rate)^years)
  }
  
  annuity <- function(contrib, rate, years) {
    return(contrib * (((1 + rate)^years - 1)/rate))
  }
  
  growing_annuity <- function(contrib, rate, growth, years) {
    return(contrib * (((1 + rate)^years - (1 + growth)^years)/(rate - growth)))
  }
  
  calculate_values <- reactive({
    no_contrib <- c(input$init_amount)
    fixed_contrib <- c(input$init_amount)
    growing_contrib <- c(input$init_amount)
    
    years <- 1:input$years
    return_rate <- input$return_rate * 0.01
    growth_rate <- input$growth_rate * 0.01
    for (i in years) {
      no_contrib[i+1] <- future_value(amount=input$init_amount, rate=return_rate, years=i)
      fixed_contrib[i+1] <- no_contrib[i+1] + annuity(contrib=input$annual_contrib, rate=return_rate, years=i)
      growing_contrib[i+1] <- no_contrib[i+1] + growing_annuity(contrib=input$annual_contrib, 
                                                                rate=return_rate, growth=growth_rate, years=i)
    }
    
    years <- c(0, years)
    return(data.frame(cbind(years, no_contrib, fixed_contrib, growing_contrib)))
  })
  
  
  create_plot <- reactive({
    df <- calculate_values()
    if (input$facet == "Yes") {
      df_facet <- data.frame(matrix(ncol = 0, nrow = 3 * (input$years+1)))
      df_facet$years <- rep(df$years, 3)
      df_facet$contrib <- c(df$no_contrib, df$fixed_contrib, df$growing_contrib)
      df_facet$contrib_type <- c(rep("No contrib", input$years+1), rep("Fixed contrib", input$years+1), rep("Growing contrib", input$years+1))
      df <- data.frame(df_facet)
    }
    
    if (input$facet == "No") {
      gg <- ggplot(data = df) + 
            geom_line(aes(x=years, y=no_contrib, color = "No Contrib")) +
            geom_line(aes(x=years, y=fixed_contrib, color = "Fixed Contrib")) +
            geom_line(aes(x=years, y=growing_contrib, color = "Growing Contrib")) + 
            geom_point(aes(x=years, y=no_contrib, color = "No Contrib")) +
            geom_point(aes(x=years, y=fixed_contrib, color = "Fixed Contrib")) +
            geom_point(aes(x=years, y=growing_contrib, color = "Growing Contrib")) + 
            scale_colour_manual("Modality", values = c("red", "green", "blue")) + 
            scale_x_discrete(labels = 0:input$years, limits=0:input$years) + 
            xlab("Years") + 
            ylab("Value") + 
            ggtitle("Three modes of investing")
    } else {
      df$contrib_type <- factor(df$contrib_type, levels = c("No contrib", "Fixed contrib", "Growing contrib"))
      gg <- ggplot(data = df)  + 
            geom_line(aes(x=years, y=contrib, color = contrib_type)) +
            geom_point(aes(x=years, y=contrib, color = contrib_type)) +
            scale_colour_manual("Modality", values = c("red", "green", "blue")) +
            scale_x_discrete(labels = 0:input$years, limits=0:input$years) +
            xlab("Years") + 
            ylab("Value") + 
            ggtitle("Three modes of investing") +
            facet_wrap(. ~ contrib_type) +
            geom_area(aes(x = years, y = contrib, fill = contrib_type, alpha = 0.5)) + 
            guides(fill=FALSE) +
            guides(alpha=FALSE)
    }
    return(gg)
  })
  
  output$savings_table <- renderTable({
    calculate_values()
  }, rownames = TRUE)
  
  output$savings_plot <- renderPlot({
    create_plot()
  })
}

#Run the application
shinyApp(ui = ui, server = server)

