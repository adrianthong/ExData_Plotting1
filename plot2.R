### Coursera Course 4: Exploratory Data Analysis
### Date: 4-Aug-2015
### Author: Adrian Thong
### Assignment 1: Plot 2
### Input: household_power_consumption.txt
### Output: plot2.png
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
png("plot2.png", width = 480, height = 480) 

# plot line chart 
plot(datetime, pdata$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xlab = "")

# close file 
dev.off()