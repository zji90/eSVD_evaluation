library(reshape2)
library(ggplot2)
library(gridExtra)
library(RColorBrewer)

af <- list.files('cluster/res/')
pd <- do.call(rbind,lapply(af,function(f) {
  data.frame(readRDS(paste0('cluster/res/',f)),gn=sub('.rds','',sub('.*_','',f)),stringsAsFactors = F)
}))
pd <- pd[pd$Metric=='ARI' & pd$clu=='k-means' & pd$Method!='eSVD + umap' & pd$Method!='SVD + umap',]
pd$Method[pd$Method=='umap'] <- 'UMAP'
pd$gn <- factor(pd$gn,levels=as.character(sort(unique(as.numeric(pd$gn)))))

cv <- brewer.pal(4,'Set1')
names(cv) <- c('eSVD','SVD','SVD + umap','UMAP')
pdf('Fig1C.pdf',width=5,height=3)
ggplot(pd,aes(x=gn,y=Score,col=Method,group=Method)) + geom_line() + theme_classic() + xlab('Number of genes') + ylab('Adjusted Rand Index') + theme_classic() + theme(legend.title=element_blank(),legend.position='right') + scale_color_manual(values=cv)
dev.off()
