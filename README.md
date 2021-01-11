# eSVD_evaluation

Code and data to reproduce the evaluation of eSVD

Version: 1.0.0

sub.rds:    scRNA-seq gene expression matrix used as input for the following .R files

Run the following code in order to reproduce the results in the paper. Need to have following R packages installed: eSVD Seurat umap reshape2 ggplot2 gridExtra RColorBrewer mclust cluster

esvd.R:     run eSVD

umap.R:     run SVD and umap

cluster.R:  perform k-means and benchmark clustering performance

Fig1A.R, Fig1B.R, Fig1C.R:    produce Figure 1A,1B,1C
