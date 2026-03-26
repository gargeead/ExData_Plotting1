
# plot 4 ------------------------------------------------------------------
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp, method = "curl")

data <- read.table("household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   stringsAsFactors = FALSE,
                   na.strings = "?")
unlink(temp)


# Subset to the two dates of interest
data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))

# Combine Date and Time into a single POSIXct datetime column
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time), 
                                     format = "%d/%m/%Y %H:%M:%S"))

# Open PNG device
png(filename = "plot4.png", width = 480, height = 480)

# Set up 2x2 panel
par(mfrow = c(2, 2))

# Define reusable tick positions
at_ticks <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))

# --- Plot 1: Global Active Power (top-left) ---
plot(data$DateTime, data$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n")
axis.POSIXct(1, at = at_ticks, format = "%a")

# --- Plot 2: Voltage (top-right) ---
plot(data$DateTime, data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt = "n")
axis.POSIXct(1, at = at_ticks, format = "%a")

# --- Plot 3: Energy Sub Metering (bottom-left) ---
plot(data$DateTime, data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
axis.POSIXct(1, at = at_ticks, format = "%a")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n")  # no box around legend to match plot

# --- Plot 4: Global Reactive Power (bottom-right) ---
plot(data$DateTime, data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     xaxt = "n")
axis.POSIXct(1, at = at_ticks, format = "%a")

dev.off()