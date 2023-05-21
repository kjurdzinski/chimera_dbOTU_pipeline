import argparse

parser = argparse.ArgumentParser(
                    description='''
                    Removes anything after \";\" from captions in a fasta file
                    and writes it to a new
                    ''',)

parser.add_argument('fasta')      # fasta file
parser.add_argument('-o', '--output')     # name of the output fasta file
args = parser.parse_args()

with open(args.fasta, 'r') as input_file, open(args.output, 'w') as output_file:
    for line in input_file:
        if line.startswith('>'):
            line = line.split(';')[0] + '\n'  # remove the part after ";" and add a newline character
        output_file.write(line)
