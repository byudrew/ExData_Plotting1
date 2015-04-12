
## Clean the data for the plotting
## Assumes that the zip file has been downloaded and extracted to local directory

# Read in the data, marking "?" as NA
data <- read.table("household_power_consumption.txt",
                   sep=";",
                   header=TRUE,
                   as.is=TRUE,
                   na.strings="?")

# Combine Date and Time
data$Date <- as.POSIXct(paste(data$Date, data$Time),
                        format="%d/%m/%Y %H:%M:%S")
data$Time <- NULL

# Subset the data to only include 2 specific days
data <- data[data$Date >= "2007-02-01" & data$Date < "2007-02-03",]

# Reject all rows with NA
data <- data[complete.cases(data),]


## Plot 3

# Save to png file (uses default transparent background, as in example files)
png(filename = "plot3.png", width=480, height=480)

# Create the plot and labels, no lines
with(data, plot(Date, Sub_metering_1, 
                xlab="",
                ylab="Energy sub metering",
                type="n"))

# Add lines for the three different measurements
with(data, lines(Date, Sub_metering_1,
                 col="black"))
with(data, lines(Date, Sub_metering_2,
                 col="red"))
with(data, lines(Date, Sub_metering_3,
                 col="blue"))

# Add a legend to describe the lines
legend("topright",
       lty=1,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# End plotting
dev.off()
