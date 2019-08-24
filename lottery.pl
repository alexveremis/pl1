lottery(File,Answer) :-
	parse(File, B, N1, N2, Teams),
	valepaigmena(Pai,Teams,N1,Paigmena,Teams2),
	basikia2(N1,Teams2,Paigmena,N1,[],Pollaplasio10,B,[],Lista,ListA,0),
	reverse(ListA,ListB),
	Answer=ListB,
	!.
	
	
valepaigmena(Pai,Teams,0,Paigmena,Teams2):-
	Paigmena=Pai,
	Teams2=Teams.
valepaigmena(Pai,[A|Tail],N1,Paigmena,Teams2):-
	NewPaigmena=[A|Pai],
	NewN1 is N1-1,
	valepaigmena(NewPaigmena,Tail,NewN1,Paigmena,Teams2).

	
basikia2(N1,[],Paigmena,Boi8N1,Count,Pollaplasio10,B,Poso,Lista,ListA,Kappa):-
	ListA=Lista,
	!.
basikia2(0,[A|Tail],Paigmena,Boi8N1,Count,Pollaplasio10,B,Poso,Lista,ListA,0):- 
	sum_list(Count,CountA),
	sum_list(Poso,PosoA),
	Voi8=[CountA, PosoA],
	NewLista=[Voi8],
	basikia2(Boi8N1,Tail,Paigmena,Boi8N1,[],Pollaplasio10,B,[],NewLista,ListA,1).	
basikia2(0,[A|Tail],Paigmena,Boi8N1,Count,Pollaplasio10,B,Poso,Lista,ListA,Kappa):- 
	sum_list(Count,CountA),
	sum_list(Poso,PosoA),
	Voi8=[CountA, PosoA],
	NewLista=[Voi8|Lista],
	basikia2(Boi8N1,Tail,Paigmena,Boi8N1,[],Pollaplasio10,B,[],NewLista,ListA,Kappa).
basikia2(N1,[A|Tail],Paigmena,Boi8N1,Count,Pollaplasio10,B,Poso,Lista,ListA,Kappa):-
	nth1(N1,Paigmena,Laxnos),
	basikia3(Voi8Count,Voi8Poso,0,B,Laxnos,A,10,2,Count,Poso),
	NewC=[Voi8Count|Count],
	NewP=[Voi8Poso|Poso],
	New1 is N1-1,
	basikia2(New1,[A|Tail],Paigmena,Boi8N1,NewC,Pollaplasio10,B,NewP,Lista,ListA,Kappa).
																			
	
	
basikia3(Voi8Count,Voi8Poso,B2,B,Laxnos,A,Pollaplasio10,Poll2,Count,Poso):-
(B2=:=0 -> ((Laxnos mod Pollaplasio10)=:=(A mod Pollaplasio10 )->Voi8Count is 1,Ole is Laxnos mod(Pollaplasio10*10),Ole2 is A mod (Pollaplasio10*10),
														(Ole\=Ole2->Voi8Poso is Poll2-1
														;NewPoll2 is Poll2*2,
														NewB2 is B2+1,
														NewP10 is Pollaplasio10*10,
														basikia3(NCount,Voi8Poso,NewB2,B,Laxnos,A,NewP10,NewPoll2,Count,Poso) )
			;Voi8Count is 0,Voi8Poso is 0,!	)														
;B2>(B-1) ->!
;((Laxnos mod Pollaplasio10)=:=(A mod Pollaplasio10) ->(Ole is Laxnos mod(Pollaplasio10*10),Ole2 is A mod (Pollaplasio10*10),
														Ole\=Ole2->Voi8Poso is Poll2-1
											;B2=:=B-1 -> Voi8Poso is Poll2-1
											;NewPoll2 is Poll2*2,
											NewB2 is B2+1,
											NewP10 is Pollaplasio10*10,
											basikia3(Voi8Count,Voi8Poso,NewB2,B,Laxnos,A,NewP10,NewPoll2,Count,Poso)))
;Voi8Count is 0,Voi8Poso is 0,!).
	

parse(File, B, N1, N2, Teams) :- phrase_from_file(input(B,N1,N2, Teams), File).

:- use_module(library(dcg/basics)).

input(B,N1,N2, Teams) --> integer(B),white,integer(N1),white,integer(N2),blanks, teams(Teams).
teams([Team|Teams]) --> team(Team), blanks, teams(Teams).
teams([]) --> [].

team(X) --> integer(X).

