source("utils.R") # load utility functions

# Create a 4 panel display for selected data over the
# specified set of dates.
#
# Parameters:
#   fname       Name of the power data file to read. 
#               Default is household_power_consumption.txt; may
#               use a subset for debugging.
#   cdates      Vector (character) of dates to include from
#               the data. Dates must be of the form "d/m/yyyy".
#
# Return:
#   File name of the plot graphic.
create_plot4 <- function(fname="household_power_consumption.txt",
                         cdates=c("1/2/2007","2/2/2007"))
{
    # get the target data from the full dataset
    target_data <- get_data( fname, cdates );

    # open the device (png file) to plot to
    plotfile <- open_dev("plot4");
    
    # partition the device into a 2x2 layout
    par( mfrow=c(2,2) );
        
    # create the four sub-plots
    # line plot of global active power
    plot( target_data$Timestamp,
          target_data$Global_active_power,
          xlab = "",
          ylab = "Global Active Power (kW)",
          col  = "black",
          type = "l" );

    # line plot of voltage
    plot( target_data$Timestamp,
          target_data$Voltage,
          xlab = "",
          ylab = "Voltage",
          col  = "black",
          type = "l" );
    
    # Sub-metering - lay all 3 sets on one panel
    # create plot with the first sub-metering values
    plot( target_data$Timestamp,
          target_data$Sub_metering_1, 
          type="l",
          ylab = "Energy sub-metering (Wh)",
          xlab="" );
    
    # overlay additional sub-metering values on existing plot
    lines( target_data$Timestamp,
           target_data$Sub_metering_2,
           col="red");
    lines( target_data$Timestamp,
           target_data$Sub_metering_3,
           col="blue" );
    
    # stick a legend on the plot
    legend( "topright",
            lwd=1,
            col=c("black","red", "blue"), 
            legend=c("Kitchen", "Laundry", "Water Heater & A/C"),
            cex = 0.75,
            ncol=1 );
    
    # line plot of global reactive power
    plot( target_data$Timestamp,
          target_data$Global_reactive_power,
          xlab = "",
          ylab = "Global Reactive Power (kW)",
          type = "l",
          col  = "black" );
    
    # close the device
    close_dev();
    plotfile;
}
