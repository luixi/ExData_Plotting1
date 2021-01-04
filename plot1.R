library(dplyr)

#reads the .txt table for the necessary information
Power<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

#Transforms the Date column from character to Date
Power<-mutate(Power,Date=as.Date(Date,format="%d/%m/%Y"))

#create 2 variables to be able to get a subset of the range
Date1<-as.Date("2007-02-01")
Date2<-as.Date("2007-02-02")

#Get subset to only view data from 2 days
Power<-Power[Power$Date>=Date1&Power$Date<=Date2,]

#create a new column including date and time to be able to graph the information correctly
Power$DateTime<-as.POSIXct(paste(Power$Date, Power$Time), format="%Y-%m-%d %H:%M:%S")

#opens the device to save the plot as .png file with 480x480 dimensions
png(file="plot1.png",
    width=480, height=480)

#create a histogram of Global active power and its frequency
hist(as.numeric(Power$Global_active_power),main="Global Active Power",col = "red",xlab = "Global Active Power (kilowatts)",ylab = "Frequency")

#closes device
dev.off()