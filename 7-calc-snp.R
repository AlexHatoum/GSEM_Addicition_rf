## load data
cf <- read.csv("CF_sumstats.csv", header = TRUE) %>% select(SNP, chisq, chisq_df, chisq_pval) %>% rename(cf_chisq == chisq, cf_chisq_df == chisq_df, cf_chisq_pval == chisq_pval)
ind <- read.csv("CUD_sumstats.csv", header = TRUE) %>% select(SNP, chisq, chisq_df, chisq_pval) %>% rename(ind_chisq == chisq, ind_chisq_df == chisq_df, ind_chisq_pval == chisq_pval)

## merge
all <- merge(cf, ind, by = "SNP")

#Step 1: Calculate the chi-square for each SNP and save it in a vector called Q_chisq
all$Q_chisq<-all$cf_chisq-all$ind_chisq

#Step 2: Calculate the df associated with this chi-square statistic and name it df. Note that only the first run #is used to calculate df, as the degrees of freedom will be the same for every SNP. 
all$df<-all$cf_chisq_df-all$ind_chisq_df

#Step 3: Calculate the p-value associated with the Q-statistic, using the relevant degrees of freedom calculated #in Step 3b. 
all$Q_chisq_pval<-pchisq(all$Q_chisq,all$df,lower.tail=FALSE)

## only save relevant info
final_df <- all %>% select(SNP, Q_chisq, df, Q_chisq_pval)

## save
write.csv("Qsnp_results.csv", row.names = FALSE)

