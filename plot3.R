source("utils.R") # load utility functions

# Create a multi-variable line plot for the sub-metering usage
# over the specified set of dates.
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
create_plot3 <- function( fname="household_power_consumption.txt",
                          cdates=c("1/2/2007","2/2/2007") )
{
    # open the device (png file) to plot to
    plotfile <- open_dev( "plot3" ); 

    # get the target data from the full dataset
    target_data <- get_data( fname, cdates );

    # create plot with the first sub-metering values
    plot( target_data$Timestamp,
          target_data$Sub_metering_1,
          type="l",
          ylab = "Energy sub metering",
          xlab="" );

    # overlay additional sub-metering values on existing plot
    lines( target_data$Timestamp, target_data$Sub_metering_2, col="red" );
    lines( target_data$Timestamp, target_data$Sub_metering_3, col="blue" );
    
    # stick a legend on the plot
    legend( "topright",
            ncol=1,
            lwd=1,
            col=c("black","red", "blue"), 
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
    
    # close the device
    close_dev();
    plotfile;
}
