//%attributes = {"publishedWeb":true}
//Method: EMail_Out
C_TEXT:C284($0; $1; $eText)
C_LONGINT:C283($2; $testEmail)
$testEmail:=0
Case of 
	: (Count parameters:C259=0)
		$eText:=[QQQRemoteUser:57]email:14
	: (Count parameters:C259=2)
		$eText:=$1
		$testEmail:=$2
	Else 
		$eText:=$1
End case 

If ($testEmail=1)
	Case of 
		: (Position:C15(Char:C90(64); $eText)>2)
			//$eText  is OK
		: (Position:C15("&~"; $eText)>2)
			//$eText  is OK
		Else 
			$eText:=""
	End case 
End if 
$0:=Replace string:C233($eText; "&~"; "@")


If (False:C215)
	
	//Script Customers Bad Email
	QUERY:C277([QQQCustomer:2]; [QQQCustomer:2]email:81#""; *)
	QUERY:C277([QQQCustomer:2])
	QUERY SELECTION BY FORMULA:C207([QQQCustomer:2]; Preg Match("^(?!.*\\.\\..*)(?!.*@.*@.*)[\\w!#$%&'*+-/=?^_//{|}~]+@.+\\..{2,5}$"; [QQQCustomer:2]email:81)=0)
	
End if 