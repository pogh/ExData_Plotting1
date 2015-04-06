# Read the dates and times as a string as this is the easiest
x <- read.csv(file = "household_power_consumption.txt", sep=";", na.strings=c("?"), colClasses = c("character", "character", rep("numeric", 7)))

# Convert the date string into a real date type
x <- within(x, Date <- as.Date(Date, format = "%d/%m/%Y"))

# Filter the data to the two days we want
x <- x[x$Date == as.Date("2007-02-01", format = "%Y-%m-%d") | x$Date == as.Date("2007-02-02", format = "%Y-%m-%d"),]

# Create the graphic device
png(filename = "plot1.png", width = 480, height = 480)

# Create the graph
hist(x$Global_active_power, ylab = "Frequency", xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

# Close the graphics device
dev.off()

# Clean up
rm(x)