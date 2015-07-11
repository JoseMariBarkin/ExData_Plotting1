
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
## Plot 4 to screen

library(utils)  # Just needed for unzip()
library(sqldf)
Sys.setlocale("LC_TIME", "English")

plot4 <- function(){
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
  
  par(mfrow=c(2,2))
  
  ## draw 1,1
  plot(wDays, myData$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  ## draw 1,2
  plot(wDays, myData$Voltage, type="l", xlab="datetime", ylab="voltage")
  
  ## draw 2,1
  plot(wDays,myData$Sub_metering_1,type="l", xlab="", ylab = "Energy sub metering")
  lines(wDays,myData$Sub_metering_2,type="l",xlab="", col="red")
  lines(wDays,myData$Sub_metering_3,type="l",xlab="", col="blue")
  legend("topright",cex=0.7, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## draw 2,2
  plot(wDays, myData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  ## Draw to File png
  draw2File()
  rm(list=ls())
  
}

## Draw to File png

draw2File <- function(){
  myfile <- "household_power_consumption.txt"
  mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
  myData <- read.csv.sql(myfile, sql=mySql, sep=";")
  wDays <- strptime(paste(myData$Date, myData$Time), format='%d/%m/%Y %H:%M:%S')
  ## set png file device to draw the plot
  png(bg = "white", filename = "plot4.png", width = 480, height = 480 )
  
  par(mfrow=c(2,2))
  
  ## draw 1,1
  plot(wDays, myData$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  
  ## draw 1,2
  plot(wDays, myData$Voltage, type="l", xlab="datetime", ylab="voltage")
  
  ## draw 2,1
  plot(wDays,myData$Sub_metering_1,type="l", xlab="", ylab = "Energy sub metering")
  lines(wDays,myData$Sub_metering_2,type="l",xlab="", col="red")
  lines(wDays,myData$Sub_metering_3,type="l",xlab="", col="blue")
  legend("topright",cex=0.7, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## draw 2,2
  plot(wDays, myData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  
  ## close device
  dev.off()
}



