//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Http_DeBugCall 
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 


C_TEXT:C284($1; $theMessage; webLog)
C_LONGINT:C283($2; $callAction; $3; $endTry; $cntTry)
webLog:=webLog+"<message>"+$theMessage+"</message>"


