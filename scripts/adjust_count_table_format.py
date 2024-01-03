import argparse

parser = argparse.ArgumentParser(
                    description='''
                    Adds "/"/"/t" to the beginning of the count table
                    For it to be compatible with the UCHIME
                    ''',)

parser.add_argument('-c', '--count')      # count table
args = parser.parse_args()

with open(args.count, 'r') as original_file:
    # Read lines from the original file
    lines = original_file.readlines()
    with open(args.count, 'w') as new_file:
        # Write the first line to the new file, prepending "\t"
        if lines[0][0:3] != "\"\"\t":
            new_file.write("\"\"\t" + lines[0])
        else:
            new_file.write(lines[0])

        # Write the remaining lines to the new file
        for line in lines[1:]:
            new_file.write(line)