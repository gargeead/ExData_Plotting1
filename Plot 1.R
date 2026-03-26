# Load required libraries
library(data.table)


# Download and read the data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp, method = "curl")
data <- fread(unzip(temp, "household_power_consumption.txt"), 
              na.strings = "?",
              stringsAsFactors = FALSE)
unlink(temp)

# Convert Date column to Date class
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset data for 2007-02-01 and 2007-02-02
subset_data <- data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02", ]

# Convert Global_active_power to numeric
subset_data$Global_active_power <- as.numeric(subset_data$Global_active_power)

# Create plot1.png
png("plot1.png", width = 480, height = 480)

hist(subset_data$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()



