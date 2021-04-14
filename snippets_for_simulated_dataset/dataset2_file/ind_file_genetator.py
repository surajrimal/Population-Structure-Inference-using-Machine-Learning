file1 = open("dataset2_file/indfile.ind", "w") 


for i in range(400):
    if(i<100):
        L = ("ind"+str(i+1).zfill(3)+"pop1\t","U\t","POP1\n")
    elif(i >=100 and i<200):
        L = ("ind"+str(i+1).zfill(3)+"pop2\t","U\t","POP2\n")
    elif(i >=200 and i<300):
        L = ("ind"+str(i+1).zfill(3)+"pop3\t","U\t","POP3\n")
    else:
        L = ("ind"+str(i+1).zfill(3)+"pop4\t","U\t","POP4\n")
    file1.writelines(L)

