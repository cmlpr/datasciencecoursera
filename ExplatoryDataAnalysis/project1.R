setwd("/Users/cemalperozen/Documents/Repos/datasciencecoursera/ExplatoryDataAnalysis")
dir()
dir("Data/")
unzip("Data/household_power_consumption.zip", exdir = "Data/")
dir("Data/")
?read.csv
hpcRaw <- read.table("Data/household_power_consumption.txt",
                     header = TRUE,
                     sep = ";",
                     na.strings = "?",
                     #nrows = 5,
                     colClasses = c("character", "character", "numeric", "numeric",
                                    "numeric", "numeric", "numeric",
                                    "numeric", "numeric")) 

hpcRaw[100000,]
DT <- paste(hpcRaw$Date, hpcRaw$Time)
DT <- strptime(DT, "%d/%m/%Y %H:%M:%S")
DT[1]
str(DT)
hpcRaw$DT <- DT
hpcRaw$Date <- as.Date(hpcRaw$Date, "%d/%m/%Y")
hpcRaw$Time <- strptime(hpcRaw$Time, "%H:%M:%S")
head(hpcRaw)
str(hpcRaw)

hpcPlot <- hpcRaw[which((hpcRaw$Date == as.Date("1/2/2007", "%d/%m/%Y")) | (hpcRaw$Date == as.Date("2/2/2007", "%d/%m/%Y"))), ]
str(hpcPlot)

hist(hpcPlot$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

with(hpcPlot, 
     plot(DT, 
          Global_active_power, 
          type = "n",
          ylab = "Global Active Power (kilowatts)",
          xlab = ""))
lines(hpcPlot$DT,hpcPlot$Global_active_power, xlab = NULL)


with(hpcPlot, 
     plot(DT, Sub_metering_1, type = "n",
          ylab = "Energy sub metering",
          xlab = ""),
     plot(DT, Sub_metering_2, type = "n",
          ylab = "Energy sub metering",
          xlab = ""),
     plot(DT, Sub_metering_2, type = "n",
          ylab = "Energy sub metering",
          xlab = ""),
     )
lines(hpcPlot$DT,hpcPlot$Sub_metering_1, col = "black")
lines(hpcPlot$DT,hpcPlot$Sub_metering_2, col = "red")
lines(hpcPlot$DT,hpcPlot$Sub_metering_3, col = "blue")
legend("topright", lwd = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


par(mfrow = c(2,2))

with(hpcPlot, 
     plot(DT, 
          Global_active_power, 
          type = "n",
          ylab = "Global Active Power (kilowatts)",
          xlab = ""))
lines(hpcPlot$DT,hpcPlot$Global_active_power, xlab = NULL)

with(hpcPlot, 
     plot(DT, 
          Voltage, 
          type = "n",
          ylab = "Voltage",
          xlab = "datetime"))
lines(hpcPlot$DT,hpcPlot$Voltage)

with(hpcPlot, 
     plot(DT, Sub_metering_1, type = "n",
          ylab = "Energy sub metering",
          xlab = ""),
     plot(DT, Sub_metering_2, type = "n",
          ylab = "Energy sub metering",
          xlab = ""),
     plot(DT, Sub_metering_2, type = "n",
          ylab = "Energy sub metering",
          xlab = ""),
)
lines(hpcPlot$DT,hpcPlot$Sub_metering_1, col = "black")
lines(hpcPlot$DT,hpcPlot$Sub_metering_2, col = "red")
lines(hpcPlot$DT,hpcPlot$Sub_metering_3, col = "blue")
legend("topright", lwd = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(hpcPlot, 
     plot(DT, 
          Global_reactive_power, 
          type = "n",
          ylab = "Global Reactive Power (kilowatts)",
          xlab = "datetime"))
lines(hpcPlot$DT,hpcPlot$Global_reactive_power)
