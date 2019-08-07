import math
import argparse


import numpy as np
from nltk.parse.generate import generate
from nltk import PCFG
from gensim.models import Word2Vec
from gensim.models import FastText



parser = argparse.ArgumentParser(description='w2vFT')
parser.add_argument(
    '--corpus',
    '-c',
    dest='corpus',
    action='store',
    required=True,
    help='corpus'
)

parser.add_argument(
    '--base',
    '-b',
    dest='base',
    action='store',
    required=True,
    help='base'
)
args = parser.parse_args()

corpus_file = args.base + "/" + args.corpus 
base = args.base 


#modelSG = Word2Vec(sentencia, sg=1,window=1,min_count=1)
output = base + "/gSG_" + base + ".vec"
modelSG = Word2Vec(corpus_file=corpus_file, sg=1,window=1,min_count=1)
modelSG.wv.save_word2vec_format(output, binary=False)

#modelCB = Word2Vec(sentencia, sg=0,window=1,min_count=1)
output = base + "/gCB_" + base + ".vec"
modelCB = Word2Vec(corpus_file=corpus_file, sg=0,window=1,min_count=1)
modelCB.wv.save_word2vec_format(output, binary=False)

output = base + "/gFT_" + base + ".vec"
modelFT = FastText(window=1, min_count=1,sg=1)
modelFT.build_vocab(corpus_file=corpus_file)  # scan over corpus to build the vocabulary
total_words = modelFT.corpus_total_words  # number of words in the corpus
modelFT.train(corpus_file=corpus_file, total_words=total_words, epochs=5)
modelFT.wv.save_word2vec_format(output, binary=False)





