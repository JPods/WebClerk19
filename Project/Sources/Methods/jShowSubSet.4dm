//%attributes = {"publishedWeb":true}
If (Records in set:C195("UserSet")#0)
	USE SET:C118("UserSet")
	$setName:="<>set"+Table name:C256(ptCurTable)
	CLEAR SET:C117($setName)
	CREATE SET:C116(ptCurTable->; $setName)
	MenuTitle
	booSorted:=False:C215
End if 