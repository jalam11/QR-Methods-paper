# QR-Methods-paper
This repository accompanies the manuscript "Performance of Competing Methods for Quantile Regression with Count Data: A Simulation Study with Applications for Environmental Epidemiology".

Note that for the "bnid" method that came with the BayesQR package (i.e. the "adjusted" results, referred to as "bayes_adj_v1" in my code) was clearly not functioning correctly (it gave implausibly large posterior credibility intervals, and had 100% coverage). We thus created our own function (see "summary_sanwich.R"; these results are referred to as "bayes_adj_v2" in my code) to implement the adjustment to the covariance matrix proposed by Yang et al. (2016). 


**The Monte Carlo experiment was conducted with the following .Rmd files:**

NOTE: Output files are compressed using WinRAR. 

ss_Main.Rmd = The code for the simulation study (Section 5.1 of the paper, and the "circles" in 5.2. Also used in Figure S1c-d). 
- Includes both the Bayesian and frequentist methods.
- Y is a count variable (rounded to the nearest whole number). 
- The frequestist methods are dithered, but the Bayesian ones are not. 
- Output: "table_ss_JA model_2021-08-07_1000_sims.csv"

ss_Main_gold.Rmd = The code for the simulation study (Section 5.2 of the paper/ the "squares" only. Also used in Figure 1a)
- Only includes the frequentist methods.
- Y is a continuous variable (the original unrounded y). 
- Dithering is not applied. 
- Output: "table_ss_JA moel_gold_2021-10-28_1000_sims.csv"

ss_Main_no dith.Rmd = The code for the simulation study (only used for Figure S1b)
- Y is a count variable
- Dithering is NOT applied
- Output: "table_ss_no dith_v2_2021-08-04_1000_sims.csv"

**The figures and tables based on simulated data were generated with the following .Rmd files**

res_ss_v3
- Cleans the results
- Creates all figures except for figure S1
- Uses the helper functions in "ggplot_functions.R" to generate the figures

res_ss_tables
- Cleans the results
- Creates all of the tables

res_ss_irreg_v2
- Cleans the results
- Makes Figure S1


**The figures based on the MIREC data were generated with the following .Rmd files**

Read data ex.Rmd
- Models the relationship between 4 chemicals (1st trimester concentrations, log2-transformed) and SRS scores using all methods discussed in paper
- Output: "table_real results_2023-05-05.csv"

fig_real data analysis.Rmd
- Uses "table_real results_2023-05-05.csv" to generate Figure 1 and Figure 5
- Uses the helper functions in "ggplot_functions.R" 
