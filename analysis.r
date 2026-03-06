# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------

# Load libraries -------------------
# You may use base R or tidyverse for this exercise

install.packages("pacman")
library(pacman)
pacman::p_load(tidyverse) # TODO: note to self - add other packages here as needed

# Load data here ----------------------
# Load each file with a meaningful variable name.

# Import RNA-sequence expression data
expression_data <- read_csv(
  file = "data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv",
  na = c('', 'NA')
) %>%
  rename("gene_code" = "...1")

# Import the associated metadata
metadata <- read_csv(
  file = "data/GSE60450_filtered_metadata.csv",
  na = c('', 'NA')
) %>%
  rename("sample" = "...1")

# Inspect the data -------------------------

# What are the dimensions of each data set? (How many rows/columns in each?)
# Keep the code here for each file.

## Expression data
str(expression_data)

## Metadata
str(metadata)

# Prepare/combine the data for plotting ------------------------
# How can you combine this data into one data.frame?

expression_data_metadata <- expression_data %>%
  pivot_longer(
    cols = starts_with("GSM"),
    names_to = "sample",
    values_to = "expression"
  ) %>%
  left_join(
    metadata
  )

# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2

ggplot(
  data = expression_data_metadata,
  mapping = aes(x = immunophenotype, y = expression)) + 
  geom_boxplot()

## Save the plot
### Show code for saving the plot with ggsave() or a similar function
ggsave("results/Gene_expression_by_cell_type.png")
