### Coursera Course 4: Exploratory Data Analysis
### Date: 4-Aug-2015
### Author: Adrian Thong
### Assignment 1: Plot 4
### Input: household_power_consumption.txt
### Output: plot4.png
### Description: 
### Read only lines for the dates 1/2/2007 and 2/2/2007
### Convert to PNG file as required by Assignment 1 plot 


# read through file for lines with dates 1/2/2007 and 2/2/2007
# critical assumption: data is sorted by date
selectedrows <- grep(glob2rx("^1/2/2007*|^2/2/2007*"), 
                     readLines(".\\household_power_consumption.txt"))

# load only the required lines to memory
pdata <- read.table(".\\household_power_consumption.txt", 
                    sep = ";", na.strings = "?", 
                    dec = ".", stringsAsFactors = FALSE, 
                    skip = selectedrows[1], nrows = length(selectedrows))

# populate the column names 
colnames(pdata) <- read.table(".\\household_power_consumption.txt", 
                              sep = ";", stringsAsFactors = FALSE, 
                              nrows = 1)

# convert dates
datetime <- paste(pdata$Date, pdata$Time, sep = " ")
datetime <- strptime(datetime,"%d/%m/%Y %H:%M:%S", tz = "GMT")

# open png file
png("plot4.png", width = 480, height = 480) 

# set 4 plots on one page
par(mfrow = c(2, 2))

# plot 1 
plot(datetime, pdata$Global_active_power, type = "l", 
     ylab = "Global Active Power", xlab = "")

# plot 2
plot(datetime, pdata$Voltage, type = "l", 
     ylab = "Voltage")

# plot 3
plot(datetime, pdata$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")

# plot 3: add lines
lines(datetime, pdata$Sub_metering_2, type = "l", col = "red")
lines(datetime, pdata$Sub_metering_3, type = "l", col = "blue")

# plot 3: add legend
legend("topright", lty = 1, bty = "n",
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot 4 
plot(datetime, pdata$Global_reactive_power, type = "l",
     ylab = 'Global_reactive_power')

# close file 
dev.off()