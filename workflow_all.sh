if [ ! -d "chimeras_$1" ] 
then
    mkdir chimeras_$1
fi
if [ ! -d "temporary_$1" ] 
then
    mkdir temporary_$1
fi
if [ ! -d "logs_$1" ] 
then
    mkdir logs_$1
fi
python3 scripts/adjust_count_table_format.py -c data_$1/asv_counts.tsv
python3 scripts/sort_ASVs_by_abundance.py data_$1/asv_seqs.fasta \
     -c data_$1/asv_counts.tsv -o temporary_$1/asv_seqs_sorted.fasta
vsearch --threads 6 --dn 1.4 --mindiffs 3 \
                --mindiv 0.8 --minh 0.28 --abskew 2.0 \
                --chimeras chimeras_$1/chimeras.fasta --borderline chimeras_$1/borderline.fasta \
                --nonchimeras chimeras_$1/nonchimeras.fasta --uchimealns chimeras_$1/uchimealns.out \
                --uchimeout chimeras_$1/uchimeout.txt --uchimealns chimeras_$1/uchimealns.txt \
                --uchime_denovo temporary_$1/asv_seqs_sorted.fasta  \
                >logs_$1/log_uchime.txt 2>&1
if [ ! -d "OTUs_$1" ] 
then
    mkdir OTUs_$1
fi
# echo "\"\"\t" | cat asv_counts.txt
python3 scripts/remove_size_from_chimera_fasta.py chimeras_$1/nonchimeras.fasta \
    -o chimeras_$1/nonchimeras_clean.fasta
python3 scripts/adjust_ASV_counts_for_dbOTU.py data_$1/asv_counts.tsv \
     -f chimeras_$1/nonchimeras_clean.fasta -o temporary_$1/asv_counts_dbOTU.tsv
dbotu3.py temporary_$1/asv_counts_dbOTU.tsv chimeras_$1/nonchimeras_clean.fasta \
    -o OTUs_$1/OTUs.txt --membership OTUs_$1/OTUs_membership.txt --log logs_$1/OTU_log.txt \
    -d $d -a 0 -p $p