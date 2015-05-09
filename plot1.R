source("utils.R") # load utility functions

# Create a histogram for the global active power
# over the specified set of dates.
#
# Parameters:
#   fname       Name of the power data file to read. 
#   cdates      Vector (character) of dates to include from
#               the data. Dates must be of the form "d/m/yyyy".
#
# Return:
#   File name of the plot graphic.
create_plot1 <- function( fname="household_power_consumption.txt",
                          cdates=c("1/2/2007","2/2/2007") ) {
    # open the device (png file) to plot to
    plotfile <- open_dev( "plot1" ); 
    
    # get the target data from the full dataset
    target_data <- get_data(fname,cdates);
    
    # plot the histogram
    hist( target_data$Global_active_power,
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)",
          col="red" );
 
    # close the device
    close_dev();
    plotfile;
}
