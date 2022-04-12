//%attributes = {"publishedWeb":true}
C_LONGINT:C283($2; $3; $theNum)
C_BOOLEAN:C305($0)
C_POINTER:C301($1; $4; $ptField)
$ptField:=Field:C253(Table:C252($1); $2)
If ($3=9)  //Longint unique field
	$theNum:=CounterNew($1)
	$4->:=String:C10($theNum)
Else 
	//Case of 
	//: ($1=([Customer]))
	$4->:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Customer:2]))
	//End case 
End if 