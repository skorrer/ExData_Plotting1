## Download power consumption data
library(lubridate)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="electric.zip")
unzip("electric.zip")
power <- read.table("./household_power_consumption.txt", sep=";", header=TRUE)

## Subset to two dates: 2007-02-01 and 2007-02-02
power$date_format <- as.Date(power$Date, format="%d/%m/%Y")
power_sub <- subset(power, date_format >= "2007-02-01" & date_format <= "2007-02-02")

## Generate the first PNG
barplot(table(cut(as.numeric(power_sub$Global_active_power), breaks=seq(0,8, by=0.5))), main="Global Active Power", col="red", ylab="Frequency", xlab="Gloabl Active Power (kilowatts)", names.arg=c("0", "", "", "", "2", "", "", "4", "", "", "", "6", "", "", "", ""))
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

## Generate the second PNG
power_sub$row_num <- seq.int(nrow(power_sub))
plot(power_sub$row_num, power_sub$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="n", xaxt="n")
lines(power_sub$row_num, power_sub$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="")
axis(1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

## Generate the third PNG
plot(power_sub$row_num, power_sub$Sub_metering_1, ylab="Energy sub metering", xlab="", type="n", xaxt="n")
lines(power_sub$row_num, power_sub$Sub_metering_1, ylab="Energy sub metering", xlab="")
lines(power_sub$row_num, power_sub$Sub_metering_2, ylab="Energy sub metering", xlab="", col="red")
lines(power_sub$row_num, power_sub$Sub_metering_3, ylab="Energy sub metering", xlab="", col="blue")
axis(1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))
legend(x="topright", lty=c(1,1,1), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
