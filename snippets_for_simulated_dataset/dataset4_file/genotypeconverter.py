a_file = open("dataset4.txt")
file1 = open("dataset4_file/genofile2.eigenstratgeno", "w") 
lines_to_read = []
snp = []
for i in range(273, 893, 1):
    lines_to_read.append(i)

for position, line in enumerate(a_file):
# Iterate over each line and its index
    if position in lines_to_read:
        snp.append(line)

geno = []
for i in range(len(snp)-1):
    #print(i)
    data=list(snp[i].split(" "))
    geno.append(data[1])
    
new_geno = []
for i in range(len(geno[0])):
    r = ''
    for j in range(len(geno)):
        r += geno[j][i]
    new_geno.append(r)
for ng in new_geno:
    L = ng+"\n"
    file1.writelines(L)