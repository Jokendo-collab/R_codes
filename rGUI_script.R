#In this script the R graphical User Interface will be build and tested
#install.packages("gWidgets",dependencies = T) #These two codes install the gui packages
#install.packages("gWidgetstcltk",dependencies = T)
library(gWidgets)
library(gWidgetstcltk) #or gWidgetsGtk2 or gWidgetsrJava or gWidgetsWWW or gWidgetsQ

#The textboxes and checkboxes and so forth that we need are known as widgets (hence "gWidgets").
#They need to be contained inside a window, which we create using the function gwindow.
win <- gwindow("Tab delimited file upload example")


grp_name <- ggroup(container = win) # creating the groups of widgets that are stacked horizontally

#A glabel is a widget that represents a text label. Notice that it is contained inside the group we just created.
lbl_data_frame_name <- glabel("maxquant_combined_folder: ",container = grp_name)

#gedit is a single text line
txt_data_frame_name <- gedit("dfr", container = grp_name)

#Another horizontal group, for the upload button.
grp_upload <- ggroup(container = win)

#Adding the handler argument
btn_upload <- gbutton(
  text      = "MaxQuont txt path",
  container = grp_upload,
  handler   = function(h, ...)
  {
    #install.packages("PTXQC")
    library(PTXQC) # load the PTXQC library
    #require(PTXQC)
    require(yaml)
    require(methods)
    #setwd("M:/2018/TB/Clemens/QE/20180807_Reprocessing_BAL/combined_Human_Metanova/")
    # Generating the default report
    source(file.choose())
    text_folder <- "M:/2018/TB/Clemens/QE/20180305_IP_MS_SerumvsBAL/All samples/First_processing_combined/txt" #if you have local MaxQuant output, just use it, loading txt folder in the combined folder
    text_folder
    r = createReport(text_folder) #Create the report in *.xml format
    
    # TODO!
  })

#Creating the checkbox for the comma separated files
se_comma_for_decimal <- function()
{
  unname(Sys.localeconv()["decimal_point"] == ",")
}

chk_eurostyle <- gcheckbox(
  text      = "Use comma for decimal place",
  checked   = use_comma_for_decimal(),
  container = grp_upload
)

#The R status
status_bar <- gstatusbar("", container = win)

#Finally
function(h, ...)
{
  gfile(
    text    = "Upload tab delimited file",
    type    = "open",
    action  = ifelse(svalue(chk_eurostyle), "read.delim2", "read.delim"),
    handler = function(h, ...)
    {
      tryCatch(
        {
          data_frame_name <- make.names(svalue(txt_data_frame_name))
          the_data <- do.call(h$action, list(h$file))
          assign(data_frame_name, the_data, envir = globalenv())
          svalue(status_bar) <-
            paste(nrow(the_data), "records saved to variable", data_frame_name)
        },
        error = function(e) svalue(status_bar) <- "Could not upload data"
      )
    },
    filter = list(
      "Tab delimited" = list(patterns = c("*.txt","*.dlm","*.tab")),
      "All files" = list(patterns = c("*"))
    )
  )
}



#lmwidget <- ggenericwidget(lm)
























