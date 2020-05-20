The effective reproduction rate of a pandemic, R<sub>0</sub>, is defined as  is the average number of secondary cases per infectious case in a population made up of both susceptible and non-susceptible hosts. However, in COVID-19 pandemic, a static R<sub>0</sub> does not adequately reflect the reality in time and space due to changes in social behaviors and restrictions. For example, New York certainly has a different effective reproduction rate from Idaho. Even New York today has a different effective reproduction than it did in last weeks. That is why Kevin Systrom promotes an idea that the effective reproduction rate of COVID-19 should be a variable of time and space denoted as R<sub>t</sub> [2].     
              
Computation of R<sub>t</sub> for COVID-19 enables understanding how effectively a local or state government handles the pandemic and gives the authority helpful information in decision to losen and tighten measures of social restrictions. As the pandemic spreads with great acceleration, R<sub>t</sub> is much more larger than 1. On the contrary, when the pandemic slows down and dies out, R<sub>t</sub> is smaller than 1 and approaches 0. This project focuses on computation of R<sub>t</sub> for every state on the U.S. based on the number of new cases *k* reported daily by the state's Department of Health. The value of R<sub>t</sub> is related to that of a day before R<sub>t-1</sub>, and every previous value of *n* days before, R<sub>t-n</sub>.            
              
The value of R<sub>t</sub> can be updated everyday by the case count *k*, given by Bayes' rule:

<a href="https://www.codecogs.com/eqnedit.php?latex=$$P(R_t|k)&space;=&space;\frac{P(k|R_t)P(R_t)}{P(k)}," target="_blank"><img src="https://latex.codecogs.com/gif.latex?$$P(R_t|k)&space;=&space;\frac{P(k|R_t)P(R_t)}{P(k)}" title="$$P(R_t|k) = \frac{P(k|R_t)P(R_t)}{P(k)}" /></a> 

where:

P(*k*|R<sub>t</sub>) is the likelihood that the state has *k* new cases given R<sub>t</sub>,       
P(R<sub>t</sub>) is the prior value of R<sub>t</sub> (without the present of data),     
P(*k*) is the probability that the state has *k* new cases in general.    

Assume that for average arrival rate of <img src="https://latex.codecogs.com/gif.latex?\lamda&space;\lambda" title="\lamda \lambda" /> new cases per day, the probability of getting *k* new cases is characterized accordingly by the Poisson distribution:   
<a href="https://www.codecogs.com/eqnedit.php?latex=P(k|\lambda)&space;=&space;\frac{\lambda^ke^{-\lambda}}{k!}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(k|\lambda)&space;=&space;\frac{\lambda^ke^{-\lambda}}{k!}" title="P(k|\lambda) = \frac{\lambda^ke^{-\lambda}}{k!}" /></a>    
Bettencourt and Ribeiro [1] find the relationship of <img src="https://latex.codecogs.com/gif.latex?\lamda&space;\lambda" title="\lamda \lambda" /> and R<sub>t</sub> as follows:

<a href="https://www.codecogs.com/eqnedit.php?latex=\lambda&space;=&space;k_{t-1}e^{\gamma(R_t&space;-&space;1)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\lambda&space;=&space;k_{t-1}e^{\gamma(R_t&space;-&space;1)}" title="\lambda = k_{t-1}e^{\gamma(R_t - 1)}" /></a>

Hence, the likelihood as a Poisson distribution can be writen:      
<a href="https://www.codecogs.com/eqnedit.php?latex=P(k|R_t)&space;=&space;\frac{\lambda^ke^{-\lambda}}{k!}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(k|R_t)&space;=&space;\frac{\lambda^ke^{-\lambda}}{k!}" title="P(k|R_t) = \frac{\lambda^ke^{-\lambda}}{k!}" /></a>, 
where <img src="https://latex.codecogs.com/gif.latex?\gamma" title="\gamma" /> is the reciprocal of the serial interval defined as the time duration between a primary case-patient (infector) having symptom onset and a secondary case-patient (infectee) having symptom onset. The mean of the serial interval for COVID-19 was 3.96 days according to CDC recent source [3].  
          
In addition, the posterior of the current day P(R<sub>t</sub>|*k*<sub>t</sub>) can be computed from the previous day P(R<sub>t-1</sub>|*k*<sub>t-1</sub>):
<a href="https://www.codecogs.com/eqnedit.php?latex=P(R_t|k_t)&space;\quad\alpha\quad&space;P(R_{t-1}|k_{t-1})P(k_t|R_t)&space;\quad\alpha\quad&space;P(R_{t-2}|k_{t-2})P(k_{t-1}|R_{t-1})P(k_t|R_t)&space;\quad&space;..." target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(R_t|k_t)&space;\quad\alpha\quad&space;P(R_{t-1}|k_{t-1})P(k_t|R_t)&space;\quad\alpha\quad&space;P(R_{t-2}|k_{t-2})P(k_{t-1}|R_{t-1})P(k_t|R_t)&space;\quad&space;..." title="P(R_t|k_t) \quad\alpha\quad P(R_{t-1}|k_{t-1})P(k_t|R_t) \quad\alpha\quad P(R_{t-2}|k_{t-2})P(k_{t-1}|R_{t-1})P(k_t|R_t) \quad ..." /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=P(R_t|k_t)&space;\quad\alpha\quad&space;P(R_0)\prod_{j=0}^{t}&space;P(k_j|R_j)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(R_t|k_t)&space;\quad\alpha\quad&space;P(R_0)\prod_{j=0}^{t}&space;P(k_j|R_j)" title="P(R_t|k_t) \quad\alpha\quad P(R_0)\prod_{j=0}^{t} P(k_j|R_j)" /></a>

Assume that prior P(R<sub>0</sub>) is a a uniform distribution, then

<a href="https://www.codecogs.com/eqnedit.php?latex=P(R_t|k_t)&space;\quad\alpha\quad&space;\prod_{j=0}^{t}&space;P(k_j|R_j)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(R_t|k_t)&space;\quad\alpha\quad&space;\prod_{j=0}^{t}&space;P(k_j|R_j)" title="P(R_t|k_t) \quad\alpha\quad \prod_{j=0}^{t} P(k_j|R_j)" /></a>     

Assume that the priors of the last 7 days place a dominant impact on the current prior, then

<a href="https://www.codecogs.com/eqnedit.php?latex=P(R_t|k_t)&space;\quad\alpha\quad&space;\prod_{j=t-7}^{t}&space;P(k_j|R_j)&space;\quad\alpha\quad&space;exp(\sum_{j=t-7}^{t}&space;log(P(k_j|R_j)))" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(R_t|k_t)&space;\quad\alpha\quad&space;\prod_{j=t-7}^{t}&space;P(k_j|R_j)&space;\quad\alpha\quad&space;exp(\sum_{j=t-7}^{t}&space;log(P(k_j|R_j)))" title="P(R_t|k_t) \quad\alpha\quad \prod_{j=t-7}^{t} P(k_j|R_j) \quad\alpha\quad exp(\sum_{j=t-7}^{t} log(P(k_j|R_j)))" /></a>

Finally, a marginalization of the distribution over R<sub>t</sub>, P(*k*<sub>t</sub>) can be obtained by:    
<a href="https://www.codecogs.com/eqnedit.php?latex=P(k_t)&space;=&space;\sum_{R_t}&space;P(k_j|R_j)P(R_j)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?P(k_t)&space;=&space;\sum_{R_t}&space;P(k_j|R_j)P(R_j)" title="P(k_t) = \sum_{R_t} P(k_j|R_j)P(R_j)" /></a>

For this project, we use the data that we scraps from a Wikipedia page where daily counts of new COVID-19 cases are reported by every state's Department of Health. The data is then cleaned and wrangled in a proper dataframe containing the daily count of each state. We select New York, California, Michigan, Louisiana to compute these individual states' effective reproduction rate of the COVID-19 pandemic, R<sub>t</sub>. Every state's R<sub>t</sub> can be computed at users' choice by modifying the vector __states__ in the following code segment.    
                    
The process to compute R<sub>t</sub> can be brieftly described as follows:         
1. Import the all states' daily counts to a dataframe       
2. Initialize a value of <img src="https://latex.codecogs.com/gif.latex?\gamma" title="\gamma" /> and a set of discrete values of R<sub>t</sub>            
3. Select one or more states of interest    
4. Smooth out the daily counts to flatten the choppy data points     
5. Compute the log-likelihood distribution P(*k*|R<sub>t</sub>)     
6. Compute the posterior P(R<sub>t</sub>|*k*<sub>t</sub>)   
7. Compute the estimate of R<sub>t</sub>, including the most-likely, the max, and the min values of R<sub>t</sub>

Even the results can be viewed in the epr.pdf file, alternately at https://lava-general-sunset.glitch.me/, please try the code with a variety of states for yourselve!

## References     

1. Bettencourt LMA, Ribeiro RM (2008) Real Time Bayesian Estimation of the Epidemic Potential of Emerging Infectious Diseases. PLOS ONE 3(5): e2185. https://doi.org/10.1371/journal.pone.0002185     

2. Systrom (2020) The Metric We Need to Manage COVID-19. http://systrom.com/blog/the-metric-we-need-to-manage-covid-19/     

3. Du Z, Xu X, Wu Y, Wang L, Cowling BJ, Ancel Meyers L. (2020) Serial interval of COVID-19 among publicly reported confirmed cases. https://doi.org/10.3201/eid2606.200357
