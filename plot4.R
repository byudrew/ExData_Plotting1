
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


## Plot 4

# Save to png file
png(filename = "plot4.png", width=480, height=480)

# Set up 2x2 plotting
par(mfrow=c(2,2))

# Top left plot (Global Active Power)

# Create the plot and labels, but no lines
with(data, plot(Date, Global_active_power, 
                xlab="",
                ylab="Global Active Power",
                type="n"))

# Add lines to plot
with(data, lines(Date, Global_active_power),
     col="black")

# Top right plot (Voltage)

# Create the plot and labels, but no lines
with(data, plot(Date, Voltage, 
                xlab="datetime",
                ylab="Voltage",
                type="n"))

# Add line to plot
with(data, lines(Date, Voltage),
     col="black")

# Bottom left plot (Energy Sub Metering)

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

# Add a legend (without a box) to describe the lines
legend("topright",
       lty=1,
       bty="n",
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Bottom right plot (Global Reactive Power)

# Create the plot and labels, but no lines
with(data, plot(Date, Global_reactive_power, 
                xlab="datetime",
                ylab="Global_reactive_power",
                type="n"))

# Add line to plot
with(data, lines(Date, Global_reactive_power),
     col="black")

# End plotting
dev.off()
