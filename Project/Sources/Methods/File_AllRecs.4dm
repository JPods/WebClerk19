//%attributes = {"publishedWeb":true}


C_LONGINT:C283(bAll; $w)
ALL RECORDS:C47(Table:C252(curTableNum)->)
viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
If (<>prcControl=5)
	$setName:="<>set"+Table name:C256(curTableNum)
	CLEAR SET:C117($setName)
	CREATE SET:C116(Table:C252(curTableNum)->; $setName)
	UNLOAD RECORD:C212(Table:C252(curTableNum)->)
End if 
viRecordsInTable:=Records in table:C83(Table:C252(curTableNum)->)
