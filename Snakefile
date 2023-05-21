import pandas as pd
from snakemake.utils import min_version
min_version("5.3.0")
# configfile: "config.yml"

rule sort_ASVs:
    """
    Sort ASVs by abundance
    """
    input:
        "data/asv_seqs.fasta"
        "data/asv_counts.tsv"
    output:
        "temporary/asv_seqs_sorted.fasta"
    shell:
        """
        if [ ! -d "chimeras" ] 
        then
            mkdir chimeras
        fi
        if [ ! -d "temporary" ] 
        then
            mkdir temporary
        fi
        python3 scripts/sort_ASVs_by_abundance.py data/asv_seqs.fasta \
            -c data/asv_counts.tsv -o temporary/asv_seqs_sorted.fasta
        """