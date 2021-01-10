suppressMessages(library(scran))
suppressMessages(library(igraph))
library(reshape2)
library(ggplot2)
library(gridExtra)
library(RColorBrewer)
library(mclust)
library(cluster)
for (f in list.files('comp/')) {
  print(f)
  load(paste0('comp/',f))
  ct <- sub(':.*','',colnames(data))
  ct[ct %in% c('cytotoxic_t','naive_t')] <- 't_cell'
  print(unique(ct))
  
  sf <- function(m,tit,met,cl=NULL) {
    clu = kmeans(m,cl,iter.max=10000)$cluster
    ari <- adjustedRandIndex(ct,clu)
    data.frame(Metric=c('ARI'),Score=c(ari),clu=met,Method=tit,stringsAsFactors = F)
  }
  
  pd <- rbind(sf(fit[[2]],'eSVD','k-means',length(unique(ct))),sf(pr[,1:5],'SVD','k-means',length(unique(ct))),sf(u,'umap','k-means',length(unique(ct))))
  saveRDS(pd,file=paste0('cluster/res/',sub('.rda','.rds',f)))
}

