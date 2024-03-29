temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
t <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";", na.strings = "?")
unlink(temp)

#date formatting and subsetting:
t$Date <- as.Date(t$Date, "%d/%m/%Y")
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
t <- t[complete.cases(t),]
dateTime <- paste(t$Date, t$Time)
dateTime <- setNames(dateTime, "DateTime")
t <- t[ ,!(names(t) %in% c("Date","Time"))]
t <- cbind(dateTime, t)
t$dateTime <- as.POSIXct(dateTime)


#plotting
plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#output
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
