import java.util.*;

/* A class that implements a solver that explores the search space
 * using breadth-first search (BFS).  This leads to a solution that
 * is optimal in the number of moves from the initial to the final
 * state.
 */
public class BFSolver implements Solver {
	private int Lout,Rout;
  @Override
  public State solve (State initial) {
	int count=0;
	int[] episkeptis= new int [1000000];
	for(int i=0;i<1000000;i++)episkeptis[i]=0;
    Set<State> seen = new HashSet<>();
    Queue<State> remaining = new ArrayDeque<>();
    remaining.add(initial);
    seen.add(initial);
    while (!remaining.isEmpty()) {
      State s = remaining.remove();
      seen.add(s);
      if (s.isFinal(Lout,Rout)) {return s;}
      Collection<State> states = new ArrayList<>();
      states=s.next(seen,episkeptis);
      for (State n :states)
        if (!seen.contains(n) && episkeptis[n.getR()]<5){
          remaining.add(n);
          seen.add(n);
          if (n.getL()==n.getR())episkeptis[n.getR()]+=2;
        }
        else count++;
      if (seen.size()>9999999) {System.out.println(remaining.size()); break;}
    }
    return null;
  }
  
  
  
  public void setLoutRout(int lout, int rout) {
	  Lout=lout;
	  Rout=rout;
  }
}
