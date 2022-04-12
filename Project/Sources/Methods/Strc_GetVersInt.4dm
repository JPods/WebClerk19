//%attributes = {"publishedWeb":true}
//Procedure: Strc_GetVersInt
C_LONGINT:C283($0)  //version number integer
C_TEXT:C284($1)  //version number string
If (Length:C16($1)>=5)
	$0:=Num:C11(Substring:C12($1; 1; 1)+Substring:C12($1; 3; 1)+Substring:C12($1; 5; 1))
Else 
	$0:=Num:C11(Substring:C12($1; 1; 1)+Substring:C12($1; 3; 1)+"0")
End if 