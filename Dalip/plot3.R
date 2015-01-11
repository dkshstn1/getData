#READ DATA
data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

#SUBSET DATA FOR 2007 FEB 1 AND 2 
data2007 <- subset(data, data$Date=="1/2/2007" | data$Date=="2/2/2007")

#RE-DEFINE TIME VARIABLE AS DATE-TIME
data2007$Time <- paste(data2007$Date, data2007$Time)

#CONVERT DATE-TIME TO POSIX
data2007$Time <- strptime(data2007$Time, format="%d/%m/%Y %H:%M:%S")

#SET "?" TO NULL IN SUB_METERING VALUES
NAs <- data2007[,7:9] == "?"
is.na(data2007)[NAs] <- TRUE

#SET SUB_METERING VARIABLES AS NUMERIC (FROM FACTORS)
data2007$Sub_metering_1 <- as.numeric(as.character(data2007$Sub_metering_1))
data2007$Sub_metering_2 <- as.numeric(as.character(data2007$Sub_metering_2))
data2007$Sub_metering_3 <- as.numeric(as.character(data2007$Sub_metering_3))


#CREATE PNG FILE
png(file="plot3.png", 480, 480)

#PLOT LINE GRAPHS
plot(data2007$Time, data2007$Sub_metering_1, xlab="", ylab = "Energy sub metering", type="l")
lines(data2007$Time, data2007$Sub_metering_2, col = "red")
lines(data2007$Time, data2007$Sub_metering_3, col = "blue")

#ADD LEGEND
legend('topright', names(data2007[7:9]) , 
   lty=1, col=c('black', 'red', 'blue'), bty='0')

dev.off()
