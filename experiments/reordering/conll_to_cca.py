import sys

filepath = sys.argv[1]
f = open(filepath)
size_sent=0

sent=dict()

for line in f:
    line = line.strip()
    if len(line)==0:
        size_sent = 0
        cont=1
        for e in sent:
            print(sent[cont]+' ', end='')
            cont+=1
        print()
        sent.clear()
    else:
        size_sent+=1
        fields = line.split('\t')

        index = fields[0]
        word = fields[1]
        head = fields[6]
        pos_real=int(index)-1
        sent[int(head)]=str(pos_real)+'='+word




f.close()
