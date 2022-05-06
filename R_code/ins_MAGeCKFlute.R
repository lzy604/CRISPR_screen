install.packages(c("devtools", "BiocManager"), repos = "https://cloud.r-project.org")
BiocManager::install(c("pathview", "biomaRt", "msigdbr", "dendextend", "pheatmap", "sva", "ggrepel", "knitr", "clusterProfiler", "depmap"))
BiocManager::install("MAGeCKFlute") # Released version
# Or
devtools::install_github("liulab-dfci/MAGeCKFlute")
