if [ ! -d "OTUs" ] 
then
    mkdir OTUs
fi
# echo "\"\"\t" | cat asv_counts.txt
python3 scripts/remove_size_from_chimera_fasta.py chimeras/nonchimeras.fasta \
    -o chimeras/nonchimeras_clean.fasta
python3 scripts/adjust_ASV_counts_for_dbOTU.py data/asv_counts.tsv \
     -f chimeras/nonchimeras_clean.fasta -o temporary/asv_counts_dbOTU.tsv
python3 scripts/dbotu3.py temporary/asv_counts_dbOTU.tsv chimeras/nonchimeras_clean.fasta \
    -o OTUs/OTUs.txt --membership OTUs/OTUs_membership.txt --log OTUs/log.txt \
    -d 0.03 -a 0 