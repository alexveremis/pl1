import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

public class SaveTheCat {

	public static void main(String[] args) {
		int stiles=0,i=0,a=0,j=0,time=1;
		String line;
		List<String> list = new ArrayList<String>();
		try {
			BufferedReader reader = new BufferedReader(new FileReader(args[0]));
			while ((line = reader.readLine()) != null) {
				i++;
				stiles=line.length();
			}
			reader.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int grammes=i;
		char map1[][] = new char[grammes][stiles];
		int map2[][]= new int[grammes][stiles];
		i=0;
		try {
			BufferedReader reader2 = new BufferedReader(new FileReader(args[0]));
			while ((line = reader2.readLine()) != null) {
				list.add(line);
				for (j = 0; j < line.length(); j++)
					map1[i][j] = line.charAt(j);
				i++;
			}
			reader2.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		//List aqua and gatto
		List<Integer> aqua = new ArrayList<Integer>();
		Queue<Integer> aqua2 = new LinkedList<Integer>();

		List<Integer> gatto = new ArrayList<Integer>();
		for (i = 0; i<grammes; i++)
		    for (j = 0; j<stiles; j++) {
		        if(map1[i][j]=='W'){
		            aqua2.add(i);
		            aqua2.add(j);
		            map2[i][j]=0;
		            }
		        else if(map1[i][j]=='A'){
		            gatto.add(i);
		            gatto.add(j);
		            gatto.add(-1);
		            gatto.add(0);
		            map2[i][j]=-3;
		        }
		        else if(map1[i][j]=='.')map2[i][j]=-1;
		        else if(map1[i][j]=='X')map2[i][j]=-2;
		        else map2[i][j]=100;
		    }
		//System.out.println("oleee11");

		/*
		for (i = 0; i<grammes; i++) {
		    for (j = 0; j<stiles; j++) System.out.print(map2[i][j]);
		    System.out.println();} */
		//plimmira
		while (true) {
				int	hassthchanged=0,posastoixeiamesa=0,b=0;
				if(aqua2.size()>0) {
					hassthchanged=1;
					posastoixeiamesa=aqua2.size();
					i=aqua2.poll();
					j=aqua2.poll();
				}
				for(a=0;a<(posastoixeiamesa/2);a++) {
					if ((i+1 <grammes) && ((map2[i+1][j]==-1)|| (map2[i+1][j]==-3))) {
						aqua2.add(i+1);
						aqua2.add(j);
						map2[i+1][j]=time;}
					if((i-1>=0) && ((map2[i-1][j]==-1) ||(map2[i-1][j]==-3))) {
						aqua2.add(i-1);
						aqua2.add(j);
						map2[i-1][j]=time;}
					if((j+1<stiles)&&((map2[i][j+1]==-1)|| (map2[i][j+1]==-3))) {
						aqua2.add(i);
						aqua2.add(j+1);
						map2[i][j+1]=time;}
					if((j-1>=0) && ((map2[i][j-1]==-1)||(map2[i][j-1]==-3))) {
						aqua2.add(i);
						aqua2.add(j-1);
						map2[i][j-1]=time;}
					b=b+2;
					/*
					aqua2.poll();
					aqua2.poll();  */
					if(a<posastoixeiamesa/2 -1) {
							i=aqua2.poll();
		                    j=aqua2.poll();}
					}
				if (hassthchanged==0 || aqua2.size()==0) break;
				time=time+1;
				}
		//System.out.println("oleee");
		/* for (i = 0; i<grammes; i++) {
		    for (j = 0; j<stiles; j++) System.out.print(map2[i][j] + " ");
		    System.out.println();} */
		
		//pleon exei plimmirisei
		int foreversafe=1,mesa1=0,stay=1,best_time=-1,koutaki=0;
		int posastoixeiamesa=0,b=0,best_i, best_j;
		time=0;
		i=gatto.get(0);
		j=gatto.get(1);
		 if (map2[i][j]>0){
		                foreversafe=0;
		                best_time=map2[i][j]-1;
		                map2[i][j]=0;}
		 best_i=i;
		 best_j=j;
		//an einai forever safe
		 if (foreversafe==1)	
	            while (true){
	                    int added=0;
	                    posastoixeiamesa=gatto.size()-b;
	                    for (a=0;a<(posastoixeiamesa/4);a++) {
	                            i=gatto.get(b);
	                            j=gatto.get(b+1);
	                            if ((i+1 <grammes) && (map2[i+1][j]==-1)) {//down
	                                    added=added+1;
	                                    gatto.add(i+1);
	                                    gatto.add(j);
	                                    gatto.add(b);
	                                    gatto.add(1);
	                                    map2[i+1][j]=-5;}
	                            if((j-1>=0) && (map2[i][j-1]==-1)) { //left
	                                    added=added+1;
	                                    gatto.add(i);
	                                    gatto.add(j-1);
	                                    gatto.add(b);
	                                    gatto.add(2);
	                                    if((i<= best_i) && (j-1 <=best_j)){
	                                        koutaki=b+(posastoixeiamesa/4-a+added-1)*4;
	                                        stay=0;
	                                        best_i=i;
	                                        best_j=j-1;}
	                                    map2[i][j-1]=-5;}
	                            if((j+1<stiles)&& (map2[i][j+1]==-1)) {//right
	                                    added=added+1;
	                                    gatto.add(i);
	                                    gatto.add(j+1);
	                                    gatto.add(b);
	                                    gatto.add(3);
	                                    map2[i][j+1]=-5;}
	                            if((i-1>=0) && (map2[i-1][j]==-1)) { //up
	                                    added=added+1;
	                                    gatto.add(i-1);
	                                    gatto.add(j);
	                                    gatto.add(b);
	                                    gatto.add(4);
	                                    if(i-1<= best_i ) {
	                                            koutaki=b+(posastoixeiamesa/4-a+added-1)*4;
	                                            stay=0;
	                                            best_i=i-1;
	                                            best_j=j;}
	                                    map2[i-1][j]=-5;}
	                            b=b+4;}
	                    if(posastoixeiamesa==0)break; }
		 else
				while (true) {
					 int added=0;
	                 posastoixeiamesa=gatto.size()-b;
	                 for (a=0;a<(posastoixeiamesa/4);a++) {	 
	                	 i=gatto.get(b);
	                     j=gatto.get(b+1);
		                 if ((i+1 <grammes) && (map2[i+1][j]>time)) { //down
		                                        added=added+1;
		                                        gatto.add(i+1);
		                                        gatto.add(j);
		                                        gatto.add(b);
		                                        gatto.add(1);
		                                        if (best_time<map2[i+1][j]) {
		                                            best_time=map2[i+1][j]-1;
		                                            koutaki=b+(posastoixeiamesa/4-a+added-1)*4;
		                                            stay=0;
		                                            mesa1=1;
		                                            best_i=i+1;
		                                            best_j=j;}
		                                        map2[i+1][j]=-5;}
		                if((j-1>=0) && (map2[i][j-1]>time)) { //left
		                                        added=added+1;
		                                        gatto.add(i);
		                                        gatto.add(j-1);
		                                        gatto.add(b);
		                                        gatto.add(2);
		                                        if (best_time<map2[i][j-1]) {
		                                                stay=0;
		                                                if((mesa1==0) ||((i<=best_i) &&( j-1<best_j))|| (best_time+1 <map2[i][j-1])) {
		                                                            koutaki=b+(posastoixeiamesa/4-a+added-1)*4;
		                                                            best_time=map2[i][j-1]-1;
		                                                            mesa1=1;
		                                                            best_i=i;
		                                                            best_j=j-1;}}
		                                        map2[i][j-1]=-5;}
		               if((j+1<stiles)&& (map2[i][j+1]>time)) { //right
		                                        added=added+1;
		                                        gatto.add(i);
		                                        gatto.add(j+1);
		                                        gatto.add(b);
		                                        gatto.add(3);
		                                        if (best_time<map2[i][j+1]) {
		                                                stay=0;
		                                                if((mesa1==0)|| (best_time+1 <map2[i][j+1])) {
		                                                            koutaki=b+(posastoixeiamesa/4-a+added-1)*4;
		                                                            best_time=map2[i][j+1]-1;
		                                                            mesa1=1;
		                                                            best_i=i;
		                                                            best_j=j+1	;}}
		                                        map2[i][j+1]=-5;}
		               if((i-1>=0) && (map2[i-1][j]>time)) { //up
		                                        added=added+1;
		                                        gatto.add(i-1);
		                                        gatto.add(j);
		                                        gatto.add(b);
		                                        gatto.add(4);
		                                        if (best_time<map2[i-1][j]) {
		                                                stay=0;
		                                                if((mesa1==0) ||(i-1<best_i)|| (best_time+1 <map2[i-1][j])) {
		                                                            koutaki=b+(posastoixeiamesa/4-a+added-1)*4;
		                                                            best_time=map2[i-1][j]-1;
		                                                            best_i=i-1;
		                                                            best_j=j;}}
		                                        map2[i-1][j]=-5;}
		              b=b+4;}
		                        time=time+1;
		                        mesa1=0;
		                        if(posastoixeiamesa==0)break;}
		 // ole2
			//System.out.println("oleee2");
		 
		 //teleytaia pragmata
		 if (foreversafe==1) System.out.println("infinity");
		 else if(best_time>-1)System.out.println(best_time);
     //kiniseis33=collections.deque();  //create list name kiniseis 
     List<Character> kiniseis = new ArrayList<Character>();
     int tempo;
     while(b>-1) {
             b=gatto.get(koutaki+2);
             tempo=gatto.get(koutaki+3);
             koutaki=b;
             if(tempo==1)kiniseis.add('D');
             else if(tempo==2)kiniseis.add('L');
             else if(tempo==3)kiniseis.add('R');
             else if(tempo==4)kiniseis.add('U');
                     }
     //int megethoskin=kiniseis.size();
     Collections.reverse(kiniseis);
     String teliko =kiniseis.toString() .replace("[", "").replace("]", "").replace(",", "").replace(" ","");
	char[] teliko2 = teliko.toCharArray();
     if(stay==1)System.out.println("stay");
     else  System.out.println(teliko2);
		 
		 
		 
		 
		 
		 
	}
}
