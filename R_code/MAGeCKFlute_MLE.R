library(MAGeCKFlute)
setwd('path/to/file/')

# To perform functional analysis for MAGeCK MLE  results 
FluteMLE(gene_summary="path/to/file/mle.gene_summary.txt", ctrlname="dmso", treatname="plx", organism="hsa", prefix="FluteMLE", -pathway_limit = c(3,50))
