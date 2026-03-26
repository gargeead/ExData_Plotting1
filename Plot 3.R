
# plot 3 ------------------------------------------------------------------
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
png(filename = "plot3.png", width = 480, height = 480)

# Plot Sub_metering_1 (black) - suppress x-axis
plot(data$DateTime, data$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n")

# Manually add x-axis with day name labels (Thu, Fri, Sat)
axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             format = "%a")

# Add Sub_metering_2 (red)
lines(data$DateTime, data$Sub_metering_2, col = "red")

# Add Sub_metering_3 (blue)
lines(data$DateTime, data$Sub_metering_3, col = "blue")

# Add legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)

# Close PNG device
dev.off()