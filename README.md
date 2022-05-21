# QR-Methods-paper
This repository accompanies the manuscript "Performance of Competing Methods for Quantile Regression with Count Data: A Simulation Study with Applications for Environmental Epidemiology".

I considered the following methods in this paper
-iid
-nid
-ker
-riid
-rnid
-xy
-wxy
-pbs
-mcmb
-pwy
-wild
-biid (the "unadjusted" results from the BayesQR package)
-bnid 

The bnid method that came with the BayesQR package (i.e. the "adjusted" results, referred to as "bayes_adj_v1" in my code) was clearly not functioning correctly (it gave implausibly large posterior credibility intervals, and had 100% coverage). We thus created our own function (see "summary_sanwich.R"; these results are referred to as "bayes_adj_v2" in my code) to implement the adjustment to the covariance matrix proposed by Yang et al. (2016). 


The Monte Carlo experiment was conducted with the following .Rmd files: 

ss_Main.Rmd = The code for the simulation study (part 2 of the results, and the "circles" in part 3. Also used in Figure 1c-d). 
- Includes both the Bayesian and frequentist methods.
- Y is a count variable. 
- The frequestist methods are dithered, but the Bayesian ones are not. 
- Output: "table_ss_JA model_2021-08-07_1000_sims.csv"

ss_Main_gold.Rmd = The code for the simulation study (part 3 of the results/ the "squares" only. Also used in Figure 1a)
- Only includes the frequentist methods.
- Y is NOT a count variable. It is a continuous variable
- Dithering is not applied. 
- Output: "table_ss_JA moel_gold_2021-10-28_1000_sims.csv"

ss_Main_no dith.Rmd = The code for the simulation study (part 1 only, specifically just Figure 1b)
- Y is a count variable
- Dithering is NOT applied
- Only includes the basic frequentist methods (iid, riid, rnid). But I only used the iid method to generate fig 1b, so the other methods turned out to be unnecessary
- Output: "table_ss_no dith_v2_2021-08-04_1000_sims.csv"

NOTE: Output files are compressed using WinRAR. 

The results from the Monte Carlo experiment were generated from the raw .csv files with the following .Rmd files:

res_ss_v3
- Cleans the results
- Creates all figures except for figure 1 
- Uses the function in "ggplot_functions.R" to generate the figures

res_ss_tables
- Cleans the results
- Creates all of the tables

res_ss_sup tables
- Cleans the results
- Creates all the supplementary tables (i.e. the tabulated results from the figures)

res_ss_irreg_v2
- Cleans the results
- Makes Figure 1
