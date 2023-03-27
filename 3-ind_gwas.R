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
model2<-'Addiction =~ OUD + PAU + Tob + CUD
OUD~SNP
PAU~SNP
Tob~SNP
CUD~SNP
'
print("model specified")

#Step 1b: run the Step 1 Model using parallel processing
print("running common pathways GWAS")
CommonFactor<-userGWAS(covstruc = LDSCoutputGWAS, modelchi = TRUE, SNPs = split_sumstats, model = model2, sub=c("OUD~SNP", "PAU~SNP", "Tob~SNP", "CUD~SNP"), parallel=FALSE)
print("Common pathways GWAS finished running")

CF1 <- CommonFactor[[1]]
write.csv(CF1, "./res_files_ind/OUD/NUMBER.csv", row.names=FALSE, quote=TRUE)

CF2 <- CommonFactor[[2]]
write.csv(CF2, "./res_files_ind/PAU/NUMBER.csv", row.names=FALSE, quote=TRUE)

CF3 <- CommonFactor[[3]]
write.csv(CF3, "./res_files_ind/Tob/NUMBER.csv", row.names=FALSE, quote=TRUE)

CF4 <- CommonFactor[[4]]
write.csv(CF4, "./res_files_ind/CUD/NUMBER.csv", row.names=FALSE, quote=TRUE)
