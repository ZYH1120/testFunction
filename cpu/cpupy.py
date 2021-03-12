import math
def main(args):
    list=[]
    i=1
    while i<100000:
        list.append(i)
        i=i+1
    sum =0
    for x in list:
        sum+=math.atan(x)
    return {"res:":sum}
