# INTRODUCTION    
The effective reproduction rate of a pandemic, R~0~, is defined as  is the average number of secondary cases per infectious case in a population made up of both susceptible and non-susceptible hosts. However, in COVID-19 pandemic, a static R~0~ does not adequately reflect the reality in time and space due to changes in social behaviors and restrictions. For example, New York certainly has a different effective reproduction rate from Idaho. Even New York today has a different effective reproduction than it did in last weeks. That is why Kevin Systrom promotes an idea that the effective reproduction rate of COVID-19 should be a variable of time and space denoted as R~t~.     
              
Computation of R~t~ for COVID-19 enables understanding how effectively a local or state government handles the pandemic and gives the authority helpful information in decision to losen and tighten measures of social restrictions. As the pandemic spreads with great acceleration, R~t~ is much more larger than 1. On the contrary, As the pandemic slows down and dies out, R~t~ is smaller than 1 and approaches 0. This project focuses on computation of R~t~ for every state on the U.S. based on the number of new cases *k* reported daily by the state's Department of Health. The value of R~t~ is related to that of a day before R~t-1~, and every previous value of *n* days before, R~t-n~.            
              
According to Bettencourt and Ribeiro's paper, the value of R~t~ can be updated everyday by the case count *k*, given by Bayes' rule:

$$P(R_t|k) = \frac{P(k|R_t)P(R_t)}{P(k)}, where$$   
P(*k*|R~t~) is the likelihood that the state has *k* new cases given R~t~,       
P(R~t~) is the prior value of R~t~ (without the present of data),     
P(*k*) is the probability that the state has *k* new cases in general.    

Assume that for average arrival rate of $\lambda$ new cases per day, the probability of getting *k* new cases is characterized accordingly by the Poisson distribution:   
$$P(k|\lambda) = \frac{\lambda^ke^{-\lambda}}{k!}$$     
Bettencourt and Ribeiro also find the relationship of $\lambda$ and R~t~ as follows:      
$$\lambda = k_{t-1}e^{\gamma(R_t - 1)}$$    
Hence, the likelihood as a Poisson distribution can be writen:      
$$P(k|R_t) = \frac{\lambda^ke^{-\lambda}}{k!}, where$$ 
$\gamma$ is the reciprocal of the serial interval defined as the time duration between a primary case-patient (infector) having symptom onset and a secondary case-patient (infectee) having symptom onset. The mean of the serial interval for COVID-19 was 3.96 days according to CDC recent source.  
          
In addition, the posterior of the current day P(R~t~|*k~t~*) can be computed from the previous day P(R~t-1~|*k~t-1~*):
$$P(R_t|k_t) \quad\alpha\quad P(R_{t-1}|k_{t-1})P(k_t|R_t) \quad\alpha\quad P(R_{t-2}|k_{t-2})P(k_{t-1}|R_{t-1})P(k_t|R_t) \quad ... $$
$$P(R_t|k_t) \quad\alpha\quad P(R_0)\prod_{j=0}^{t} P(k_j|R_j)$$
Assume that prior P(R~0~) is a a uniform distribution, then 
$$P(R_t|k_t) \quad\alpha\quad \prod_{j=0}^{t} P(k_j|R_j)$$     
Assume that the priors of the last 7 days place a dominant impact on the current prior, then

$$P(R_t|k_t) \quad\alpha\quad \prod_{j=t-7}^{t} P(k_j|R_j) \quad\alpha\quad exp(\sum_{j=t-7}^{t} log(P(k_j|R_j)))$$
Finally, a marginalization of the distribution over R~t~, P(*k*~t~) can be obtained by:    
$$P(k_t) = \sum_{R_t} P(k_j|R_j)P(R_j)$$
For this project, we use the data that we scraps from a Wikipedia page where daily counts of new COVID-19 cases are reported by every state's Department of Health. The data is then cleaned and wrangled in a proper dataframe containing the daily count of each state. We select New York, California, Michigan, Louisiana to compute these individual states' effective reproduction rate of the COVID-19 pandemic, R~t~. Every state's R~t~ can be computed at users' choice by modifying the vector __states__ in the following code segment.    
                    
The process to compute R~t~ can be brieftly described as follows:         
1. Import the all states' daily counts to a dataframe       
2. Initialize a value of $\gamma$ and a set of discrete values of R~t~            
3. Select one or more states of interest    
4. Smooth out the daily counts to flatten the choppy data points     
5. Compute the log-likelihood distribution P(*k*|R~t~)     
6. Compute the posterior P(R~t~|*k~t~*)   
7. Compute the estimate of R~t~, including the most-likely, the max, and the min values of R~t~   