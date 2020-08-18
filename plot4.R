library(dplyr)
library(reshape2)
library(ggplot2)
library(tidyr)
library(lattice)
filename <- "exdata_data_household_power_consumption.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}  

if(!file.exists("household_power_consumption.txt"))
{
  unzip(filename)
}
data <- read.table("household_power_consumption.txt", sep = ";")
cvar <- data[1,]
d <- subset(data, V1 =="1/2/2007" | V1 == "2/2/2007")
colnames(d) <- cvar
day <-d$Date
time <- d$Time
dt <- strptime(paste(day,time,sep = ""), format = "%d/%m/%Y %H:%M:%S")
gap <- as.numeric(d$Global_active_power)
volt <- as.numeric(d$Voltage)
grp <- as.numeric(d$Global_reactive_power)
png("plot4.png", width = 580, height = 580)
par(mfcol = c(2,2), mar = c(2,3.8,1,1))
plot(dt,gap, ylab = "Global Active Power (kilowatts)",xlab = "", type = "l")
plot(dt,sub1, ylab = "Energy Sub metering",xlab = "", type = "n")
points(x = dt,y = sub1, type = "l")
points(x = dt,y = sub2, type = "l", col = "red")
points(x = dt,y = sub3, type = "l", col = "blue")
legend ("topright", lty=1, col=c("black", "red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(dt,volt, ylab = "Voltage",xlab = "datetime", type = "l")
plot(dt,grp, ylab = "Global_reactive_power",xlab = "datetime", type = "l")
dev.off()

