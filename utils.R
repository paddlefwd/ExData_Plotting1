# Shared utility functions used by all the plotting functions.
library("data.table",quietly=TRUE);

# Read the power consumption data from the given file for
# the specified dates.
#
# Parameters:
#   fname       File name to read.
#   cdates      Vector of dates to subset from full read.
#
# Return:
#   The data.table of power consumption data for the given dates.  
get_data <- function( fname, cdates )
{
    # read the dataset and slice out the days of interest
    # don't convert the date/time types here, just treat as character data
    full_set <- as.data.table(read.table( fname,
                                          header=TRUE, 
                                          sep=";",
                                          na.strings="?",
                                          colClasses=c("character",
                                                       "character",
                                                       "numeric", 
                                                       "numeric", 
                                                       "numeric", 
                                                       "numeric",
                                                       "numeric", 
                                                       "numeric",
                                                       "numeric" )));
    
    # slice out the target subset into a new table
    #
    # Note: we are doing the slice based on a string comparison
    #       of the date rather than converting to a Date object
    #       before doing the comparison. The Date compare is faster
    #       than string compare, but is was *much* slower to convert
    #       every date and then compare than to do the string compare
    #       and then convert just the subset.
    target <- subset( data.table(full_set), Date %in% cdates );
    
    # merge the date and time character data into a new column
    # in the table containing a single POSIXct timestamp.
    target[,Timestamp:=as.POSIXct(strptime(paste(Date,Time),
                                           "%d/%m/%Y %H:%M:%S"))];
}

# Open a 480x480 pixel .png file as the device
# 
# Parameters:
#   fname       The name of the file to use as the device
#               with or without the .png extension.
#
# Return:
#   The filename of the device. 
open_dev <- function(fname) {

    # check to see if we have already specified a .png file
    if ( grepl( "\\.png", fname ) ) {
        # if we do, just use the filename
        devfile <- fname;
    } else {
        # append .png to the base name
        devfile <- paste( fname,".png", sep="" );
    }

    # open the png device
    png( filename = devfile, width = 480, height = 480, units = "px" );
    devfile;
}

# Close the device (.png file).
#
# Return:
#   None.
close_dev <- function() {
    # assume that we want to close the current device
    # (no device lookup)
    invisible(dev.off());
}
