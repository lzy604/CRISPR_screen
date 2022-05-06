##one time only
###optional step

# Use the following commands to install Minicoda3：
##wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
##bash Miniconda3-latest-Linux-x86_64.sh
 
# Create an isolated environment for CRISPR screen analysis
##conda create -n CRSIPR
##conda activate CRSIPR

# Install tools
##conda config --add channels conda-forge
##conda config --add channels bioconda
##conda config --add channels r
##conda install -c anaconda libxml2
##conda install -c bioconda mageck
##conda install -c bioconda -c conda-forge mageck-vispr

# Install MAGeCKFlute using R
## Rscript ~rcode/ins_MAGeCKFlute.R


# Process CRISPR screen data step by step with MAGeCK 
#Activate the CRSIPR environment 
conda activate CRSIPR
# Download and unzip the test data for both datasets, using the following commands:
wget http://cistrome.org/MAGeCKFlute/demo.tar.gz 
tar zxvf demo.tar.gz
cd demo_data
# Generate a count table for Dataset 1 with the mageck count function, by first changing the working directory to a directory that contains raw .fastq data and is able to store the output of mageck count as follows:
cd path/to/demo_data/mageck_count
# To run the mageck count on Dataset 1, type the following command:
mageck count -l library.csv -n GSC_0131 --sample-label day0_r1, day0_r2,day23_r1,day23_r2 --fastq GSC_0131_Day0_Rep1.fastq.gz GSC_0131_Day0_Rep2.fastq.gz GSC_0131_Day23_Rep1.fastq.gz GSC_0131_ Day23_Rep2.fastq.gz
# Identify screen hits using MAGeCK RRA(MAGeCK RRA for comparison between two conditions, such as an initial condition versus cells cultured for a period of time. )
$mageck test -k GSC_0131.count.txt -t day23_r1,day23_r2 -c day0_r1,day0_r2 -n GSC_0131_rra --remove-zero both --remove- zero-threshold 0
# Identify screen hits using MAGeCK MLE. (If an experiment contains more than two conditions, for example, a three-condition design: day 0, drug treatment and DMSO treatment, we recommend using MAGeCK MLE)
cd path/to/demo_data/mageck_mle
mageck mle --count-table rawcount.txt --design-matrix designmatrix. txt --norm-method control --control-sgrna nonessential_ctrl_sgrna_ list.txt --output-prefix braf.mle ##modify designmatrix table as your expriemnt design

# Process CRISPR screen data with MAGeCK-VISPR
# Activate the CRSIPR environment 
conda activate CRSIPR
# Choose a workflow directory and initialize the workflow with the .fastq or .fastq.gz files that contain the raw reads
mageck-vispr init workflow --reads path/to/file/*.fastq*
# Configure the workflow
cd workflow
# To check whether the ‘config.yaml’ files have been configured correctly,enter the following command line into the terminal:
$snakemake –n
# Execute the workflow.
snakemake --cores 8
# Visualize the results with VISPR.
vispr server results/*.vispr.yaml

# Functional analysis for MAGeCK RRA results by MAGeCKFlute
#Activate the CRSIPR environment 
conda activate CRSIPR
Rscript ~rcode/MAGeCKFlute_RRA.R


# Functional analysis for MAGeCK MLE results by MAGeCKFlute
#Activate the CRSIPR environment 
conda activate CRSIPR
Rscript ~rcode/MAGeCKFlute_MLE.R


### (Optional) Batch effect removal
conda activate CRSIPR
Rscript ~rcode/MAGeCKFlute_BatchRemove.R

### (Optional) Correct copy-number bias. 
# To perform MAGeCK RRA with copy-number bias correction, type the following:
mageck test -k rawcount.txt -t HL60.final -c HL60.initial -n rra_ cnv --cnv-norm cnv_data.txt –cell-line HL60_HAEMATOPOIETIC_AND_ LYMPHOID_TISSUE

# To perform MAGeCK MLE with copy-number bias correction, type the following:
mageck mle --count-table rawcount.txt --design-matrix designma- trix.txt --cnv-norm cnv_data.txt




