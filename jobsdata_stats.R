# Load necessary libraries
library(readxl)
library(dplyr)   # Importing dplyr for data manipulation

# Read Excel file into a data frame
jobs_data_clustered <- read_excel(
  "~/Dropbox/Consulting/Hnet/h-net_jobs/hnet_job-guide_data/jobsdata-clustered.xlsx",
  col_types = c("numeric", "text", "text", "skip", "text", "skip",
                "text", "text", "numeric", "numeric", "text", "text",
                "text", "text", "text", "text")
)

# View the data frame in RStudio (optional)
View(jobs_data_clustered)

# Assign data frame to a new variable
jobs <- jobs_data_clustered

# Calculate annual totals
annual_totals <- table(jobs$year)

# Print annual totals
annual_totals

# Calculate the annual tenure track table
annual_tt <- table(jobs$tenure_track, jobs$year)

# Print the tenure track table
annual_tt

# Perform Chi-squared test on the tenure track table
chisq.test(annual_tt, correct = TRUE)

# Load chisq.posthoc.test library for posthoc analysis
library(chisq.posthoc.test)

# Perform post-hoc chi-squared test with Bonferroni correction on tenure track data
chisq.posthoc.test(annual_tt, method = "bonferroni")

# Years correlated with whether position postings were TT or not:
# 2010, 2013, 2015, 2016, 2017, 2020, 2021, and 2024.

# Calculate the annual type table
annual_type <- table(jobs$type, jobs$year)

# Perform Chi-squared test on the type table
chisq.test(annual_type, correct = TRUE)

# Perform post-hoc chi-squared test with Bonferroni correction on type data
annual_type_posthoc <- chisq.posthoc.test(annual_type, method = "bonferroni")

# Convert post-hoc test results to a data frame
annual_type_posthoc_df <- as.data.frame(annual_type_posthoc)

# Write the post-hoc test results to a CSV file
write.csv(annual_type_posthoc_df,
          "~/Dropbox/Consulting/Hnet/annual_type_posthoc.csv")

# Let the user know the CSV has been written successfully (optional)
message("Post-hoc test results written to 'annual_type_posthoc.csv'")


