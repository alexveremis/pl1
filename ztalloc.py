#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import collections

def process(f):
        #hartis1 = f.read().split(" ")
        #Qgrammes=hartis1[0][0]
        Q=(int(x) for x in next(f).split())
        # Converting integer list to string list 
        s = [str(i) for i in Q] 
        # Join list items using join() 
        Qgrammes = int("".join(s)) 
        #print(Qgrammes)
        for i in range(Qgrammes):
            Lin,Rin,Lout,Rout=(int(x) for x in (next(f).split()))
            allPossible=collections.deque()
            allPossible.clear()
            ch=""
            allPossible.append(Lin)
            allPossible.append(Rin)
            allPossible.append(ch)
            ch=vasikia2(Lout,Rout,allPossible)
            if ch=="":
                print("EMPTY")
            else :
                print(ch)
            #print(Lin,Rin,Lout,Rout)
                #N, K = map(int, f.readline().split())
                #C = list(map(int, f.readline().split()))
        #print (len(hartis1),len(hartis1[1]))
        #vasikia(hartis1)
	
def isFinal(L,R,Lout,Rout):
    if (R<=Rout and L>=Lout):
        return True
   
        
    
def vasikia2(Lout,Rout,allPossible):
        #seen=collections.deque
        count=0
        check=False
        #for i in range (10000000):
        episkeptis=[0]*1000000
        while len(allPossible)!=0 and count<5000000:
                count=count+1
                L=allPossible.popleft()
                R=allPossible.popleft()
                ch=allPossible.popleft()
                if (L==R):
                        check=True
                if not check:
                        episkeptis[R]=episkeptis[R]+1
                else:
                        episkeptis[R]=episkeptis[R]+2       
                if isFinal(L,R,Lout,Rout):
                        return ch
               # if !seen.contain(L,R):
                if (R>0 and episkeptis[R//2]<3):
                                allPossible.append(L//2)
                                allPossible.append(R//2)
                                allPossible.append(ch+"h")
                                if check:
                                        episkeptis[R//2]=episkeptis[R//2]+2
                                else:
                                        episkeptis[R//2]=episkeptis[R//2]+1   
                if (R*3+1<1000000 and check and episkeptis[R*3+1]<3):
                                allPossible.append(L*3+1)
                                allPossible.append(R*3+1)
                                allPossible.append(ch+"t")
                                episkeptis[R*3+1]=episkeptis[R*3+1]+2
        #print(len(allPossible))
        return "IMPOSSIBLE"

      
if __name__ == "__main__":
        import sys
        if len(sys.argv) > 1:
                with open(sys.argv[1], "rt") as f:
                        process(f)
        else:
                process(sys.stdin)
