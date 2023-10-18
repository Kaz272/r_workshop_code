# Install and load the testthat package if you haven't already
# install.packages("testthat")
library(testthat)

# Load your functions and data
source("GPTCode.R")  # Replace with the actual script file name
data <- airquality  # Replace with your dataset

# Write unit tests for calculateMonthlyAverages function
test_that("calculateMonthlyAverages calculates monthly averages correctly", {
  averages <- calculateMonthlyAverages(data)
  
  # Check if the resulting dataframe has the correct number of rows
  expect_equal(nrow(averages), 5)
  
  # Check if the 'avgSolar' column is numeric
  expect_is(averages$avgSolar, "numeric")
  
  # Check specific values for May, June, July, August, and September
  expect_equal(averages$avgSolar[averages$Month == 5], mean(data$Solar.R[data$Month == 5], na.rm = TRUE))
  expect_equal(averages$avgSolar[averages$Month == 6], mean(data$Solar.R[data$Month == 6], na.rm = TRUE))
  expect_equal(averages$avgSolar[averages$Month == 7], mean(data$Solar.R[data$Month == 7], na.rm = TRUE))
  expect_equal(averages$avgSolar[averages$Month == 8], mean(data$Solar.R[data$Month == 8], na.rm = TRUE))
  expect_equal(averages$avgSolar[averages$Month == 9], mean(data$Solar.R[data$Month == 9], na.rm = TRUE))
})

# Write unit tests for calculateMonthlyCorrelations function
test_that("calculateMonthlyCorrelations calculates monthly correlations correctly", {
  correlations <- calculateMonthlyCorrelations(data)
  
  # Check if the resulting dataframe has the correct number of rows
  expect_equal(nrow(correlations), 5)
  
  # Check if the 'correlation' column is numeric
  expect_is(correlations$correlation, "numeric")
  
  # Check specific values for May, June, July, August, and September
  expect_equal(correlations$correlation[correlations$Month == 5], cor(data$Ozone[data$Month == 5], data$Solar.R[data$Month == 5], use = "complete.obs"))
  expect_equal(correlations$correlation[correlations$Month == 6], cor(data$Ozone[data$Month == 6], data$Solar.R[data$Month == 6], use = "complete.obs"))
  expect_equal(correlations$correlation[correlations$Month == 7], cor(data$Ozone[data$Month == 7], data$Solar.R[data$Month == 7], use = "complete.obs"))
  expect_equal(correlations$correlation[correlations$Month == 8], cor(data$Ozone[data$Month == 8], data$Solar.R[data$Month == 8], use = "complete.obs"))
  expect_equal(correlations$correlation[correlations$Month == 9], cor(data$Ozone[data$Month == 9], data$Solar.R[data$Month == 9], use = "complete.obs"))
})

# Write unit tests for savePlots function
test_that("savePlots saves plots for each month", {
  # Create a test data frame with a few rows
  test_data <- data.frame(
    Month = c(5, 6, 6, 7, 7),
    Solar.R = c(100, 150, 200, 120, 180),
    Ozone = c(30, 40, 50, 35, 45)
  )
  
  # Call the savePlots function with the test data
  plots <- savePlots(test_data, "test_plot_")
  
  # Check if the plots list contains the expected number of elements
  expect_equal(length(plots), 3)  # Since there are three unique months in the test data
  
  # Define a character vector of expected month names
  expected_months <- c("may", "june", "july")
  
  # Add more specific tests here to check if files were created as expected
  for (month in expected_months) {
    expect_true(file.exists(paste0("test_plot_", month, ".png")))
  }
})

  