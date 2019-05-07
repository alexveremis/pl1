#include <stdio.h>
#include <stdlib.h>


int main(int argc, char **argv)
{
    int N,k,i,count=0;
    FILE *fp;
    fp=fopen(argv[1], "r");
    if (fp == NULL)
            {
              printf("Error! Could not open file\n");
              exit(-1); // must include stdlib.h
            }
    fscanf(fp, "%d %d", &N, &k);

    int *basicArray;
    basicArray=(int*)malloc(N * sizeof(int));

    for (i=0;i<N;i++) {
    fscanf(fp, "%d",&basicArray[i]);
    }
    /*
    scanf("%d %d",&N, &k);
    for (i=0;i<N;i++) {
        scanf("%d",&basicArray[i]);
    }
    */
    int pin1mexrik[k+1];
    for (i=0;i<k+1;i++)pin1mexrik[i]=0;

    for (i=0;i<N;i++) {
        if(pin1mexrik[basicArray[i]]==0)count++;
        pin1mexrik[basicArray[i]]++;
    }
    if (count!=k) {
            printf("%d\n",0);
            return 0;
    }
	
    count=0;
    int begin=0, end=-1,best=-1;
    for (i=0;i<k+1;i++)pin1mexrik[i]=0;

    //while(1)
    for(i=0;i<N+1;i++){
        if (count<k){
            //end++;
            end=i;
            if (end==N)break;
            if(pin1mexrik[basicArray[end]]==0)count++;
            pin1mexrik[basicArray[end]]++;
        }
        else{
            while (pin1mexrik[basicArray[begin]]>1){
                pin1mexrik[basicArray[begin]]--;
                begin++;
            }
            if (best>end-begin +1 ||best==-1 )best=end-begin+1;
            pin1mexrik[basicArray[begin]]--;
            begin++;
            count--;
        }
    }

    fclose(fp);
    printf("%d\n",best);
    return 0;
}
