from nltk.grammar import Nonterminal, PCFG
from pcfg_generate import *


grammar = """
    S -> 'a' V 'b' [0.25] | 'b' V 'a' [0.25] | 'a' W 'a' [0.125] | 'a' W 'b' [0.125] | 'b' W 'a' [0.125] | 'b' W 'b' [0.125]
    V -> 'v0' [0.2] | 'v1' [0.2] | 'v2' [0.2] | 'v3' [0.2] | 'v4' [0.2]
    W -> 'w0' [0.2] | 'w1' [0.2] | 'w2' [0.2] | 'w3' [0.2] | 'w4' [0.2]
"""
print(grammar)

nonconflation = PCFG.fromstring(grammar)

print(nonconflation)

"""
texto = ""
for sentence in pcfg_generate(nonconflation, n=100000, depth=6):
    #print(' '.join(sentence))
    #print(sentence)
    str1 = ' '.join(sentence)
    texto = texto  + str1 + '\n'
"""

with open('nonconflation.txt', 'w') as f:
    for sentence in pcfg_generate(nonconflation, n=100000, depth=100):
       f.write(' '.join(sentence) +'\n')


