//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Txt_Quote  
	//Date: 07/07/02
	//Who: Bill
	//Description: changed to a single file output  
	VERSION_960
End if 

C_TEXT:C284($0; $1)

$0:="\""+$1+"\""
// $0:=Char(34)+$1+Char(34)
// $0:=Quote+$1+Quote

If (False:C215)
	C_LONGINT:C283($return)
	// $return:=Character code(wcQuote)
	$return:=Character code:C91("\"")
	// These return the numeric values
	//$return:=Character code(Carriage return)
	//$return:=Character code(Line feed)
	//$return:=Character(Carriage return)
	//$return:=Character code(Tab)
	//$return:=Character code(Quote)
	//$return:=Character code(semicolon)
	
End if 