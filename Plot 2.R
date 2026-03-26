# png 2 -------------------------------------------------------------------

# Load required libraries
library(data.table)

# Download and read the data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp, method = "curl")


# Read dataset
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
png(filename = "plot2.png", width = 480, height = 480)

plot(data$DateTime, data$Global_active_power,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")

axis.POSIXct(1,
             at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
             format = "%a")

dev.off()
