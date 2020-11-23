## Read + name + subset Household Power Consumption dataset
house <- read.table("household_power_consumption.txt", skip=1, sep=";")
names(house) <- c("Date","Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
subhouse <- subset(house, house$Date == "1/2/2007" | house$Date == "2/2/2007")

## Basic plot function
hist(as.numeric(as.character(subhouse$Global_active_power)), col = "red", main = "Global Active Power", xlab = "Global Active Power(kilowatts)")

## Save plot to png file
png("plot1.png", width=480, height=480)

## Annotate graph
title(main = "Global Active Power")
dev.off()
