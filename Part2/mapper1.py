 #!/usr/bin/env python
import sys
import nltk
from nltk.tokenize import TweetTokenizer
from nltk.tokenize import word_tokenize
import pandas as pd
import clean

tknzr = TweetTokenizer(strip_handles=True, reduce_len=True)

# define subtopics
subtopics = ["wall", "obama", "witch", "impeach"]

def read_input(file):
    file = pd.read_csv(file)
    file = file["text"][0:10]
    # tokenize
    for line in file:   
        line = clean.denoise_text(line)
        words = tknzr.tokenize(line) # different
        words = clean.normalize(words)
        yield words

def main(separator='\t'):
    # input comes from STDIN (standard input)
    data = read_input(sys.stdin)
	
    for words in data:
    # write the results to STDOUT (standard output);
    # what we output here will be the input for the
    # Reduce step, i.e. the input for reducer.py
    #
    # tab-delimited; the trivial word count is 1
        for word in words:
            print(("all",word),separator, 1)
        for subtopic in subtopics:
            if subtopic in words:
                for word in words:
                    print((subtopic,word),separator, 1)

if __name__ == "__main__":
	main()

