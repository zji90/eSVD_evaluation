suppressMessages(library(scran))
suppressMessages(library(igraph))
library(reshape2)
library(ggplot2)
library(gridExtra)
library(RColorBrewer)
library(mclust)
library(cluster)
dir.create('clu')
dir.create('cluster/res',recursive=T)
for (f in list.files('comp/')) {
  print(f)
  load(paste0('comp/',f))
  ct <- sub(':.*','',colnames(data))
  
  sf <- function(m,tit,met,cl=NULL) {
    clu = kmeans(m,cl,iter.max=10000)$cluster
    names(clu) <- colnames(data)
    saveRDS(clu,file=paste0('clu/',tit,'_',sub('.rda','.rds',f)))
    ari <- adjustedRandIndex(ct,clu)
    data.frame(Metric=c('ARI'),Score=c(ari),clu=met,Method=tit,stringsAsFactors = F)
  }
  
  pd <- rbind(sf(fit[[2]],'eSVD','k-means',length(unique(ct))),sf(pr[,1:5],'SVD','k-means',length(unique(ct))),sf(u,'umap','k-means',length(unique(ct))))
  saveRDS(pd,file=paste0('cluster/res/',sub('.rda','.rds',f)))
}

