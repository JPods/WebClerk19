//%attributes = {}

If (False:C215)
	ALL RECORDS:C47([Document:100])
	REDUCE SELECTION:C351([Document:100]; 7)
	For (vi1; 1; 7)
		[Document:100]idForeign:32:="ADFAA0E2897943EF90DCB7CAA40EB86B"
		SAVE RECORD:C53([Document:100])
		NEXT RECORD:C51([Document:100])
	End for 
	
	var $o; $o2; $r : Object
	$o:=ds:C1482.Document.all()
	$o2:=$o.slice(0; 7)
	For each ($r; $o2)
		$r.idForeign:="ADFAA0E2897943EF90DCB7CAA40EB86B"
		$r.save()
	End for each 
	
End if 