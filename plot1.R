library(dplyr)
library(reshape2)
library(ggplot2)
library(tidyr)
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
d <- subset(data, V1 =="1/2/2007" | V1 == "2/2/2007"  )
rm(data)
colnames(d) <- cvar
png("plot1.png", width = 480, height = 480)
hist(as.numeric(d$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

