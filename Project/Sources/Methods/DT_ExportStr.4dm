//%attributes = {"publishedWeb":true}
//Procedure: DT_ExportStr
//Saturday, June 12, 1999
C_TEXT:C284($0)
C_POINTER:C301($1)
If (Field name:C257($1)="DT@")
	DateTime_DTFrom($1->; ->vDate1; ->vTime1)
	$0:=String:C10(vDate1; 1)+" "+String:C10(vTime1; 1)
Else 
	$0:=String:C10($1->)
End if 