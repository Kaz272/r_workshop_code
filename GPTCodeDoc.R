# R Code Documentation

# Required Libraries
library(ggplot2)       # For data visualization
library(tidyverse)    # For data manipulation and analysis

# Function to Calculate Monthly Averages
#
# This function takes a data frame as input and calculates the average Solar Radiation
# for each unique month. It returns a data frame with the monthly averages.
#
# Parameters:
#   data - The input data frame containing the dataset.
#
# Returns:
#   monthlyAverages - A data frame with columns 'Month' and 'avgSolar' representing
#   the unique month and the corresponding average Solar Radiation, respectively.
#
calculateMonthlyAverages <- function(data) {
  monthlyAverages <- data %>%
    group_by(Month) %>%
    summarize(
      avgSolar = mean(Solar.R, na.rm = TRUE)
    )
  return(monthlyAverages)
}

# Function to Calculate Monthly Correlations
#
# This function takes a data frame as input and calculates the correlation between
# Ozone and Solar Radiation for each unique month. It returns a data frame with
# the monthly correlations.
#
# Parameters:
#   data - The input data frame containing the dataset.
#
# Returns:
#   monthlyCorrelations - A data frame with columns 'Month' and 'correlation' representing
#   the unique month and the corresponding correlation coefficient, respectively.
#
calculateMonthlyCorrelations <- function(data) {
  monthlyCorrelations <- data %>%
    group_by(Month) %>%
    summarize(
      correlation = cor(Ozone, Solar.R, use = "complete.obs")
    )
  return(monthlyCorrelations)
}

# Function to Save Plots as Objects and Image Files
#
# This function takes a data frame and a file prefix as input. It generates scatter plots
# for each unique month based on Solar Radiation and Ozone data. Plots are saved as both
# image files and objects. The plots are saved in the working directory.
#
# Parameters:
#   data - The input data frame containing the dataset.
#   filePrefix - A string to be used as a prefix for the saved image files.
#
# Returns:
#   plots - A list of scatter plots, where each plot is named after the corresponding month.
#   Plots are saved as both objects and image files.
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
      
      # Save plot as an image file
      ggsave(paste0(filePrefix, tolower(month.name[month]), ".png"), g)
      
      # Save plot as an object in the list with the month name as the key
      plots[[tolower(month.name[month])]] <- g
    }
  }
  
  return(plots)
}

# Loading Data
data <- airquality

# Data Cleaning - Remove rows with NA
data <- na.omit(data)

# Calculate Monthly Averages
averages <- calculateMonthlyAverages(data)
print(averages)

# Calculate Monthly Correlations
correlations <- calculateMonthlyCorrelations(data)
print(correlations)

# Visualization and Save Plots
savedPlots <- savePlots(data, "plot_")

# Save Data
write.csv(data, "cleanedData.csv", row.names = FALSE)
