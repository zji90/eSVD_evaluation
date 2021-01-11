library(eSVD)
library(Seurat)
data <- readRDS(paste0('data/sub.rds'))
dir.create('res')
for (gn in c(500,1000,2000,3000)) {
g <- VariableFeatures(FindVariableFeatures(CreateSeuratObject(counts = data, project = "sub"), nfeatures = gn))

data <- data[g,]
oridata <- 2^data-1

init <- initialization(oridata, k=5, family = "curved_gaussian",max_val = 100,scalar=2)
fit <- fit_factorization(oridata, u_mat = init$u_mat, v_mat = init$v_mat,max_val = 100,max_iter=100,family = "curved_gaussian",ncores=48,scalar=2)
save.image(paste0('res/',gn,'.rda'))
}
