## load summary stats for common snps
load("Addiction_Sumstats_2022_Neff_Grotz_2.RData")

## rename just bc idk
cf_sumstats <- Addiction_sumstats

## split into sets of 5k snps
split_sumstats <- split(cf_sumstats, (as.numeric(rownames(cf_sumstats))-1) %/% 5000)

## save as text files
lapply(names(split_sumstats), function(x){write.table(split_sumstats[[x]], file = paste("./split_sumstats/sumstats", x,".txt", sep = ""), quote = FALSE, row.names=FALSE)})

