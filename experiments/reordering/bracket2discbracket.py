#!/usr/bin/python

from nltk.tree import Tree
import sys



import sys

filepath = sys.argv[1]
f = open(filepath)
size_sent=0

sent_order=[]

for line in f:
    sent_order.append(line.split(' '))

    
    
f.close()


num_sent=0
for line in sys.stdin:

    t = Tree.fromstring(line)

    sent=t.leaves()

    cont=0
    for leafPos in t.treepositions('leaves'):

        t[leafPos]=sent_order[num_sent][cont]
        cont+=1


    num_sent+=1

    parse_string = ' '.join(str(t).split())
    print(parse_string)

