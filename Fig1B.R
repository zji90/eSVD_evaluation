library(ggplot2)
library(gridExtra)
library(RColorBrewer)
pd <- NULL
for (gn in c(500,3000)) {
  load(paste0('res/',gn,'.rda'))
  pd <- rbind(pd,data.frame(x=fit[[2]][,1],y=fit[[2]][,2],e=sub(':.*','',colnames(data)),method=paste0(gn,' genes'),dim='Dimension 1,2',stringsAsFactors = F))
}

pd <- pd[sample(1:nrow(pd)),]
pd$method <- factor(pd$method,levels=c(paste0(c("500 genes", "1000 genes", "3000 genes"))))
ct <- pd$e

trans <- c('cd34'='HSC','b_cells'='B cell','cd56_nk'='Natural killer cell','cd14_monocytes'='Monocyte','t_cell'='T cell')
pd$e <- trans[ct]
cv <- brewer.pal(5,'Set1')
names(cv) <- trans
png(paste0('Fig1B.png'),width=700,height=1400,res=300)
print(ggplot(pd,aes(x=x,y=y,col=e)) + geom_point(size=0.1,alpha=0.5) + theme_classic() + facet_wrap(method~.,scales = 'free',ncol=1) + xlab('Dimension 1') + ylab('Dimension 2') + guides(color=guide_legend(title="Cell Type",override.aes = list(size = 3,alpha=1))) + theme(legend.position = 'none',legend.title=element_blank()) + scale_color_manual(values=cv))
dev.off()


