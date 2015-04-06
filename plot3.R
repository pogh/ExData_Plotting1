# Read the dates and times as a string as this is the easiest
x <- read.csv(file = "household_power_consumption.txt", sep=";", na.strings=c("?"), colClasses = c("character", "character", rep("numeric", 7)))

# Convert to time string to a date time type
x <- within(x, Time <- strptime(paste(x$Date, x$Time), "%d/%m/%Y %H:%M:%S"))

# Convert the date string into a real date type
x <- within(x, Date <- as.Date(Date, format = "%d/%m/%Y"))

# Filter the data to the two days we want
x <- x[x$Date == as.Date("2007-02-01", format = "%Y-%m-%d") | x$Date == as.Date("2007-02-02", format = "%Y-%m-%d"),]

# Create the graphic device
png(filename = "plot3.png", width = 480, height = 480)

# Create the graph
plot(x$Time, apply(x[, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")], 1, max), type = "n", ylab = "Energy sub metering", xlab = "")
lines(x$Time, x$Sub_metering_1, col = "black")
lines(x$Time, x$Sub_metering_2, col = "red")
lines(x$Time, x$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

# Close the graphics device
dev.off()

# Clean up
rm(x)