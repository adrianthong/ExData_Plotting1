### Coursera Course 4: Exploratory Data Analysis
### Date: 4-Aug-2015
### Author: Adrian Thong
### Assignment 1: Plot 1 
### Input: household_power_consumption.txt
### Output: plot1.png
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

# open png file
png("plot1.png", width = 480, height = 480) 

# plot histogram 
hist(pdata$Global_active_power, col = "red", 
     main = "Global Active Power", 
     ylab = "Frequency", xlab = "Global Active Power (kilowatts)")

# close file 
dev.off()