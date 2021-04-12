#!/usr/bin/python

from nltk.tree import Tree
import sys



for line in sys.stdin:

    t = Tree.fromstring(line)
    sent=t.leaves()
    postags=t.pos()
    pos_cont=1
    real_words=[0 for e in range(len(sent))]

    for a,p in postags:
        #print(p,a)
        cads=a.split('=')
        pos_real=cads[0]
        word=cads[1]
        id=int(pos_real)+1
        rel='X'
        if id!=pos_cont:rel='DISC'
        real_words[int(pos_real)]=str(id)+'\t'+word+'\t_\t'+p+'\t'+p+'\t_\t'+str(pos_cont)+'\t'+rel+'\t_\t_'
        pos_cont+=1


    for c in real_words:
        print(c)
    print()

