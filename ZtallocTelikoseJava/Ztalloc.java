import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Ztalloc {
  // The main function.
  public static void main(String args[]) {
	int Qgrammes=0,Lin=0,Rin=0,Lout=0,Rout=0,i=0,j=0,a=0;
	String[] tempo;
	String line;
	try {
		BufferedReader reader = new BufferedReader(new FileReader(args[0]));
		String s =reader.readLine();
		Qgrammes=Integer.parseInt(s);
		for (i=0;i<Qgrammes;i++) {
			Solver solver = new BFSolver();
	        //List<String> allPossible = new ArrayList<String>();
			line=reader.readLine();
			tempo=line.split(" ");
			Lin=Integer.parseInt(tempo[0]);
			Rin=Integer.parseInt(tempo[1]);
			Lout=Integer.parseInt(tempo[2]);
			Rout=Integer.parseInt(tempo[3]);
			State initial = new ZtallocState(Lin, Rin, 'z', null);
			solver.setLoutRout(Lout,Rout);
			State result = solver.solve(initial);
			//allPossible=GiaBfs.helper(a,Lout,Rout,allPossible,a==Lin);
			//System.out.println(str2);
			//System.out.println(Lin + " "+ Rin+ " "+Lout +" "+Rout);
			if (result == null) System.out.println("IMPOSSIBLE");
			else if(result.getPrevious()==null)System.out.println("EMPTY");
			else {
				printSolution(result); 
				System.out.println();
			}
		}
		reader.close();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
  }

  // A recursive function to print the states from the initial to the final.
  private static void printSolution(State s) {
    if (s.getPrevious() != null)  printSolution(s.getPrevious());
    else { 
    	//System.out.println();
    	return;
    	}
    System.out.print(s.getChar());
  }
}
