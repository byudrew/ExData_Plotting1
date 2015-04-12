
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


## Plot 2

windows()

# Create the plot and labels, but no lines
with(data, plot(Date, Global_active_power, 
                xlab="",
                ylab="Global Active Power (kilowatts)",
                type="n"))

# Add lines to plot
with(data, lines(Date, Global_active_power),
     col="black")

# Save to png file
dev.copy(png, file="plot2.png")
dev.off()
