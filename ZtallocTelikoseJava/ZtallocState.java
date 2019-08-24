import java.util.*;

/* A class implementing the state of the well-known problem with the
 * wolf, the goat and the cabbage.
 */
public class ZtallocState implements State {
  // The positions of the four players; false = west and true = east.
  private int L,R;
  private char ch;
  // The previous state.
  private State previous;

  public ZtallocState(int Lin,int Rin, char c, State p) {
    L=Lin;
    R=Rin;
    ch= c;
    previous = p;
  }

  @Override
  public boolean isFinal(int Lout, int Rout) {
    return (L>=Lout && R<=Rout);
  }

  @Override
  public boolean isBad() {
    return true;
  }

  @Override
  public Collection<State> next(Set<State>seen, int[] episkeptis) {
    Collection<State> states = new ArrayList<>();
    if (R!=0 && episkeptis[R/2]<5) {
    	states.add(new ZtallocState(L/2, R/2 ,'h', this));
    	//seen.add(new ZtallocState(L/2, R/2 ,'h', this));
    	episkeptis[R/2]+=2;
    }
    if (R*3+1<1000000 && R==L && episkeptis[R*3+1]<5) {
    	states.add(new ZtallocState(L*3+1,R*3+1, 't', this));
    	//seen.add(new ZtallocState(L*3+1,R*3+1, 't', this));
    	episkeptis[R*3+1]+=2;
    }
    return states;
  }

  @Override
  public State getPrevious() {
    return previous;
  }

  @Override
  public String toString() {
    StringBuilder sb = new StringBuilder("State: ");
    sb.append("man=");
    sb.append(", wolf=");
    sb.append(", goat=");
    sb.append(", cabbage=");
    return sb.toString();
  }

  // Two states are equal if all four are on the same shore.
  @Override
  public boolean equals(Object o) {
    if (this == o) return true;
    if (o == null || getClass() != o.getClass()) return false;
    ZtallocState other = (ZtallocState) o;
    return R==other.R && L==other.L && ch==other.ch;
  }

  // Hashing: consider only the positions of the four players.
  
  @Override
 public char getChar() {
	 return ch;
 }
  
  @Override
  public int getR() {
	  return R;
  }
  @Override
  public int getL() {
	  return L;
  }
}
