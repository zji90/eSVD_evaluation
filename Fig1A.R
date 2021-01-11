library(reshape2)
library(ggplot2)
library(gridExtra)
library(RColorBrewer)
library(mclust)
library(cluster)

pd <- NULL
for (gn in c(500,3000)) {
  clu <- readRDS(paste0('clu/eSVD_',gn,'.rds'))
  pd <- rbind(pd,data.frame(clu=clu,ct=sub(':.*','',names(clu)),method=paste0(gn,' genes'),stringsAsFactors = F))
}

pd$method <- factor(pd$method,levels=c(paste0(c("500 genes", "3000 genes"))))
trans <- c('cd34'='HSC','b_cells'='B cell','cd56_nk'='Natural killer cell','cd14_monocytes'='Monocyte','t_cell'='T cell')
pd$ct <- trans[pd$ct]
pd$clu <- as.character(pd$clu)
cv <- brewer.pal(5,'Set1')
names(cv) <- trans

png(paste0('Fig1A.png'),width=700,height=1400,res=300)
print(ggplot(pd,aes(x=clu,fill=ct)) + geom_bar() + theme_classic() + facet_wrap(~method,scales = 'free',ncol=1) + xlab('Cluster') + ylab('Number of cells in different cell types') + theme(legend.position = 'none',legend.title=element_blank()) + scale_fill_manual(values=cv))
dev.off()



