#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Apr  4 10:11:21 2019

@author: akhila
"""
#import java.io.IOException;
#import java.util.StringTokenizer;
"""import org
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;"""

import urllib.request
from bs4 import BeautifulSoup
import pandas as pd
import csv

## List of all the files
files = ['Decembe18_URL.csv', 'Mar23Apr3_URL.csv', 'Jan2231_URL.csv', 'Jan0121_URL.csv',
            'Feb0115_URL.csv', 'Mar0122_URL.csv', 'Apr0414_URL.csv']


def main(files = files):
    art_df = pd.DataFrame(index=None,columns=['text'])
    for file in files:
        with open(file, 'r') as csvfile:
            
            spamreader = csv.reader(csvfile)
            for row in spamreader:
                
                url = row[1]
                if url !=  'x':
                    try : 
                        html = urllib.request.urlopen(url).read()
                        soup = BeautifulSoup(html)
                    
                        for story_heading in soup.find_all(class_="meteredContent"): 
                            soup = story_heading 
                            ## Extract the script
                            for script in soup(["script", "style"]):
                                script.extract()    # rip it out
                
                        ## Extract the text
                        text = soup.get_text()
                        art_df.loc[art_df.shape[0]] = text.replace("\n","")
                    
                    except:
                        print('text invalid')
                ## Output the articles dataframe as CSV
                art_df.to_csv('Article_DF.csv')
            print(art_df)


if __name__ == "__main__":
    main()

