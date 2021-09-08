## Download power consumption data
library(lubridate)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="electric.zip")
unzip("electric.zip")
power <- read.table("./household_power_consumption.txt", sep=";", header=TRUE)

## Subset to two dates: 2007-02-01 and 2007-02-02
power$date_format <- as.Date(power$Date, format="%d/%m/%Y")
power_sub <- subset(power, date_format >= "2007-02-01" & date_format <= "2007-02-02")
power_sub$row_num <- seq.int(nrow(power_sub))

## Generate the fourth PNG
par(mfrow=c(2,2))

plot(power_sub$row_num, power_sub$Global_active_power, ylab="Global Active Power", xlab="", type="n", xaxt="n")
lines(power_sub$row_num, power_sub$Global_active_power, ylab="Global Active Power", xlab="")
axis(1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))

plot(power_sub$row_num, power_sub$Voltage, ylab="Voltage", xlab="datetime", type="n", xaxt="n")
lines(power_sub$row_num, power_sub$Voltage)
axis(1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))

plot(power_sub$row_num, power_sub$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n", xaxt="n")
lines(power_sub$row_num, power_sub$Sub_metering_1, ylab="Energy sub metering", xlab="")
lines(power_sub$row_num, power_sub$Sub_metering_2, ylab="Energy sub metering", xlab="", col="red")
lines(power_sub$row_num, power_sub$Sub_metering_3, ylab="Energy sub metering", xlab="", col="blue")
axis(1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))
legend(x="topright", lty=c(1,1,1), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), cex=0.5)

plot(power_sub$row_num, power_sub$Global_reactive_power, ylab="global_reactive_power", xlab="datetime", type="n", xaxt="n")
lines(power_sub$row_num, power_sub$Global_reactive_power)
axis(1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()