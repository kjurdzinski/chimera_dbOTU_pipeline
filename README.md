## VSearch and dbOTU for metabarcoding-based ecogenetic species

### Workflow

1. Create the conda environment for the pipeline (specified in environment.yml, if you are using SLURM you can use the SLURM_clustering_env.sh script to set up a job)
2. Prepare and upload the necessary files and put them into directories data_${your_data_type}, e.g. data_16S. There should be two files in each of these directories:
  I. asv_seqs.fasta - your ASV (amplicon sequence variant) sequences in the FASTA format\
  II. asv_counts.tsv - your count table\
3. Run the pipeline using workflow_all.sh (You can use SLURM_chimera_dbOTU.sh to run a SLURM job, remember to modify according to your needs). Parameters:\
  I. your data type (no prefix), corresponding to ${your_data_type} in the data directory name. E.g. 16S if your data directory is called data_16S\
  II. -d \[0,1\] - maximum genetic distance allowed to be accepted for the species clusters (for dbOTU, see https://dbotu3.readthedocs.io/en/latest/getting-started.html#deciding-on-parameters). Default 0.1, for bacteria 0.03 is recomended\
  III. -p \[0,1\] - distribution similarity p-value cut-off, 0.0005 by default.
4. If you downloaded your files and are sure you don't need the intermediate files, you can use clean.sh
   

### Preparation
Make data_${your_data_type} directories.

File formats:\
asv_seqs.fasta - ASV names same as in asv_counts.tsv\
asv_counts.tsv - samples as columns, row names corresponding to your ASV IDs\
Important: Files need to have those names!

### Notes

Here we use a stable ddOTU3 version downloaded as python script on May 21, 2023

### Acknowledgements

This pipeline has been heavily inspired by John Sundh's work: https://github.com/johnne/ASV-clustering
