 
 (* functor BinaryMapFn (ORD_KEY) : ORD_MAP
  structure IntListMap :> ORD_MAP 
 functor ListMapFn (ORD_KEY) : ORD_MAP  
		val aaaa=IntListMap.empty
		val aaaa= IntListMap.insert(aaaa,1,10)
		val aaaa=  IntListMap.insert(aaaa,2,2)
		val opa =IntListMap.numItems(aaaa) 
		
   fun testaki aaaa = print(Int.toString(opa) ^ "\n")    
   fun ektyposetilista lista = print(String.concatWith ", " (map Int.toString lista));
	
	fun kaneme (k,a) = if k=0 then a
	else 
	(  
		let
		val a = IntListMap.insert(a,0,k)
		in
		kaneme(k-1,a)
		end
		)
	
	fun kanelista2 (n,b,lista) = if n=0 then b
	(  
		let
		val b = IntListMap.insert(b,#n lista,n)
		in
		kaneme(n-1,b)
		end
		)	
 
 fun kanemeupdate (a,stoixeio,lista,proseteos)=
 let 
 val update=Array.update(a,#stoixeio lista,proseteos + Array.sub(a,#stoixeio lista))
 in
 kanemeupdate
 end 
 
 	fun dose (world,n)		= if n=0 then print("telos")
	else  
		let 
			val x= print(Int.toString(Array.sub(world,n-1)) ^ "\n")
			in dose(world,n-1)
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
	val n = readInt inStream
	val k = readInt inStream
	val _ = TextIO.inputLine inStream


        (* A function to read N integers from the open file. *)
	fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
    in
   	(n,k, readInts n [])
    end
	
	local
  (* Attention: fillArray MUST return the modified array,
  * otherwise the version won't work properly. *)
  fun fillArray arr _ [] = arr
    | fillArray arr len (x :: xs) =
        (if x < len then Array.update(arr, x, true) else ();
        fillArray arr len xs)

  fun get_first_gap arr len idx =
        if idx >= len then idx
        else if Array.sub(arr, idx) then get_first_gap arr len (idx + 1)
        else idx
in
  fun smallest3 l =
    let
      val len = length l
      val presentArr = Array.array (len, false)
      val filledArr = fillArray presentArr len l
    in
      get_first_gap filledArr len 1
    end
end	
	
	fun epanalipsiC2 (n,k,lista,diafora,beginning,ending,count,neospinakas) = if (n=0) then (print(Int.toString(diafora-1) ^ "\n"))
		else (
				if (count <k) then (
					if (beginning<0) then epanalipsiC2(n-1,k,lista,diafora,beginning,ending,count,neospinakas) 
					else (
						if (Array.sub(neospinakas,(Array.sub(lista,beginning)))=0)then(
							let 
							val update=Array.update(neospinakas,(Array.sub(lista,beginning)),1 + Array.sub(neospinakas,(Array.sub(lista,beginning))))
							in
							epanalipsiC2(n-1,k,lista,diafora,beginning-1,ending,count+1,neospinakas)
							end)
						else (
							let 
							val update=Array.update(neospinakas,(Array.sub(lista,beginning)),1 + Array.sub(neospinakas,(Array.sub(lista,beginning))))
							in
							epanalipsiC2(n-1,k,lista,diafora,beginning-1,ending,count,neospinakas)
							end)
						 )
				)
					
				else(
					if (Array.sub(neospinakas,(Array.sub(lista,ending)))>1) then(
						let 
						val update=Array.update(neospinakas,(Array.sub(lista,ending)),Array.sub(neospinakas,(Array.sub(lista,ending))) -1)
						in
						epanalipsiC2(n,k,lista,diafora,beginning,ending-1,count,neospinakas)
						end)
					else (
						if ((diafora>ending-beginning +1) orelse (diafora=n+1 )) then (
							let 
							val update=Array.update(neospinakas,(Array.sub(lista,ending)),Array.sub(neospinakas,(Array.sub(lista,ending))) -1)
							in
							epanalipsiC2(n-1,k,lista, ending-beginning+1,beginning,ending-1,count-1,neospinakas)
							end)
						else (
							let 
							val update=Array.update(neospinakas,(Array.sub(lista,ending)),Array.sub(neospinakas,(Array.sub(lista,ending))) -1)
							in
							epanalipsiC2(n-1,k,lista,diafora,beginning,ending-1,count-1,neospinakas)
							end)
					)
				)
			)
			

			
		
	fun epanalipsiC (n,k,lista,neospinakas) =
		if (smallest3 lista <= k) then print("0\n")
		else 
		let 
		val world = Array.fromList(lista)
		in
		 epanalipsiC2 (n,k,world,n+1,n-1,n-1,0,neospinakas) 
		(* dose (world,n) *)
		end
	
	fun solve (n,k, kordela) = 
	let
		val a =Array.array(k+1,0)
		in
		epanalipsiC(n,k,kordela,a)
		end
		
	fun colors fileName = solve (parse fileName) 