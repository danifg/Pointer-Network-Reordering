import sys

filepath = sys.argv[1]
f = open(filepath)
size_sent=0

sent=dict()



for line in f:
    line = line.strip()
    #print(line)

    if len(line)==0:
        size_sent = 0
        cont=1
        print('(S ', end='')
        for e in sent:
            print(sent[cont]+' ', end='')
            cont+=1
        print(')')
        sent.clear()
    else:
        size_sent+=1
        fields = line.split('\t')

        index = fields[0]
        word = fields[1]
        postag = fields[4]
        head = fields[6]
        pos_real=int(index)-1
        sent[int(head)]='('+postag+' '+word+')'




f.close()
