#!/bin/bash -l
 
#SBATCH -A naiss2023-5-110
#SBATCH -p core
#SBATCH -n 20
#SBATCH --mail-type=ALL
#SBATCH --mail-user=krzysztof.jurdzins@scilifelab.se
#SBATCH -t 3-00:00:00
#SBATCH -J chimera_dbOTU_clustering

cd /crex/proj/snic2020-6-126/projects/plankton_monitoring/chimera_dbOTU_pipeline/
conda activate chimera-dbOTU-pipeline
bash workflow_all.sh -t 16S -d 0.03 -p 0.0005
bash workflow_all.sh -t 18S -d 0.1 -p 0.0005
