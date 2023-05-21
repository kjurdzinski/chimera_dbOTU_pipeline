#!/bin/bash -l
 
#SBATCH -A naiss2023-5-110
#SBATCH -p core
#SBATCH -n 20
#SBATCH --mail-type=END
#SBATCH --mail-user=krzysztof.jurdzins@scilifelab.se
#SBATCH -t 06:00:00
#SBATCH -J chimera_dbOTU_clustering

cd /crex/proj/snic2020-6-126/projects/plankton_monitoring/P20310/ASV_reannotation/chimera_dbOTU_pipeline
conda activate chimera-dbOTU-pipeline
bash workflow_all.sh 16S
