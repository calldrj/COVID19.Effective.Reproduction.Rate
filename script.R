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
# 2. VISUALIZE DATA FOR SANITY CHECK
library(plotly)   # for interactive plot ggplotly
Plot.Smth <- function(Smoothed_Cases) {
  plot <- Smoothed_Cases %>% ggplot(aes(x=Date, y=Cases)) +
    geom_line(linetype='dotted', color='#429890') + 
    geom_line(aes(y=Cases_Smth), color='#E95D0F') +
    labs(title='Daily Confirmed Cases (Original & Smoothed)', x=NULL, y=NULL) +
    theme(plot.title=element_text(hjust=0.5, color='steelblue'))
} 

# 3. COMPUTE THE EFFECTIVE REPRODUCTION RATE & LOG-LIKELIHOOD 
library(purrr)    # for map() and map
library(tidyr)    # for unnest

RT_MAX <- 10      # the max value of Effective Reproduction Rate Rt
# Generate a set of RT_MAX * 100 + 1 Effective Reproduction Rate value Rt
rt_set <- seq(0, RT_MAX, length=RT_MAX * 100 + 1)

# Gamma = 1/serial interval
# The serial interval of COVID-19 is defined as the time duration between a primary case-patient (infector) 
# having symptom onset and a secondary case-patient (infectee) having symptom onset. The mean interval was 3.96 days.
# https://wwwnc.cdc.gov/eid/article/26/6/20-0357_article
GAMMA = 1/4

# Comp.Log_Likelihood()
# * Input: csv dataframe of observations with the selected state's date, cases, smoothed cases
# * Output: dataframe of observations with the state's cases, smoothed cases, Rt, Rt's log-likelihood
Comp.Log_Likelihood <- function(Acc_Cases) {
  likelihood <- Acc_Cases %>% filter(Cases_Smth > 0) %>%
    # Vectorize rt_set to form Rt column
    mutate(Rt=list(rt_set),
           # Compute lambda starting from the second to the last observation
           Lambda=map(lag(Cases_Smth, 1), ~ .x * exp(GAMMA * (rt_set - 1))),
           # Compute the log likelihood for every observation
           Log_Likelihood=map2(Cases_Smth, Lambda, dpois, log=TRUE)) %>%
    # Remove the first observation
    slice(-1) %>%
    # Remove Lambda column
    select(-Lambda) %>%
    # Flatten the table in columns Rt, Log_Likelihood
    unnest(Log_Likelihood, Rt)
}
# 4. COMPUTER THE POSTERIOR OF THE EFFECTIVE REPRODUCTION RATE 
library(zoo)     # for rollapplyr
# Function Comp.Posterior()
# * Input: csv dataframe of observations with the selected state's date, cases, smoothed cases, Rt, Rt's log-likelihood
# * Output: dataframe of observations with the state's cases, smoothed cases, Rt, Rt's posterior
Comp.Posterior <- function(likelihood) {
  likelihood %>% arrange(Date) %>%
    group_by(Rt) %>%
    # Compute the posterior for every Rt by a sum of 7-day log-likelihood
    mutate(Posterior=exp(rollapplyr(Log_Likelihood, 7, sum, partial=TRUE))) %>%
    group_by(Date) %>%
    # Normalize the posterior 
    mutate(Posterior=Posterior/sum(Posterior, na.rm=TRUE)) %>%
    # Fill missing value of posterior with 0
    mutate(Posterior=ifelse(is.nan(Posterior), 0, Posterior)) %>%
    ungroup() %>%
    # Remove Log_Likelihood column
    select(-Log_Likelihood)
}

# 5. PLOT POSTERIOR OF THE EFFECTIVE REPRODUCTION RATE
Plot.Posterior <- function(posteriors) {
  posteriors %>% ggplot(aes(x=Rt, y=Posterior, group=Date)) +
    geom_line(color='#E95D0F', alpha=0.4) +
    labs(title='Daily Posterior of Rt', subtitle=state) +
    coord_cartesian(xlim=c(0.2, 5)) +
    theme(plot.title=element_text(hjust=0.5, color='steelblue'))
}
