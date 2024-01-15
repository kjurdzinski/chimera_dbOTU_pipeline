## VSearch and dbOTU for metabarcoding-based ecogenetic species

### Main pipeline

1. Transform the count table to the format accepted by UCHIME (Add "\"\"\t" at the beginning of the document, \" meaning here that " is a part of the string, \t means a tab).
2. Sort ASVs (FASTA file) by abundance and state the total number of counts - another requirement for the use of UCHIME.
3. Run UCHIME V1 to detect and exclude chimeras left unnoticed by previous analyses.
4. Reformat the FASTA file to include just the ASV IDs.
5. Reformat the count table for dbOTU - remove the rows which correspond to chimera ASVs.
6. Run dbOTU to detect ASVs coming from the same species based on their genetic AND distribution similarity.\

Key output (in OTUs_${your_data_type}):
1. OTUs_${your_data_type}.txt - count table for distribution- and genetics-based OTUs.
2. OTUs_membership - the ASVs included in each OTU.

### Workflow

1. Create the conda environment for the pipeline (specified in environment.yml, if you are using SLURM you can use the SLURM_clustering_env.sh script to set up a job)
2. Prepare and upload the necessary files and put them into directories data_${your_data_type}, e.g. data_16S. There should be two files in each of these directories:\
  I. asv_seqs.fasta - your ASV (amplicon sequence variant) sequences in the FASTA format;\
  II. asv_counts.tsv - your count table.
3. Run the pipeline using workflow_all.sh (You can use SLURM_chimera_dbOTU.sh to run a SLURM job, remember to modify according to your needs). Parameters:\
  I. your data type (no prefix), corresponding to ${your_data_type} in the data directory name. E.g. 16S if your data directory is called data_16S;\
  II. -d \[0,1\] - maximum genetic distance allowed to be accepted for the species clusters (for dbOTU, see https://dbotu3.readthedocs.io/en/latest/getting-started.html#deciding-on-parameters). Default 0.1, for bacteria 0.03 is recomended;\
  III. -p \[0,1\] - distribution similarity p-value cut-off, 0.0005 by default.\
The pipeline runs:\
  I. Chimera reduction with UCHIME v1.\
  II. Distribution and genetic similarity clustering using dbOTU v3.

5. If you downloaded your files and are sure you don't need the intermediate files, you can use clean.sh
   

### Preparation
Make data_${your_data_type} directories.

File formats:


asv_seqs.fasta - ASV names same as in asv_counts.tsv. \
\>ASV_1\
TATACGT... (sequence)\
\>ASV_2\
TATACGT... (sequence)\
...


asv_counts.tsv - samples as columns, row names corresponding to your ASV IDs.\
Row and column names in quotations!\

Important: Files need to have those names!

### Notes

Here we use a stable dbOTU3 version downloaded as a python script on May 21, 2023

### Acknowledgements

This pipeline has been heavily inspired by John Sundh's work: https://github.com/johnne/ASV-clustering I also used some of his work.\

This pipeline would obviously also not be possible without the developers of UCHIME v1 and dbOTU v3
