# This R script reads the data and Plots inside file Plot3.png

#------- Step 1 Reading Raw Data -----------------------------------------------------
library(data.table)
#------ Reading files and variable naming --------------------------------------------
# set the directory where the assignment zip data files are unzipped
file_path      <- "C:/Users/Shrisingh/Documents/Courseera/Rprograming/Electric_power_consumption/"

# read household electric consumption .txt file(s)
ecs2        <- fread(paste0(file_path,"household_power_consumption.txt"),na.strings = "?",
                    autostart=1L,skip="1/2/2007", nrows = 60*24*2) #Reads data for only required period only 
                                                                   # Also takes care for NA representation
        # This method lacks reading the column headers so following code reads the headers
ecs1        <- fread(paste0(file_path,"household_power_consumption.txt"),na.strings = "?",header = TRUE, nrows =0)
names(ecs2) <- names(ecs1)                                    # Copies headers to the data set

ecs2$DT     <- paste0(ecs2$Date,ecs2$Time)                    # Create a column that concatenates the date and time columns  
ecs2$Date   <- as.Date(ecs2$Date,format="%d/%m/%Y")           # Coverts Date to Date Type
ecs2$Time3  <- as.POSIXct(ecs2$DT, format="%d/%m/%Y%H:%M:%S") # Creates the column for datetime

#------- Step 2 Create and Save the Plot ---------------------------------------------------
png(filename = "Plot3.png",width = 480, height = 480, units = "px", pointsize = 12,bg = "white")
# Create Plot3 : Overlayed Line charts by Sub_Metering
# Plot 3
with(ecs2,plot(Time3,Sub_metering_1, type = "n", xlab = "",ylab = "Energy Sub Metering"))
with(ecs2,lines(Time3,Sub_metering_1, col="black"))
with(ecs2,lines(Time3,Sub_metering_2, col="red"))
with(ecs2,lines(Time3,Sub_metering_3, col="blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col=  c("black","red","blue"))
dev.off() # close device save file
#------- End of Code--------------------------------------------------------------------------------------------