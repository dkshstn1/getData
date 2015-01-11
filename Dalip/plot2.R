#READ DATA
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

#SUBSET THE DATA FOR 2007 FEB 1 AND 2
data2007 <- subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")

#CONVERT TIME TO DATE-TIME
data2007$Time <- paste(data2007$Date, data2007$Time)

#CONVERT DATE-TIME TO POSIX
data2007$Time <- strptime(data2007$Time, format="%d/%m/%Y %H:%M:%S")

#CONVERT GLOBAL ACTIVE POWER TO NUMERIC (FROM FACTOR)
data2007$Global_active_power <- as.numeric(as.character(data2007$Global_active_power))

#CREATE PNG FILE
png(file="plot2.png", 480, 480)

#DRAW LINE GRAPH
plot(data2007$Time, data2007$Global_active_power, xlab="", ylab = "Global Active Power (kilowatts)", type="l")

dev.off()
