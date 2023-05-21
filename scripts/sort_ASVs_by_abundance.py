import argparse
import pandas as pd
from Bio import SeqIO

parser = argparse.ArgumentParser(
                    description='''
                    Sorts a fasta file by adundance given a count table
                    with rows corresponding to sequences (same names in both files)
                    ''',)


parser.add_argument('fasta')      # fasta file
parser.add_argument('-c', '--count')      # count table
parser.add_argument('-o', '--output')     # name of the output fasta file
args = parser.parse_args()

# Load the count table
df_counts = pd.read_csv(args.count, sep="\t", index_col=0)

# Sum up the counts for each sequence
df_counts["sum_counts"] = df_counts.sum(axis=1)

# Load the fasta file and add the count information to the header
records = []
for record in SeqIO.parse(args.fasta, "fasta"):
    seq_name = record.id
    seq_count = int(df_counts.loc[seq_name, "sum_counts"])
    record.id = f"{seq_name};size={seq_count}"
    record.description = ""
    records.append(record)

# Sort the fasta file by decreasing sum of counts
records_sorted = sorted(records, key=lambda x: int(x.id.split(";size=")[1]), reverse=True)

# Write the sorted fasta file to disk
SeqIO.write(records_sorted, args.output, "fasta")
