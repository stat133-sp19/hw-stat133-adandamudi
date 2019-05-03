########################################################
#############      Devtools workflow     ###############
########################################################

devtools::document()        #Create Documentation
devtools::check_man()       #Check Documentation
devtools::test()            #Run Tests
devtools::build_vignettes() #Knit Vignettes
devtools::build()           #Build Bundle
devtools::install()         #Install binary
devtools::check()           #Check
