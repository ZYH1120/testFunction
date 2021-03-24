import sys
import time
def main(args):
    stime=time.time()*1000
    list=[]
    i=0
    while i<5000000:
        list.append(i)
        i=i+1
    sum=0
    for x in list:
        sum+=x

    etime=time.time()*1000
    return {"res:": etime-stime }
