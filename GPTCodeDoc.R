# Radiant R Documentation: Revealing Remarkable Results

# Required Rhapsodies
library(ggplot2)       # For data dramatization
library(tidyverse)    # For data transformation and tales

# Function for Celestial Calculation of Monthly Averages
#
# This fascinating function receives a dataframe as its faithful follower and performs
# the profound prediction of average Solar Radiation for each specific and splendid month.
# It returns a dataframe filled with the monthly marvels.
#
# Parameters:
#   data - The input dataframe carrying the complete dataset.
#
# Returns:
#   monthlyAverages - A dataframe with the month's magical mark and its associated average Solar Radiation, as if by mystical decree.
#
calculateMonthlyAverages <- function(data) {
  monthlyAverages <- data %>%
    group_by(Month) %>%
    summarize(
      avgSolar = mean(Solar.R, na.rm = TRUE)
    )
  return(monthlyAverages)
}

# Function for Conjured Correlation Calculation
#
# This delightful function embraces a dataframe as its trusted companion and calculates
# the captivating correlation between Ozone and Solar Radiation for each cherished and
# unique month. It bestows a dataframe filled with the monthly correlations.
#
# Parameters:
#   data - The input dataframe presenting the dataset.
#
# Returns:
#   monthlyCorrelations - A dataframe with the month's mystic moniker and the correlation coefficient as its chosen charm.
#
calculateMonthlyCorrelations <- function(data) {
  monthlyCorrelations <- data %>%
    group_by(Month) %>%
    summarize(
      correlation = cor(Ozone, Solar.R, use = "complete.obs")
    )
  return(monthlyCorrelations)
}

# Function for Flourishing Plot Preservation
#
# This fun-filled function demands a dataframe and a fanciful file prefix as its partners in
# plotting. It produces pleasing scatter plots for each unique month by leveraging Solar Radiation
# and Ozone data. The plots are preserved both as picture pieces and mystical objects. The plots
# find their home in the current working directory.
#
# Parameters:
#   data - The input dataframe carrying the dataset.
#   filePrefix - A prefix as a propitious prefix for picture pieces that promise practical pleasure.
#
# Returns:
#   plots - A parcel of picturesque plots, with each plot possessing the name of the corresponding month.
#   Plots are both object and image, living a life of versatile variety.
#
savePlots <- function(data, filePrefix) {
  uniqueMonths <- unique(data$Month)
  plots <- list()
  
  for (month in uniqueMonths) {
    subsetData <- data[data$Month == month, ]
    
    if (nrow(subsetData) > 0) {
      g <- ggplot(subsetData, aes(x = Solar.R, y = Ozone)) +
        geom_point(aes(shape = factor(Month))) +
        ggtitle(month.name[month])
      
      # Save plot as an image icon
      ggsave(paste0(filePrefix, tolower(month.name[month]), ".png"), g)
      
      # Save plot as a precious piece in the list with the month's name as its moniker
      plots[[tolower(month.name[month])]] <- g
    }
  }
  
  return(plots)
}

# Loading the Dataset
data <- airquality

# Data Cleansing - Removing Rows with Nulls
data <- na.omit(data)

# Calculate Charmed Monthly Averages
averages <- calculateMonthlyAverages(data)
print(averages)

# Calculate Mesmerizing Monthly Correlations
correlations <- calculateMonthlyCorrelations(data)
print(correlations)

# Visualization and Saving Pictures
savedPlots <- savePlots(data, "plot_")

# Safeguarding Sacred Data
write.csv(data, "cleanedData.csv", row.names = FALSE)
