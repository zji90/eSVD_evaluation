library(umap)
af <- list.files('res')
dir.create('comp')
for (f in af) {
  load(paste0('res/',f))
  timepr <- system.time(pr <- prcomp(t(data),scale=T)$x)
  timeu <- system.time(u <- umap(t(data))$layout)
  save.image(paste0('comp/',f))
}

