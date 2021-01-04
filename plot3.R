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
png(file="plot3.png",
    width=480, height=480)

#plot a line graph of the Sub metering throughout the 2 days
plot(Power$DateTime,Power$Sub_metering_1,col="black",ylab="Energy sub metering",xlab="",type="l")

#Add two extra lines to show the sub metering 2 and 3
lines(Power$DateTime,Power$Sub_metering_2,col="red")
lines(Power$DateTime,Power$Sub_metering_3,col="blue")

#create a legend for the lines
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)


#closes device
dev.off()