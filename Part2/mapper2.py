import sys
import nltk
from nltk.tokenize import TweetTokenizer
from nltk.tokenize import word_tokenize
import pandas as pd
import clean

tknzr = TweetTokenizer(strip_handles=True, reduce_len=True)

top10 = ["wall", "obama", "witch", "impeach", "trump", "report", "mueller", "russia"]

def read_input(file):
    file = pd.read_csv(file)
    file = file["text"]
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
        words = [word for word in words if word in top10]
                
        for i in range(len(words)-1):
            for j in range(i+1,len(words)):
                if words[i] != words[j]:
                    print((words[i],words[j]), 1, sep=separator)
                

if __name__ == "__main__":
	main()
