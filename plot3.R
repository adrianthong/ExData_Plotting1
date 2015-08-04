### Coursera Course 4: Exploratory Data Analysis
### Date: 4-Aug-2015
### Author: Adrian Thong
### Assignment 1: Plot 3
### Input: household_power_consumption.txt
### Output: plot3.png
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
png("plot3.png", width = 480, height = 480) 

# plot line chart
plot(datetime, pdata$Sub_metering_1, type = "l", 
     ylab = "Energy sub metering", xlab = "")

# add lines
lines(datetime, pdata$Sub_metering_2, type = "l", col = "red")
lines(datetime, pdata$Sub_metering_3, type = "l", col = "blue")

# add legend
legend("topright", lty = 1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# close file 
dev.off()