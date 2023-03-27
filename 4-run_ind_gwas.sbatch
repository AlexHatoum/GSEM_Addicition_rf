#!/bin/bash

#SBATCH -J ind_GWAS
#SBATCH --ntasks=1
#SBATCH --mem=2G
#SBATCH --time=02:00:00
#SBATCH --output=./outerr_ind/set.%a.out
#SBATCH --error=./outerr_ind/set.%a.err
#SBATCH --array=601-640

date
hostname

### set variable that will be the number of the SNP set
cc="${SLURM_ARRAY_TASK_ID}"

### replace "NUMBER" variable in R script with the number of the SNP set the job is running
### you can delete these scripts after you're done with the analyses
sed "s/NUMBER/$cc/g" 3-ind_gwas.R > ./code_ind/$cc.R

ml load r/3.4.4-python-2.7.15-java-11
Rscript ./code_ind/$cc.R

date
