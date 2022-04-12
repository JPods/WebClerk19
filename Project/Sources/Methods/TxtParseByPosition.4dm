//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TxtParseByPosition
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($0; $1; $2)
C_LONGINT:C283($3; $4; $lenMatch; $clipFromEnd; $clipLength)
//
$0:=""
$p:=Position:C15($1; $2)
If ($p>0)
	$lenMatch:=Length:C16($2)
	$clipFromEnd:=$3
	$clipLength:=$4
	If ($clipFromEnd=1)
		iloText1:=Substring:C12($1; $p+$clipFromEnd; $clipLength)
	Else 
		iloText1:=Substring:C12($1; $p; $clipLength)
	End if 
	iloText1:=Parse_UnWanted(iloText1)
	$0:=iloText1
End if 