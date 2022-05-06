library(MAGeCKFlute)
setwd('path/to/file/')

# To perform Batch effect removal
BatchRemove(mat = "rawcount.txt", batchMat = "BatchMatrix. txt", prefix = "BatchCorrect", -pca = T, -cluster = T, -outdir = ".")