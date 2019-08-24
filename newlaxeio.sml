(* signature DICT =
sig
  type key = int                 (* concrete type *)
  type 'a entry = key * 'a          (* concrete type *)

  type 'a dict                      (* abstract type *)

  val dimiourgia : 'a dict
  val insert : 'a dict * 'a entry -> 'a dict
  val posaYpodentra :'a dict -> key -> int
end;  (* signature DICT *)

structure Trie :> DICT = 
struct
  type key = string
  type 'a entry = key * 'a

  datatype int trie = 
    Empty
  | Node of int*trie*trie*trie*trie*trie*trie*trie*trie*trie*trie
  

  type 'a dict = 'a trie
  val dimiourgia = Node(10,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty,Empty)
  
  fun posaYpodentra (trie ,key)= if SOME (Root(trie,key)) >0  then return SOME (Root(trie,key)) +1+ posaYpodentra(Node(trie,key))
  else return 0
  
  (*
    val insert: 'a dict * 'a entry -> 'a dict
  *)
  fun insert (trie, (rev key, bits, flag)) = if bits=0 then trie
  else if flag =1 then
	let 
	val a= key mod 10
	in 
	if a doesnt exist then 
		val trie =trie::Node(a)
		in insert(trie,(key/10,bits-1,0)
		end
	else 	
	end
	
  else
	  let	
		val a =key mod 10
		val trie =insertChild(trie,a,,bits)
		in insert(trie,(key/10,bits-1,0)
		end
end
*)
fun parse file =
    let
	(* A function to read an integer from specified input. *)
        fun readInt input = 
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

	(* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read an integer (number of countries) and consume newline. *)
	val psifia = readInt inStream
	val paixtikan = readInt inStream
	val kerdizoun = readInt inStream
	val _ = TextIO.inputLine inStream


        (* A function to read N integers from the open file. *)
	fun readInts 0 acc  = acc (* Replace with 'rev acc' for proper order. *)
	  | readInts i acc  = readInts (i - 1)  (readInt inStream :: acc)
	  
	fun readInts2 0 acc = rev acc
		|readInts2 i acc = readInts2 (i - 1)  (readInt inStream :: acc)

    in
   	(psifia,paixtikan,kerdizoun, readInts paixtikan [],readInts2 kerdizoun [] )
    end
(*	
	fun ypologismosposou (A,listResults,edompikan,kati) = 
		if A=2 then 
		let 
			val listResults=(hd edompikan)::listResults
			val kati2 = ( (A-1) * (hd edompikan) + kati) mod (1000000000 +7) 
				in 
				ypologismosposou(2*A,listResults,tl edompikan,kati2)
				end
		else if null edompikan then 
		let 	
			val listResults=(kati)::listResults
			in 
			listResults
			end
		else 
			let 	
				val kati2 = ( (A-1) * (hd edompikan) + kati) mod (1000000000 +7) 
				in 
				ypologismosposou(2*A,listResults,tl edompikan,kati2)
				end
	
	
	fun kantogiatosabits(B,trie,key,listoula,pollaplasio10)=if B=0 then return listoula
	else 
		let val listoula=(Trie.posaYpodentra(trie,(rev String.fromInt(key mod pollaplasio10))))::listoula
		in 
		kantogiatosabits(B-1,trie,key,listoula,pollaplasio10*10)
		end
	
	
	
	fun posakerdous(B,P,K,trie1,nikitiria,listResults,i) = if K=0 then ektipose_apotelesmata(rev listResults,i-1)
	else 
		let 
			(* val poso= Trie.posaYpodentra(trie1, Int.toString(hd nikitiria)) (* den xreiazetai*)
			
			val listResults =ypologismosposou(2,listResults,poso,0) 
			val poso2 =exp 2 M *posatetoia (kanto gia ka8e M)
			8elei episis for 1 mexri B /10 stin apo8ikeysi alla kai sto tsekarisma
			val poso3 =poso2 mod (1000000000 +7) 
			val listResults=(poso2)::listResults   *)
			val listResults= ypologismosposou(2,listResults,kantogiatosabits(B,trie1,Int.toString(hd nikitiria),[]),0,10)
			in posakerdous(B,P,K-1,trie1,tl nikitiria,listResults,i)
		end
	
	
	fun gemiseToMastora(B,P,K,paigmena,nikitiria,trie1,i)=if P=0 then posakerdous(B,i-1,K,trie1,nikitiria,[],1)
	else 
		let 
			val a2=Trie.insert(trie1,  ((hd paigmena), B))
			in gemiseToMastora(B,P-1,K,tl paigmena,nikitiria,trie1,i+1)
		end	
	*)
	fun tsekarisma(Play,Win,Count,Poso,P10,P2,B,B2)=
	if (B2=0) then(
	if (Play mod P10 = Win mod P10) then
		let 
			val NewC=Count+1
			(* val b=print("oleee11"^Int.toString(Count) ^" "^ Int.toString(Poso)^ "\n") *)
			in
			if ((Play mod (10*P10)) <> (Win mod (P10*10))) then 
			let 
				val NewPoso=Poso +P2-1
			in (NewC,NewPoso) 
			end
			else tsekarisma(Play,Win,NewC,Poso,P10*10,P2*2,B,1) end
	else (Count,Poso)
				) 
		else if (Play mod (10*P10) <> Win mod (P10*10) orelse B2=B-1 ) then 
			let 
				val NewPoso=Poso +P2-1
			in (Count,NewPoso)
			end
		else tsekarisma(Play,Win,Count,Poso,P10*10,P2*2,B,B2+1)
		
	
	(*fun gemiseToMastora(B,P,K played,nil,N2,Count,Poso)=B *)
	fun gemiseToMastora(B,P,K,played,winning,N2,Count,Poso)=
	if (length winning>0)then (
	if (N2=P) then 
		let 
		val a=print(Int.toString(Count) ^" "^ Int.toString(Poso)^ "\n")
					in gemiseToMastora(B,P,K,played,tl winning,0,0,0) 
		end
	else	let 
			val Play=Array.sub(played,N2)
			val Win=hd winning
			val (Count,Poso)=tsekarisma(Play,Win,Count,Poso,10,2,B,0)
			in
			gemiseToMastora(B,P,K,played,winning,N2+1,Count,Poso)
			end
			)
	else ()
		
		
		
		
	fun solve (B,P,K,paigmena,nikitiria) = 
	let
		(* val a =print(Int.toString(hd paigmena)^"," ^ String.concatWith "," (map Int.toString (tl paigmena))^ "\n" ^ Int.toString(List.nth(paigmena,4))) *)
		val played=Array.fromList(paigmena) 
		(* den yparxei logos gia array gt etsi k allios ta bit 8a ta paroyme apo diairesi me to 10 koitas ta part of signature ayta xrisimpoieis *)
		(*val trie1 =Trie.dimiourgia  *)
		(* val a2=Trie.insert(b,  ("abadasa",1))
		val a3 =print(Trie.toString(Char.toString b))  *)
		in 
		 gemiseToMastora(B,P,K,played,nikitiria,0,0,0) 
		end
		
	fun lottery fileName = solve (parse fileName)
	
	(* ara diavazontai swsta *)