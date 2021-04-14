file1 = open("dataset4_file/indfile.ind", "w") 


for i in range(620):
    if(i<160):
        L = ("ind"+str(i+1).zfill(3)+"pop1\t","U\t","POP1\n")
    elif(i >=160 and i<360):
        L = ("ind"+str(i+1).zfill(3)+"pop2\t","U\t","POP2\n")
    elif(i >=360 and i<520):
        L = ("ind"+str(i+1).zfill(3)+"pop3\t","U\t","POP3\n")
    else:
        L = ("ind"+str(i+1).zfill(3)+"pop4\t","U\t","POP4\n")
    file1.writelines(L)

