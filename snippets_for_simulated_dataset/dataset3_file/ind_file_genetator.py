file1 = open("indfile.ind", "w") 


for i in range(500):
    if(i<50):
        L = ("ind"+str(i+1).zfill(3)+"pop1\t","U\t","POP1\n")
    elif(i >=50 and i<150):
        L = ("ind"+str(i+1).zfill(3)+"pop2\t","U\t","POP2\n")
    elif(i >=150 and i<300):
        L = ("ind"+str(i+1).zfill(3)+"pop3\t","U\t","POP3\n")
    else:
        L = ("ind"+str(i+1).zfill(3)+"pop4\t","U\t","POP4\n")
    file1.writelines(L)

