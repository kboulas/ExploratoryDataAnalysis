## Load data.  This would be more elegant to cover as an include file, but 
## I didn't have time to make that work.

## Choose the data file
dataFile <- file.choose()

## Read the data file using read.csv2
powerData <- read.csv2(dataFile)

## Convert column 1, Date, to a date format to enable subsetting the data
powerData$Date <- as.Date(powerData$Date, format = "%d/%m/%Y")

## Subset data to the included dates
fromDate <- as.Date("2007-02-01")
toDate <- as.Date("2007-02-02")
analysisData <- powerData[which(powerData$Date >= fromDate & powerData$Date <= toDate),]

## Create DateTime from subset of data
temp <- as.POSIXct(paste(analysisData$Date, analysisData$Time))
analysisData$DateTime <- temp

## coerce factors to numerics 
analysisData$Global_active_power <- as.numeric(analysisData$Global_active_power)
analysisData$Global_reactive_power <- as.numeric(analysisData$Global_reactive_power)
analysisData$Voltage <- as.numeric(analysisData$Voltage)
analysisData$Global_intensity <- as.numeric(analysisData$Global_intensity)
analysisData$Sub_metering_1 <- as.numeric(analysisData$Sub_metering_1)
analysisData$Sub_metering_2 <- as.numeric(analysisData$Sub_metering_2)
analysisData$Sub_metering_3 <- as.numeric(analysisData$Sub_metering_3)

## Create Plot
hist(analysisData$Global_active_power, main="Global Active Power", axes=FALSE, col="red", xlab="Global Active Power(in kilowatts)", ylab="Frequency", xlim=c(0,6000))
axis(1,at=seq(0,6000,1000), labels=c("0","","2","","4","","6"))
axis(2,at=seq(0,1200,200), labels=TRUE)

## Copy the plot to a png file
dev.copy(png, file="Plot1.png")
dev.off()