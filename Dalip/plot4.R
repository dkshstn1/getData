#READ DATA
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

#SUBSET DATA FOR 2007 FEB 1 AND 2 
data2007 <- subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")

#RE-DEFINE TIME VARIABLE AS DATE-TIME
data2007$Time <- paste(data2007$Date, data2007$Time)

#CONVERT DATE-TIME TO POSIX
data2007$Time <- strptime(data2007$Time, format="%d/%m/%Y %H:%M:%S")

#SET "?" TO NULL IN SUB_METERING VALUES
NAs <- data2007[,3:9] == "?"
is.na(data2007)[NAs] <- TRUE

#SET VARIABLES AS NUMERIC (FROM FACTORS)
data2007$Global_active_power <- as.numeric(as.character(data2007 $Global_active_power))
data2007$Global_reactive_power <- as.numeric(as.character(data2007$Global_reactive_power))
data2007$Voltage <- as.numeric(as.character(data2007$Voltage))
data2007$Sub_metering_1 <- as.numeric(as.character(data2007$Sub_metering_1))
data2007$Sub_metering_2 <- as.numeric(as.character(data2007$Sub_metering_2))
data2007$Sub_metering_3 <- as.numeric(as.character(data2007$Sub_metering_3))


#CREATE PNG FILE
png(file="plot4.png", 480, 480)

#SET 4 GRAPHS IN 2 ROWS AND 2 COLUMNS AND FILL BY ROWS
par(mfrow=c(2,2))

#DRAW LINE GRAPH ROW 1 COLUMN 1
plot(data2007$Time, data2007$Global_active_power, xlab="", ylab = "Global Active Power", cex = 0.3, type="l")

#DRAW LINE GRAPH ROW 1 COLUMN 2
plot(data2007$Time, data2007$Voltage, xlab="datetime", ylab = "Voltage", type="l")

#PLOT LINE GRAPH ROW 2 COLUMN 1
plot(data2007$Time, data2007$Sub_metering_1, xlab="", ylab = "Energy sub metering", cex = 0.8, type="l")
lines(data2007$Time, data2007$Sub_metering_2, col = "red")
lines(data2007$Time, data2007$Sub_metering_3, col = "blue")

#ADD LEGEND TO GRAPH ROW 2 COLUMN 1
legend('topright', names(data2007[7:9]) , 
   lty=1, cex = 0.9, col=c('black', 'red', 'blue'), bty='n')

#DRAW LINE GRAPH ROW 2 COLUMN 2
plot(data2007$Time, data2007$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", cex = 0.8, type="l")


dev.off()
