fun olosopinakas(map2,grammes,stiles,i,j)=
if (i=grammes andalso j=stiles) then print("\n")
else if (j=stiles)then 
let 
	val  x=print(Int.toString (Array2.sub(map2,i,j))^ "\n")
	in olosopinakas(map2,grammes,stiles,i+1,0)
	end
else 
let 
	val  x=print(Int.toString (Array2.sub(map2,i,j))^ "     ")
	in olosopinakas(map2,grammes,stiles,i,j+1)
	end



(*διάβασμα απο αρχείο και δημιουργία λίστας από λίστες*)
fun parse file =
let
  val ins = TextIO.openIn file
  fun loop ins =
  case TextIO.inputLine ins of
      SOME line => explode(line) :: loop ins
    | NONE      => []
in
  loop ins before TextIO.closeIn ins
end

(*διαγραφή στοιχείου από λίστα*)
fun delete (item, list) =
  case list of
      []=>[]
    | xs::ys => if item = xs then delete(item,ys)
          else xs::delete(item,ys)

(*καθαρισμος λίστας απο Newlines*)          
fun clear (x ,l, acc) =
  if null l then acc
  else delete(x, hd l)::clear (x, tl l, acc)
  
  fun moveprint(kiniseis)=print(Char.toString(hd kiniseis) ^ String.concatWith "" (map Char.toString (tl kiniseis))^ "\n")   

  
  
  
  fun decodemoves(twincat:(int*int*int*char) list,koutaki,kiniseis)=
  if(koutaki= ~1)then print("stay\n")
  else if(koutaki= 1)then moveprint(kiniseis)
  else (
  let 
	val theHead= List.nth(twincat,koutaki-1)
	val b= #3 theHead
	val tempo= #4 theHead
	val kiniseis=[tempo]@kiniseis
	in 
	decodemoves(twincat,b,kiniseis)
	end
  )
  
  fun notinfinity(best_time,cat:(int*int*int*char) list,map2,grammes,stiles,twincat:(int*int*int*char) list,time,fora,nthofcatlist,koutaki,mesa1,insatsametime,b,best_i,best_j)=
  if (null cat)then (* olosopinakas(map2,grammes,stiles,0,0) *) 
  let 
	val y=print (Int.toString(best_time)^"\n") 
	in decodemoves(rev twincat,koutaki,[]) 
	end
  else(
   let 
	val theHead= hd cat
	val giota= #1 theHead
	val jey= #2 theHead
  in
  if (giota+1<=grammes andalso (Array2.sub(map2,giota+1,jey) >time)) then
			let
			val cat=cat@[(giota+1,jey,nthofcatlist,#"D")]
			val twincat=(giota+1,jey,b,#"D")::twincat
			in	
				if (best_time<Array2.sub(map2,giota+1,jey)) then
			let	
				val best_time= Array2.sub(map2,giota+1,jey)-1
				val koutaki=nthofcatlist+1
				val update=Array2.update(map2, giota+1, jey, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,true,insatsametime,b,giota+1,jey)
				end
				else(
				let
					val update=Array2.update(map2, giota+1, jey, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,mesa1,insatsametime,b,best_i,best_j)
				end)
			end
            
	else if(jey-1>=0 andalso (Array2.sub(map2,giota,jey-1) > time)) then
			let
			val cat=cat@[(giota,jey-1,nthofcatlist,#"L")]
			val twincat=(giota,jey-1,b,#"L")::twincat
			in	
				if(best_time<Array2.sub(map2,giota,jey-1) andalso (mesa1=false orelse best_time+1<Array2.sub(map2,giota,jey-1) orelse( giota <= best_i andalso jey-1 <best_j)))then
            let
				val koutaki=nthofcatlist+1
				val best_time=Array2.sub(map2,giota,jey-1) -1
				val update=Array2.update(map2, giota, jey-1, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,true,insatsametime,b,giota,jey-1)
				end
				else (
				let
					val update=Array2.update(map2, giota, jey-1, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,mesa1,insatsametime,b,best_i,best_j)
				end)
			end
	else if (jey+1<=stiles andalso (Array2.sub(map2,giota,jey+1)> time ))then
			let
			val cat=cat@[(giota,jey+1,nthofcatlist,#"R")]
			val twincat=(giota,jey+1,b,#"R")::twincat
			in	
				if(best_time<Array2.sub(map2,giota,jey+1) andalso (mesa1=false orelse best_time+1<Array2.sub(map2,giota,jey+1) ))then
            let
				val koutaki=nthofcatlist+1
				val best_time=Array2.sub(map2,giota,jey+1) -1
				val update=Array2.update(map2, giota, jey+1, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,true,insatsametime,b,giota,jey+1)
				end
				else (
				let
					val update=Array2.update(map2, giota, jey+1, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,mesa1,insatsametime,b,best_i,best_j)
				end)
			end	
	else if(giota-1>=0 andalso (Array2.sub(map2,giota-1,jey) > time )) then
			let
			val cat=cat@[(giota-1,jey,nthofcatlist,#"U")]
			val twincat=(giota-1,jey,b,#"U")::twincat
			in	
				if(best_time<Array2.sub(map2,giota-1,jey) andalso (mesa1=false orelse best_time+1<Array2.sub(map2,giota-1,jey) orelse giota-1 <best_i ) )then
            let
				val koutaki=nthofcatlist+1
				val best_time=Array2.sub(map2,giota-1,jey) -1
				val update=Array2.update(map2, giota-1, jey, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,mesa1,insatsametime,b,giota-1,jey)
				end
				else (
				let
					val update=Array2.update(map2, giota-1, jey, ~5)
				in
				notinfinity(best_time,cat,map2,grammes,stiles,twincat,time,fora+1,nthofcatlist+1,koutaki,mesa1,insatsametime,b,best_i,best_j)
				end)
			end
	else 
	if (insatsametime=1)then notinfinity(best_time,tl cat,map2,grammes,stiles,twincat,time+1,1,nthofcatlist,koutaki,false,List.length cat -1,b+1,best_i,best_j)
	else notinfinity (best_time,tl cat,map2,grammes,stiles,twincat,time,1,nthofcatlist,koutaki,mesa1,insatsametime-1,b+1,best_i,best_j)
	end
  
  )
  
  
  
  fun ifinfinity(best_i,best_j,cat:(int*int*int*char) list,map2,grammes,stiles,fora,nthofcatlist,twincat:(int*int*int*char) list,stay,koutaki,b)=
  if (null cat)then decodemoves(rev twincat,koutaki,[])
  (* olosopinakas(map2,grammes,stiles,0,0) *)
  else(
  let 
	val theHead= hd cat
	val giota= #1 theHead
	val jey= #2 theHead
  in
  if (giota+1<=grammes andalso ( Array2.sub(map2,giota+1,jey)= ~1 orelse Array2.sub(map2,giota+1,jey)= ~3)) then
			let
			val update=Array2.update(map2, giota+1, jey, ~5)
			val cat=cat@[(giota+1,jey,nthofcatlist,#"D")]
			val twincat=(giota+1,jey,b,#"D")::twincat
			in	ifinfinity(best_i,best_j,cat,map2,grammes,stiles,fora+1,nthofcatlist+1,twincat,stay,koutaki,b)
			end
	else if(jey-1>=0 andalso (Array2.sub(map2,giota,jey-1)= ~1 )) then
			let
			val update=Array2.update(map2, giota, jey-1, ~5)
			val cat=cat@[(giota,jey-1,nthofcatlist,#"L")]
			val twincat=(giota,jey-1,b,#"L")::twincat
			in	
				if(giota <= best_i andalso jey-1 <=best_j)then
					ifinfinity(giota,jey-1,cat,map2,grammes,stiles,fora+1,nthofcatlist+1,twincat,0,nthofcatlist+1,b)
				else(ifinfinity(best_i,best_j,cat,map2,grammes,stiles,fora+1,nthofcatlist+1,twincat,stay,koutaki,b))
			end
	else if (jey+1<=stiles andalso (Array2.sub(map2,giota,jey+1)= ~1 ))then
			let
			val update=Array2.update(map2, giota, jey+1, ~5)
			val cat=cat@[(giota,jey+1,nthofcatlist,#"R")]
			val twincat=(giota,jey+1,b,#"R")::twincat
			in	ifinfinity(best_i,best_j,cat,map2,grammes,stiles,fora+1,nthofcatlist+1,twincat,stay,koutaki,b)
			end		
	else if(giota-1>=0 andalso (Array2.sub(map2,giota-1,jey)= ~1 )) then
			let
			val update=Array2.update(map2, giota-1, jey, ~5)
			val cat=cat@[(giota-1,jey,nthofcatlist,#"U")]
			val twincat=(giota-1,jey,b,#"U")::twincat
			in	
				if(giota-1 <= best_i )then
					ifinfinity(giota-1,jey,cat,map2,grammes,stiles,fora+1,nthofcatlist+1,twincat,0,nthofcatlist+1,b)
				else(ifinfinity(best_i,best_j,cat,map2,grammes,stiles,fora+1,nthofcatlist+1,twincat,stay,koutaki,b))
			end	
	else 	ifinfinity(best_i,best_j,tl cat,map2,grammes,stiles,1,nthofcatlist,twincat,stay,koutaki,b+1)
	end
  
  
  )
  
  
 fun checkinf(cat:(int*int*int*char) list,map2,grammes,stiles) = 
 let 
	val theHead= hd cat
	val giota= #1 theHead
	val jey= #2 theHead
	in 
		if (Array2.sub(map2,giota,jey) < 0 )then
		let
			val x =print("infinity\n")
			val update=Array2.update(map2,giota,jey,0)
			in ifinfinity(giota,jey,cat,map2,grammes,stiles,1,1,cat,1, ~1,1)
			end
		else(
		let	
			val best_time=Array2.sub(map2,giota,jey)-1
			(*simeio pou 8elei prosoxi*)
			val update=Array2.update(map2, giota, jey, 0) 
			in notinfinity(best_time,cat,map2,grammes,stiles,cat,0,1,1, ~1,false,1,1,giota,jey)
			end
		)
	end
 
 
 
 (*gemisma map2 me floodtime, mexri edw swsto*)
 fun flooding2(map2,water:(int*int*int) list,grammes,stiles,cat:(int*int*int*char) list,water2) = 
 (* print(Int.toString(hd water)^", "^String.concatWith ", " (map Int.toString (tl water)))   *)
 if (null water) then checkinf(cat,map2,grammes,stiles)
 else(
 let 
	
	val theHead= hd water
	val giota= #1 theHead
	val jey= #2 theHead
	val theTime= #3 theHead
	in
	if (giota+1<=grammes andalso ( Array2.sub(map2,giota+1,jey)= ~1 orelse Array2.sub(map2,giota+1,jey)= ~3)) then
			let
			val update=Array2.update(map2, giota+1, jey, theTime+1)
			val water2=(giota+1,jey,theTime+1)::water2
			in	flooding2(map2,water,grammes,stiles,cat,water2)
			end
	else if (jey+1<=stiles andalso (Array2.sub(map2,giota,jey+1)= ~1 orelse Array2.sub(map2,giota,jey+1)= ~3))then
			let
			val update=Array2.update(map2, giota, jey+1, theTime+1)
			val water2=(giota,jey+1,theTime+1)::water2
			in  flooding2(map2,water,grammes,stiles,cat,water2)
			end
	else if(jey-1>=0 andalso (Array2.sub(map2,giota,jey-1)= ~1 orelse Array2.sub(map2,giota,jey-1)= ~3)) then
			let
			val update=Array2.update(map2, giota, jey-1, theTime+1)
			val water2=(giota,jey-1,theTime+1)::water2
			in  flooding2(map2,water,grammes,stiles,cat,water2)
			end
	else if(giota-1>=0 andalso (Array2.sub(map2,giota-1,jey)= ~1 orelse Array2.sub(map2,giota-1,jey)= ~3)) then
			let
			val update=Array2.update(map2, giota-1, jey, theTime+1)
			val water2=(giota-1,jey,theTime+1)::water2
			in flooding2(map2,water,grammes,stiles,cat,water2)
			end
	else if (null (tl water)) then flooding2(map2,water2,grammes,stiles,cat,[])
	else	flooding2(map2,tl water,grammes,stiles,cat,water2)
	end
			)
	
 
  
  
  (*genisma map2 me ~1 ~2 ... *)
  
fun  flooding(map1,rows,collumns,em,map2,emgrammes,water,cat)=
if(Char.toString(Array2.sub(map1,rows,collumns))="A") then
	let 
	val update=Array2.update(map2, rows, collumns, ~3)
	val cat=(rows,collumns, ~2,#"K")::cat
	in	if (rows=0 andalso collumns=0) then (flooding2(map2,water,emgrammes-1,em-1,cat,[]))
		else if(collumns=0) then
			flooding(map1,rows-1,em-1,em,map2,emgrammes,water,cat)
		else 
			flooding(map1,rows,collumns-1,em,map2,emgrammes,water,cat)	
	end
else if (Char.toString(Array2.sub(map1,rows,collumns))="X") then	
	let 
	val update=Array2.update(map2, rows, collumns, ~2)
	in	if (rows=0 andalso collumns=0) then (flooding2(map2,water,emgrammes-1,em-1,cat,[]))
		else if(collumns=0) then
			flooding(map1,rows-1,em-1,em,map2,emgrammes,water,cat)
		else 
			flooding(map1,rows,collumns-1,em,map2,emgrammes,water,cat)	
	end
else if (Char.toString(Array2.sub(map1,rows,collumns))="W") then	
	let 
	val update=Array2.update(map2, rows, collumns, 0)
	val water= (rows,collumns,0)::water
	in	if (rows=0 andalso collumns=0) then (flooding2(map2,water,emgrammes-1,em-1,cat,[]))
		else if(collumns=0) then
			flooding(map1,rows-1,em-1,em,map2,emgrammes,water,cat)
		else 
			flooding(map1,rows,collumns-1,em,map2,emgrammes,water,cat)	
	end
else 
	let
	val update=Array2.update(map2, rows, collumns, ~1)
	(*val x=print(Int.toString(Array2.sub(map2,rows,collumns)) ^ " ")*)
	in	if (rows=0 andalso collumns=0) then (flooding2(map2,water,emgrammes-1,em-1,cat,[]))
		else if(collumns=0) then
			flooding(map1,rows-1,em-1,em,map2,emgrammes,water,cat)
		else 
			flooding(map1,rows,collumns-1,em,map2,emgrammes,water,cat)	
	end


fun savethecat file = 
let
  val lista = parse file
  (*val finlist = clear (#"\n", lista, []) *)
  val map1 = Array2.fromList(lista)
  val collumns = Array2.nCols(map1)
  val rows = Array2.nRows(map1)
  val map2 = Array2.array(rows+1,collumns+1,0)
in
  flooding (map1, rows-1, collumns-2, collumns-1,map2,rows,[],[]) 
  end