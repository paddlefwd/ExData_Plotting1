source("utils.R") # load utility functions

# Create a line plot of global active power usage
# over the specified set of dates.
#
# Parameters:
#   fname       Name of the power data file to read. 
#               May be a subset of the full household_power_consumption.txt.
#   cdates      Vector (character) of dates to include from
#               the data. Dates must be of the form "d/m/yyyy".
#
# Return:
#   File name of the plot graphic.
create_plot2 <- function( fname="household_power_consumption.txt",
                          cdates=c("1/2/2007","2/2/2007") ) {
    # open the device (png file) to plot to
    plotfile <- open_dev( "plot2" ); 

    # get the target data from the full dataset
    target_data <- get_data( fname, cdates );

    plot( target_data$Timestamp,
          target_data$Global_active_power,
          type="l",
          ylab = "Global Active Power (kW)",
          xlab="")

    # close the device
    close_dev();
    plotfile;
}
