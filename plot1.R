#READ DATA
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

#SUBSET THE DATA FOR 2007 FEB 1 AND 2
data2007 <- subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")

#CONVERT GLOBAL ACTIVE POWER VARIABLE TO NUMERIC
data2007$Global_active_power <- as.numeric(as.character(data2007$Global_active_power))

#OPEN PNG FILE
png(file="plot1.png", 480, 480)

#CREATE HISTOGRAM
hist(data2007$Global_active_power, xlab = "Global Active Power (kilowatts)", main= "Global Active Power", col ="red")

#STOP PNG DEVICE
dev.off()
