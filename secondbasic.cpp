#include <iostream>
#include <fstream>
#include <vector>
#include <ctime>
#include <string>

using namespace std;

int main(int argc, char *argv[])
{
int i,j,grammes=0,stiles=0,a,b;
char c;
vector<int> acqua;
vector<int> ilgatto;
ifstream fp;
fp.open(argv[1]);
 while (fp.get(c)) {
        stiles++;
        if (c=='\n') {grammes ++;}
    }
stiles=stiles/grammes;
fp.clear();
fp.seekg(0);
char **map1 = new char*[grammes];
for(int kappa = 0; kappa< grammes; ++kappa) {
    map1[kappa] = new char[stiles];
}
//char map1 [grammes][stiles];
int **map2 = new int*[grammes];
for(int kappa = 0; kappa< grammes; ++kappa) {
    map2[kappa] = new int[stiles];
}
//int map2 [grammes][stiles];
//printf("lines: %d\nstiles :%d\n",grammes,stiles);
//fp.open(argv[1]);

for (i = 0; i<grammes; i++)
    for (j = 0; j<stiles; j++) {
        fp.get(c);
        if((c!='\n')&& (c!='\0'))map1[i][j]=c;
        if(map1[i][j]=='W'){
            acqua.push_back(i);
            acqua.push_back(j);
            acqua.push_back(0);
            map2[i][j]=0;
            }
        else if(map1[i][j]=='A'){
            ilgatto.push_back(i);
            ilgatto.push_back(j);
            ilgatto.push_back(-1);
            ilgatto.push_back(0);
            map2[i][j]=-3;
        }
        else if(map1[i][j]=='.')map2[i][j]=-1;
        else if(map1[i][j]=='X')map2[i][j]=-2;
        else map2[i][j]=100;
    }
fp.close();
stiles--;
//exoyme map1 kai map2
int time=1;
int posastoixeiaexeimesa;
while(true){
    bool hassthchanged=false;
    posastoixeiaexeimesa=0,b=0;
    //cout <<acqua.size();
    if (acqua.size()!=0){
        hassthchanged=true;
        i=acqua[b];
        j=acqua[b+1];
        posastoixeiaexeimesa=acqua.size();
    }
    for(a=0;a<(posastoixeiaexeimesa/3);a++){
    if ((i+1 <grammes) && ((map2[i+1][j]==-1)|| (map2[i+1][j]==-3))){
        acqua.push_back(i+1);
        acqua.push_back(j);
        acqua.push_back(time);
        map2[i+1][j]=time;}
    if((i-1>=0) && ((map2[i-1][j]==-1)||(map2[i-1][j]==-3))){
        acqua.push_back(i-1);
        acqua.push_back(j);
        acqua.push_back(time);
        map2[i-1][j]=time;}
    if((j+1<stiles)&&((map2[i][j+1]==-1)|| (map2[i][j+1]==-3))){
        acqua.push_back(i);
        acqua.push_back(j+1);
        acqua.push_back(time);
        map2[i][j+1]=time;}
    if((j-1>=0) && ((map2[i][j-1]==-1)||(map2[i][j-1]==-3))){
        acqua.push_back(i);
        acqua.push_back(j-1);
        acqua.push_back(time);
        //snprintf(buf,sizeof(buf) ,"%d", time);
        map2[i][j-1]=time;}
    b=b+3;
    i=acqua[b];
    j=acqua[b+1];
    }

    acqua.erase(acqua.begin(),acqua.begin()+posastoixeiaexeimesa);
    if (!hassthchanged) break;
    time++;
}
//exoyme ston map2 ton xrono poy plimirizei ka8e kouti
/*
for (i = 0; i<grammes; i++){
    for (j = 0; j<stiles; j++)cout<<(map2[i][j])<<" "; cout << endl;}
        cout << endl;
*/
bool foreversafe=true,stay=true;
int best_time=-1,koutaki=0,added,best_i,best_j;
time=0;
i=ilgatto[0];
j=ilgatto[1];
//tsekarisma gia tin idia ti 8esi tis gatas den 8a einai safe an mpei sto if alla 8a ginetai stay an den mporei na paei allou
if(map2[i][j]>0){
    foreversafe=false;
    best_time=map2[i][j]-1;
    map2[i][j]=0;
}
//epanalispi while gia oles tis ypoloipes 8eseis
bool mesa1;
posastoixeiaexeimesa=0,b=0;
best_i=ilgatto[0];
best_j=ilgatto[1];
if(foreversafe)while(true){
        added=0;
    if (ilgatto.size()!=0){
        i=ilgatto[b];
        j=ilgatto[b+1];
        posastoixeiaexeimesa=ilgatto.size()-b;
    }
    for(a=0;a<(posastoixeiaexeimesa/4);a++){
    if (i+1 <grammes && (map2[i+1][j]==-1)) {//DOWN
        added++;
        ilgatto.push_back(i+1);
        ilgatto.push_back(j);
        ilgatto.push_back(b);
        ilgatto.push_back(1);
        map2[i+1][j]=-5;
        }
    if(j-1>=0 &&( map2[i][j-1]==-1)) {//LEFT
        added++;
        ilgatto.push_back(i);
        ilgatto.push_back(j-1);
        ilgatto.push_back(b);
        ilgatto.push_back(2);
        if(i<= best_i && j-1 <=best_j){
            koutaki=b+(posastoixeiaexeimesa/4-a+added-1)*4;//gia isotita ena if(a!=0)
            stay=false;
            best_i=i;
            best_j=j-1;}
        map2[i][j-1]=-5;
        }
    if((j+1<stiles)&&((map2[i][j+1]==-1))){//RIGHT
        added++;
        ilgatto.push_back(i);
        ilgatto.push_back(j+1);
        ilgatto.push_back(b);
        ilgatto.push_back(3);
        map2[i][j+1]=-5;
        }
    if((i-1>=0) && ((map2[i-1][j]==-1))){ //UP
        added++;
        ilgatto.push_back(i-1);
        ilgatto.push_back(j);
        ilgatto.push_back(b);
        ilgatto.push_back(4);
        if(i-1<= best_i ){
            koutaki=b+(posastoixeiaexeimesa/4-a+added-1)*4;
            stay=false;
            best_i=i-1;
            best_j=j;}
        map2[i-1][j]=-5;
        }
    b=b+4;
    i=ilgatto[b];
    j=ilgatto[b+1];
    }
    //time++;
    mesa1=false;
    //ilgatto.erase(ilgatto.begin(),ilgatto.begin()+posastoixeiaexeimesa);
    if (!posastoixeiaexeimesa) break;
}






else while(true){
    //cout <<ilgatto.size();
    added=0;
    if (ilgatto.size()!=0){
        i=ilgatto[b];
        j=ilgatto[b+1];
        posastoixeiaexeimesa=ilgatto.size()-b;
    }
    for(a=0;a<(posastoixeiaexeimesa/4);a++){
    if ((i+1 <grammes) && ((map2[i+1][j]>time))){//DOWN
        added++;
        ilgatto.push_back(i+1);
        ilgatto.push_back(j);
        ilgatto.push_back(b);
        ilgatto.push_back(1);
        if (best_time<map2[i+1][j]){
            best_time=map2[i+1][j]-1;
            koutaki=b+(posastoixeiaexeimesa/4-a+added-1)*4;
            stay=false;
            map2[i+1][j]=-5;
            mesa1=true;
            best_i=i+1;
            best_j=j;
            }
        else map2[i+1][j]=0;

        }
    if((j-1>=0) && ((map2[i][j-1]>time))){//LEFT
        added++;
        ilgatto.push_back(i);
        ilgatto.push_back(j-1);
        ilgatto.push_back(b);
        ilgatto.push_back(2);
        if (best_time<map2[i][j-1]){
            if(!mesa1 ||(i<=best_i && j-1<best_j)||best_time+1 <map2[i][j-1]){
                    koutaki=b+(posastoixeiaexeimesa/4-a+added-1)*4;//gia isotita ena if(a!=0)
                    best_time=map2[i][j-1]-1;
                    mesa1=true;
                    best_i=i;
                    best_j=j-1;
                    }
            stay=false;
            map2[i][j-1]=-5;
            }
        else map2[i][j-1]=0;
        }
    if((j+1<stiles)&&((map2[i][j+1]>time))){//RIGHT
        added++;
        ilgatto.push_back(i);
        ilgatto.push_back(j+1);
        ilgatto.push_back(b);
        ilgatto.push_back(3);
        if (best_time<map2[i][j+1]){
             if(!mesa1 ||best_time+1<map2[i][j+1]){
                koutaki=b+(posastoixeiaexeimesa/4-a+added-1)*4;
                best_time=map2[i][j+1]-1;
                mesa1=true;
                best_i=i;
                best_j=j+1;
                }
            stay=false;
            map2[i][j+1]=-5;
            }
        else map2[i][j+1]=0;
        }
    if((i-1>=0) && ((map2[i-1][j]>time))){ //UP
        added++;
        ilgatto.push_back(i-1);
        ilgatto.push_back(j);
        ilgatto.push_back(b);
        ilgatto.push_back(4);
        if (best_time<map2[i-1][j]){
            if (!mesa1 ||(i-1<best_i)|| best_time+1<map2[i-1][j]){
                    koutaki=b+(posastoixeiaexeimesa/4-a+added-1)*4;
                    best_time=map2[i-1][j]-1;}
                    stay=false;
                    map2[i-1][j]=-5;
                    best_i=i-1;
                    best_j=j;
            }
        else map2[i-1][j]=0;
        }
    b=b+4;
    i=ilgatto[b];
    j=ilgatto[b+1];
    }
    time++;
    mesa1=false;
    //ilgatto.erase(ilgatto.begin(),ilgatto.begin()+posastoixeiaexeimesa);
    if (!posastoixeiaexeimesa) break;
}

if(foreversafe)cout<<"infinity"<<endl;
/*
for (i = 0; i<grammes; i++){
    for (j = 0; j<stiles; j++)cout<<(map2[i][j])<<" "; cout << endl;}
        cout << endl;
        */
string kiniseis;
//kiniseis+='\0';
int tempo;

while(b!=-1){
    b=ilgatto[koutaki+2];
    tempo=ilgatto[koutaki+3];
    koutaki=b;
    if(tempo==1)kiniseis=kiniseis+'D';
    else if(tempo==2)kiniseis=kiniseis+'L';
    else if(tempo==3)kiniseis=kiniseis+'R';
    else if(tempo==4)kiniseis=kiniseis+'U';
    }
if(best_time!=-1)cout<<best_time<<endl;
//if(kiniseis!='\0')cout<<endl;
if(stay)cout<<"stay"<<endl;
else{ for(int i = kiniseis.length() - 1; i >= 0; --i){
    cout << kiniseis[i];
    }
}
//else cout<<kiniseis<<endl;
 return 0;
}
