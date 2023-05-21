import os
import pandas as pd
import argparse


parser = argparse.ArgumentParser(
                    description='''
                    Adjusts a count table for format required by dbOTU3.py
                    as well as removes all the ASVs from the count table
                    which are not in a given fasta file
                    ''',)


parser.add_argument('count')      # fasta file
parser.add_argument('-f', '--fasta')      # count table
parser.add_argument('-o', '--output')     # name of the output fasta file
args = parser.parse_args()

# os.chdir('/home/krzjur/ASV-clustering/data/16S')

# Load the TSV file into a pandas dataframe
df = pd.read_csv(args.count, sep='\t')

# Load the fasta file into a list of strings
with open(args.fasta, 'r') as f:
    fasta_lines = f.readlines()

# Filter out the sequence headers that are not in the count table
header_lines = [line for line in fasta_lines if line.startswith('>')]
header_ids = [line.strip()[1:] for line in header_lines]  # extract the sequence IDs from the header lines

df = df.loc[header_ids]

# Save it again
df.to_csv(args.output, sep='\t')