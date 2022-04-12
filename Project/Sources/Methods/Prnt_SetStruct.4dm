//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2)
C_BOOLEAN:C305($doItems)
$doItems:=False:C215
//Procedure: Prnt_SetStruct
ARRAY TEXT:C222(aStructure; 0)
If ($2>0)
	vi1:=1
	Prnt_FillFldRay(1; $2)
End if 

C_LONGINT:C283($err)
$err:=SR Structure($1; "aStructure")