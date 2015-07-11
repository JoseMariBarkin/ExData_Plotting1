
# Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. 
# Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
#
# First you will need to fork and clone the following GitHub repository: https://github.com/rdpeng/ExData_Plotting1
#
# For each plot you should
#
# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#
# Name each of the plot files as plot1.png, plot2.png, etc.
#
# Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R 
# constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be 
# fully reproduced. You should also include the code that creates the PNG file.
#
# Add the PNG file and R code file to your git repository
#
# When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your 
# repository is up to date. There should be four PNG files and four R code files.
#
# The four plots that you will need to construct are shown below. 
#
# Plot 2 to screen and file

library(utils)  # Just needed for unzip()
library(sqldf)
Sys.setlocale("LC_TIME", "English")

plot2 <- function(){
  myfile <- "household_power_consumption.txt"
  # if the file does not exist, then download it and unzip it
  if (! file.exists(myfile)) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destfile <- "exdata-data-household_power_consumption.zip"
    download.file(url, destfile = destfile, mode="wb") # use method = "curl" on mac
    unzip(destfile)  # from the utils library
  }
  
  mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  myData <- read.csv.sql(myfile, sql=mySql, sep=";")
  
  wDays <- strptime(paste(myData$Date, myData$Time), format='%d/%m/%Y %H:%M:%S')
  plot(wDays, myData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  ## Draw to png file
  dev.copy(png, file = "plot2.png", width = 480, height = 480, bg="white")
  dev.off()
  rm(list=ls())
}



