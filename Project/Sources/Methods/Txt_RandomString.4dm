//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Txt_RandomString 
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if   //

C_LONGINT:C283($1; $theCount; $i)
C_TEXT:C284($0; $output)
C_TEXT:C284($2; $3)
C_LONGINT:C283($startStringNum; $endStringNum)
C_LONGINT:C283($randStart; $randLen)
C_TEXT:C284($strDT)
$strDT:=""

Case of 
	: (Count parameters:C259=1)
		$theCount:=$1
		$startStringNum:=Character code:C91("A")
		$endStringNum:=Character code:C91("z")
	: (Count parameters:C259=3)
		$theCount:=$1
		$startStringNum:=Character code:C91($2)
		$endStringNum:=Character code:C91($3)
	Else 
		$theCount:=5
		$startStringNum:=60  //Ascii("<")//60  the ; (Ascii 59) must not be included for cookies
		$endStringNum:=Character code:C91("z")  //122
		$strDT:=String:C10(DateTime_Enter; "###000000000")
End case 
//
For ($i; 1; $theCount)
	If (($endStringNum-$startStringNum+1)+$startStringNum#0)
		$output:=$output+Char:C90(Random:C100%($endStringNum-$startStringNum+1)+$startStringNum)
	End if 
End for 
$output:=$strDT+"__"+$output
//TRACE
$0:=$output