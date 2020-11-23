## Read + name + subset Household Power Consumption dataset
house <- read.table("household_power_consumption.txt", skip=1, sep=";")
names(house) <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
subhouse <- subset(house, house$Date == "1/2/2007" | house$Date == "2/2/2007")

# Transforming Date and Time variables from characters to objects of type Date and POSIXlt alike:
subhouse$Date <- as.Date(subhouse$Date, format="%d/%m/%Y")
subhouse$Time <- strptime(subhouse$Time, format="%H:%M:%S")
subhouse[1:1440,"Time"] <- format(subhouse[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subhouse[1441:2880,"Time"] <- format(subhouse[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# Save plot to png file
png("plot4.png", width=480, height=480)

# Composite Plot with many graphs:
par(mfrow = c(2, 2))

# Plot function to render 4 plots
with(subhouse,{
    plot(subhouse$Time,as.numeric(as.character(subhouse$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
    plot(subhouse$Time,as.numeric(as.character(subhouse$Voltage)), type="l",xlab="datetime",ylab="Voltage")
    plot(subhouse$Time,subhouse$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
    with(subhouse,lines(Time,as.numeric(as.character(Sub_metering_1))))
    with(subhouse,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
    with(subhouse,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
    plot(subhouse$Time,as.numeric(as.character(subhouse$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()
