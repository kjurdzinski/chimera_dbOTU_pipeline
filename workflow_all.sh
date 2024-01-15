while getopts t:d:p: flag
do
    case "${flag}" in
        t) datatype=${OPTARG};;
        d) genetic=${OPTARG};;
        p) distribution=${OPTARG};;
    esac
done

echo $datatype
echo $genetic
echo $distribution

if [ ! -d "chimeras_$datatype" ] 
then
    mkdir chimeras_$datatype
fi
if [ ! -d "temporary_$datatype" ] 
then
    mkdir temporary_$datatype
fi
if [ ! -d "logs_$datatype" ] 
then
    mkdir logs_$datatype
fi
python3 scripts/adjust_count_table_format.py -c data_$datatype/asv_counts.tsv
python3 scripts/sort_ASVs_by_abundance.py data_$datatype/asv_seqs.fasta \
     -c data_$datatype/asv_counts.tsv -o temporary_$datatype/asv_seqs_sorted.fasta
vsearch --threads 6 --dn 1.4 --mindiffs 3 \
                --mindiv 0.8 --minh 0.28 --abskew 2.0 \
                --chimeras chimeras_$datatype/chimeras.fasta --borderline chimeras_$datatype/borderline.fasta \
                --nonchimeras chimeras_$datatype/nonchimeras.fasta --uchimealns chimeras_$datatype/uchimealns.out \
                --uchimeout chimeras_$datatype/uchimeout.txt --uchimealns chimeras_$datatype/uchimealns.txt \
                --uchime_denovo temporary_$datatype/asv_seqs_sorted.fasta  \
                >logs_$datatype/log_uchime.txt 2>&1
if [ ! -d "OTUs_$datatype" ] 
then
    mkdir OTUs_$datatype
fi
# echo "\"\"\t" | cat asv_counts.txt
python3 scripts/remove_size_from_chimera_fasta.py chimeras_$datatype/nonchimeras.fasta \
    -o chimeras_$datatype/nonchimeras_clean.fasta
python3 scripts/adjust_ASV_counts_for_dbOTU.py data_$datatype/asv_counts.tsv \
     -f chimeras_$datatype/nonchimeras_clean.fasta -o temporary_$datatype/asv_counts_dbOTU.tsv
python3 scripts/dbotu3.py temporary_$datatype/asv_counts_dbOTU.tsv chimeras_$datatype/nonchimeras_clean.fasta \
    -o OTUs_$datatype/OTUs.txt --membership OTUs_$datatype/OTUs_membership.txt --log logs_$datatype/OTU_log.txt \
    -d $genetic -a 0 -p $distribution