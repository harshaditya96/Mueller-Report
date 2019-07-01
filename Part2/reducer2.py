from operator import itemgetter
import sys

current_wordpair = None
current_count = 0
word = None

for line in sys.stdin:
    line = line.rstrip()
    wordpair, count = line.split('\t', 1)

    try:
        count = int(count)
    except ValueError:
        continue

    if current_wordpair == wordpair:
        current_count += count
    else:
        if current_wordpair:
            # write result to STDOUT
            print(current_wordpair, current_count)
        current_count = count
        current_wordpair = wordpair

if current_wordpair == wordpair:
    print(current_wordpair, current_count)
