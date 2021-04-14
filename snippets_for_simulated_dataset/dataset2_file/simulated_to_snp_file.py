a_file = open("dataset2.txt")
file1 = open("dataset2_file/snpfile.snp", "w") 
lines_to_read = []
snp = []
for i in range(42, 254, 10):
    lines_to_read.append(i)
print(lines_to_read)

for position, line in enumerate(a_file):
# Iterate over each line and its index
    if position in lines_to_read:
        snp.append(line)



for i in range(len(snp)):
    #print(i)
    data=list(snp[i].split(" "))
    for j in range(len(data)-1):
        L = ("snp"+str(i+1).zfill(3)+"-"+str(j+1)+"\t",str(i+1)+"\t",(data[j])+"\n")
        file1.writelines(L)

