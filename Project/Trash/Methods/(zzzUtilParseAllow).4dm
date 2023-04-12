//%attributes = {"publishedWeb":true}
//QUERY([Item]; [Item]; itemNum="@-Copperfield")
//vi2:=Records in selection([Item])
//FIRST RECORD([Item])
//for(vi1;1;vi2)
//vi2:=Records in selection([Item])
//vi2:=Records in selection([Item])

var countDups; count2Dups : Integer
var selection_o; record_o : Object
selection_o:=ds:C1482.Item.query("itemNum = :1"; "@-Copperfield")
For each (record_o; selection_o)
	record_o.itemNum:=Replace string:C233(record_o.itemNum; "-Copperfield"; "-CCS")
	$result:=record_o.save()
	If (Not:C34($result.success))
		countDups:=countDups+1
		record_o.itemNum:=Replace string:C233(record_o.itemNum; "-Copperfield"; "-CCS_d")
		$result:=record_o.save()
		If (Not:C34($result.success))
			count2Dups:=count2Dups+1
			
		End if 
	End if 
End for each 