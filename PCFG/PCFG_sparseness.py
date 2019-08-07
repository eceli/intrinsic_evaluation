from nltk.grammar import Nonterminal, PCFG
from pcfg_generate import *


sparseness = PCFG.fromstring("""
    S -> A V B [0.5] | C W D [0.5] 
    A -> 'a0' [0.1] | 'a1' [0.1] | 'a2' [0.1] | 'a3' [0.1] | 'a4' [0.1] | 'a5' [0.1] | 'a6' [0.1] | 'a7' [0.1] | 'a8' [0.1] | 'a9' [0.1]
    B -> 'b0' [0.1] | 'b1' [0.1] | 'b2' [0.1] | 'b3' [0.1] | 'b4' [0.1] | 'b5' [0.1] | 'b6' [0.1] | 'b7' [0.1] | 'b8' [0.1] | 'b9' [0.1]
    C -> 'c0' [0.1] | 'c1' [0.1] | 'c2' [0.1] | 'c3' [0.1] | 'c4' [0.1] | 'c5' [0.1] | 'c6' [0.1] | 'c7' [0.1] | 'c8' [0.1] | 'c9' [0.1]
    D -> 'd0' [0.1] | 'd1' [0.1] | 'd2' [0.1] | 'd3' [0.1] | 'd4' [0.1] | 'd5' [0.1] | 'd6' [0.1] | 'd7' [0.1] | 'd8' [0.1] | 'd9' [0.1]
    V -> 'v0' [0.1] | 'v1' [0.1] | 'v2' [0.1] | 'v3' [0.1] | 'v4' [0.1] | 'v5' [0.1] | 'v6' [0.1] | 'v7' [0.1] | 'v8' [0.1] | 'v9' [0.1]    
    W -> 'w0' [0.1] | 'w1' [0.1] | 'w2' [0.1] | 'w3' [0.1] | 'w4' [0.1] | 'w5' [0.1] | 'w6' [0.1] | 'w7' [0.1] | 'w8' [0.1] | 'w9' [0.1]    
""")
print(sparseness)

texto = ""
context_ab = ""
context_cd = ""
for sentence in pcfg_generate(sparseness, n=100000, depth=6):
    #print(' '.join(sentence))
    #print(sentence)
    str1 = ' '.join(sentence)
    texto = texto + str1 + '\n' 

for i in range(10):
    context_ab = context_ab + 'a' +str(i) + ' ' + 'u' +str(i) + ' ' + 'b' +str(i) + ' '   + '\n' 
  	
for i in range(10):
    context_cd = context_cd + 'c' +str(i) + ' ' + 'x' +str(i) + ' ' + 'd' +str(i) + ' '   + '\n' 

texto = texto + context_ab + context_cd

archivo_destino = 'sparseness.txt'
with open(archivo_destino, 'w') as file:
    file.write(texto)


