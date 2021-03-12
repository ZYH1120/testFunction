def main(args):
    list=[];
    i=0
    while i<10000000:
        list.append(i)
        i=i+1
    sum =0
    for x in list:
        sum=sum+x
    
    return {"res:":sum}
