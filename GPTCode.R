library(ggplot2)
library(tidyverse)

# Function to calculate monthly averages
calculateMonthlyAverages <- function(data) {
  monthlyAverages <- data %>%
    group_by(Month) %>%
    summarize(
      avgSolar = mean(Solar.R, na.rm = TRUE)
    )
  return(monthlyAverages)
}

# Function to calculate monthly correlations
calculateMonthlyCorrelations <- function(data) {
  monthlyCorrelations <- data %>%
    group_by(Month) %>%
    summarize(
      correlation = cor(Ozone, Solar.R, use = "complete.obs")
    )
  return(monthlyCorrelations)
}

# Function to save plots as objects and image files
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

# Loading data
data <- airquality

# Data Cleaning - Remove rows with NA
data <- na.omit(data)

# Calculate monthly averages
averages <- calculateMonthlyAverages(data)
print(averages)

# Calculate monthly correlations
correlations <- calculateMonthlyCorrelations(data)
print(correlations)

# Visualization and save plots
savedPlots <- savePlots(data, "plot_")

# Save data
write.csv(data, "cleanedData.csv", row.names = FALSE)
