data <- readRDS('data/full.rds')
ct <- sub(':.*','',colnames(data))

id <- unlist(lapply(setdiff(unique(ct),c('cytotoxic_t','naive_cytotoxic','memory_t','regulatory_t','cd4_t_helper')),function(i) {
  tmp <- which(ct==i)
  if (length(tmp) > 500) tmp <- sample(tmp,500)
  tmp
}))
data <- data[,id]
print(table(sub(':.*','',colnames(data))))
data <- data[rowMeans(data > 0) > 0.01,]
saveRDS(data,file='data/sub.rds')

