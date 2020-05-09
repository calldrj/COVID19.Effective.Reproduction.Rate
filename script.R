library(readr)
cv19 <- read_csv('state.csv')

# 1. SMOOTH THE DATA IN GAUSSIAN-WINDOW OF ONE-WEEK INTERVAL
library(smoother)   # for smth()
library(magrittr)   # for pipe %>% operator
library(dplyr)      # for mutate(), rename() of columns
# Function Smooth()
# * Input: csv dataframe of observations the selected state's date, cases
# * Output: dataframe of observations with the state's cases, smoothed cases, and date
Smooth.Cases <- function(Cases) {
  Cases %>% arrange(Date) %>%
    mutate(Cases_Smth=round(smth(Cases, window=7, tails=TRUE))) %>%
    select(Date, Cases, Cases_Smth)
}
