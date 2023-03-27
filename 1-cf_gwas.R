## load packages
library(GenomicSEM)
library(data.table)

## load LDSC matrix
print("loading LDSC matrix")
load("LDSCouptutGWAS2022_2.RData")

### load the summary statistics RData file in the split form
print("loading summary statistics from set NUMBER...")
split_sumstats <- read.table("./split_sumstats/sumstatsNUMBER.txt", header = TRUE)
print("finished loading summary statistics from set NUMBER")

#Step 1a: specify the Step 1 (Common Pathways) Model
model <- 'AF =~ OUD + CUD + PAU + Tob
AF~~NA*AF

AF ~ SNP
'
print("model specified")

#Step 1b: run the Step 1 Model using parallel processing
print("running common pathways GWAS")
CommonFactor<-userGWAS(covstruc = LDSCoutputGWAS, modelchi = TRUE, SNPs = split_sumstats, model = model, sub=c("AF~SNP"), parallel=FALSE)
print("Common pathways GWAS finished running")

## Write results to a table
print("writing results to ./res_files/NUMBER.csv")
write.csv(CommonFactor, "./res_files/NUMBER.csv", row.names=FALSE, quote=TRUE)
