ztalloc(File,Answer) :-
	parse(File, N, Teams),
	nth1(1,Teams,C),
	vasikia1(N,C,Teams,1,BasicList),
	reverse(BasicList,B2),
	Answer=B2,
	!.

parse(File, N, Teams) :- phrase_from_file(input(N, Teams), File).
	
vasikia1(N,C,Teams,N+1,BasicList):-!.	
vasikia1(N,C,Teams,AntithetoN,BasicList):-
	nth1(1,C,Lin),
	nth1(2,C,Rin),
	nth1(3,C,Lout),
	nth1(4,C,Rout),
	AllPossible=[Lin ,Rin, ''],
	vasikia2(Lin,Rin,Lout,Rout,[AllPossible],Result,[]),
	
	
	(AntithetoN=:=1 -> NewBasic=[Result]
	;NewBasic=[Result|BasicList]),
	NewAnt is AntithetoN +1,
	nth1(NewAnt,Teams,NeoC),
	vasikia1(N,NeoC,Teams,NewAnt,NewBasic).

/* 
ch=""	
AllPossible=[Lin Rin ch]
R<=Rout
L>=Lout
Episkeptis is []
L=:=R
Episkeptis =[R|Episkeptis]
member(R,Episkeptis) 
*/

vasikia2(L,R,Lout,Rout,AllPossible2,Result,Episkeptis):-
	(length(AllPossible2)>0 ->nth1(1,AllPossible2,A1),nth1(1,A1,L),nth1(2,A1,R),nth1(3,A1,Ch),delete(AllPossible2,A1,NewAll2),
	(\+isFinal(L,R,Lout,Rout) -> (R>L->(R>0 ->string_concat(Ch,'h',NewCH)NewNewAll=[L/2, R/2,NewCH|AllPossible],NewEpiskeptis=[R/2|Episkeptis],
										(R*3+1<1000000 ->string_concat(Ch,'t',NewCh1) ,NewAll=[L*3+1, R*3+1,NewCh1|],NewEpiskeptis=[R*3+1|Episkeptis]))
								;\+member(R/2,Episkeptis)->string_concat(Ch,'h',NewCH2),NewAll=[L/2, R/2,NewCH2|AllPossible2],NewEpiskeptis=[R/2|Episkeptis],vasikia2(L,R,Lout,Rout,NewAll,Result,NewEpiskeptis),
								(\+member(R*3+1,Episkeptis)->string_concat(Ch,'t',NewCH3),NewAll=[L*3+1, R*3+1,NewCH3|AllPossible2],NewEpiskeptis=[R*3+1|Episkeptis],vasikia2(L,R,Lout,Rout,NewAll,Result,NewEpiskeptis)))
	;Ch==''-> Result='EMPTY'
	;Result=Ch)
	;Result='IMPOSSIBLE' ).
	
	
	
isFinal(L,R,Lout,Rout):-
		L>=Lout,
		R<=Rout.

:- use_module(library(dcg/basics)).

input(N, Teams) --> integer(N), blanks, teams(Teams).
teams([Team|Teams]) --> team(Team), blank, teams(Teams).
teams([]) --> [].

team([X|Xs]) --> integer(X), whites, team(Xs).
team([]) --> [].


/* https://stackoverflow.com/questions/51206614/read-a-file-and-save-to-a-list 
kwdikas gia diavasma apo edw*/