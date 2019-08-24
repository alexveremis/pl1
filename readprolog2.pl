 /*
 * A predicate that reads the input from File and returns it in
 * the last three arguments: N, K and C.
 * Example:
 *
 * ?- read_input('c1.txt', N, K, C).
 * N = 10,
 * K = 3,
 * C = [1, 3, 1, 3, 1, 3, 3, 2, 2|...].
 */
 
colors(File,Answer) :-
	read_input(File,N,K,C),
	findleast(N,C,K,[],N,Answer,N+1,0,N+1,N+1),
	!.

 
read_input(File, N, K, C) :-
    open(File, read, Stream),
    read_line(Stream, [N, K]),
    read_line(Stream, C).

read_line(Stream, L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).
	
/*
checkifall(N,K,Answer,C,Temp1,SavedK):-
	(	K=:=0 ->iftemp1neq0(Temp1,Answer,SavedK,N,C)
  ; 	member(K,C)->
		NewK is K-1,
		checkifall(N,NewK,Answer,C,Temp1,SavedK)
  ;  	NewTemp1 is 1,
		NewK is K-1,
	checkifall(N,NewK,Answer,C,NewTemp1,SavedK) ).
	
	
iftemp1neq0(Temp1,Answer,K,N,C):-
	(	Temp1=:=0 -> findleast(N,C,K,[],N,Answer,N,0,N+1)
	;	Answer is 0).	
	*/
	
findleast(Start,C,K,Lista,Ending,Answer,N,Count,Temp2,Temp3):-
( N=:=0 -> (Temp2 =:=Temp3 -> Answer is 0 
			;				Answer is Temp2)
;Count<K -> (Start =:= 0 -> NewN is N-1 ,
							findleast(Start,C,K,Lista,Ending,Answer,NewN,Count,Temp2,Temp3),
							!
			; nth1(Start,C,Poios),	
									(member(Poios,Lista),! -> NewStart is Start-1,
															NewN is N-1,
															NewLista=[Poios|Lista],
															findleast(NewStart,C,K,NewLista,Ending,Answer,NewN,Count,Temp2,Temp3),
															!
									;NewCount is Count+1,
									 NewStart is Start-1,
									 NewN is N-1,
									 NewLista=[Poios|Lista],
									 findleast(NewStart,C,K,NewLista,Ending,Answer,NewN,NewCount,Temp2,Temp3),!	))
; nth1(Ending,C,Poios),									 
select(Poios,Lista,NewLista),!,
							( member(Poios,NewLista),!  -> NewEnding is Ending-1,
														findleast(Start,C,K,NewLista,NewEnding,Answer,N,Count,Temp2,Temp3),!
														; (Temp2>(Ending-Start)	->  	NewN is N-1,
																						NTemp2 is Ending-Start,
																						NewCount is Count -1,
																						NewEnding is Ending-1,
																						findleast(Start,C,K,NewLista,NewEnding,Answer,NewN,NewCount,NTemp2,Temp3),!
														;NewN is N-1,
														NewCount is Count -1,
														NewEnding is Ending-1,
														findleast(Start,C,K,NewLista,NewEnding,Answer,NewN,NewCount,Temp2,Temp3),!) 
							)							
).


	subseq([], []).
	subseq([Item | RestX], [Item | RestY]) :-
	subseq(RestX, RestY).
	subseq(X, [_ | RestY]) :-
	subseq(X, RestY).