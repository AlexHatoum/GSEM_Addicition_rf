#!/bin/bash

#SBATCH --job-name=combine_SNPsets
#SBATCH --time=02:00:00
#SBATCH --mem=1000
#SBATCH --output=./outerr/combine.out
#SBATCH --error=./outerr/combine.err

date
hostname

### concatenate all results files
cat ./res_files/*.csv > CF_sumstats.csv

### remove intermediate files
rm ./code/*.R

### remove all lines that aren't the first occurrence of Z_Estimate (used to indicate header line)
sed -i '1!{/Z_Estimate/d;}' CF_sumstats.csv


date
