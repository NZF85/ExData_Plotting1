## use read.csv to get the text file details
## headers are true; separation by ";", all strings with "?" are na, 
## R will convert column names that are not valid variable names (e.g. contain spaces or special characters or start with numbers) 
## into valid variable names, e.g. by replacing spaces with dots.
## stringasFactors is false to prevent them from being converted into factors
## coment.char = ""  turn off the interpretation of comments altogether
## quote ='\"' means single quotes will be treated as string delimiters. 
## The backslash in front of the single quotes is to say we mean the single-quote symbol and not the end of the parameter value

data_full <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                      na.strings = "?", check.names = F, 
                      stringsAsFactors = F,  comment.char = "", quote = '\"')

##use the as.Date( ) function to convert character data to dates. The format is as.Date(x, "format"), 
##where x is the character data and format gives the appropriate format.
## %d = day as a number (0-31), %m = month (00-12), %Y = 4-digit year
data_full$Date <- as.Date(data_full$Date, format = "%d/%m/%Y")

## Subsetting the data
data <- subset(data_full, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

##Open a graphics device.
##The default graphics device in R is your computer screen. 
##To save a plot to an image file, you need to tell R to open a new type of device — 
##in this case, a graphics file of a specific type, such as PNG, PDF, or JPG.

##The R function to create a PNG device is png(). Similarly, you create a PDF device with pdf() and a JPG device with jpg().
##Create the plot.
##Close the graphics device. You do this with the dev.off() function.
png(filename = "plot4.png",
    width = 480, height = 480)
## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#plot4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})

dev.off()
