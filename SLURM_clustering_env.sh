#!/bin/bash -l
 
#SBATCH -A naiss2023-5-110
#SBATCH -p core
#SBATCH -n 20
#SBATCH --mail-type=END
#SBATCH --mail-user=krzysztof.jurdzins@scilifelab.se
#SBATCH -t 00:40:00
#SBATCH -J creating_ASV_clustering_env

cd /crex/proj/snic2020-6-126/projects/plankton_monitoring/P20310/ASV_reannotation/chimera_dbOTU_pipeline
conda env create -f environment.yml
# conda activate chimera-dbOTU-pipeline
# conda install -c cduvallet dbotu

