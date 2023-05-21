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
vsearch --threads 6 --dn 1.4 --mindiffs 3 \
                --mindiv 0.8 --minh 0.28 --abskew 2.0 \
                --chimeras chimeras/chimeras.fasta --borderline chimeras/borderline.fasta \
                --nonchimeras chimeras/nonchimeras.fasta --uchimealns chimeras/uchimealns.out \
                --uchimeout chimeras/uchimeout.txt --uchimealns chimeras/uchimealns.txt \
                --uchime_denovo temporary/asv_seqs_sorted.fasta  \
                >logs/log_uchime.txt 2>&1