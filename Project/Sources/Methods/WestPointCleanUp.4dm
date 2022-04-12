//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WestPointCleanUp
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
//ALL RECORDS([Customer])
C_LONGINT:C283($i; $k; $p; $p2; $charNum)
$k:=Records in selection:C76([QQQCustomer:2])
TRACE:C157
FIRST RECORD:C50([QQQCustomer:2])
For ($i; 1; $k)
	MESSAGE:C88(String:C10($i))
	[QQQCustomer:2]comment:15:=[QQQCustomer:2]company:2
	[QQQCustomer:2]company:2:=""
	If ([QQQCustomer:2]company:2="")
		$p:=Position:C15(","; [QQQCustomer:2]comment:15)
		[QQQCustomer:2]company:2:=[QQQCustomer:2]comment:15
		[QQQCustomer:2]nameLast:23:=Substring:C12([QQQCustomer:2]comment:15; 1; $p-1)
		$working:=Substring:C12([QQQCustomer:2]comment:15; $p+2)
		$charNum:=40
		$theChar:=Char:C90($charNum)
		$p:=Position:C15(Char:C90(40); $working)
		If ($p>0)
			[QQQCustomer:2]nameFirst:73:=Substring:C12($working; 1; $p-2)
			[QQQCustomer:2]nameNick:100:=Substring:C12($working; $p+1)
			[QQQCustomer:2]nameNick:100:=Substring:C12([QQQCustomer:2]nameNick:100; 1; Length:C16([QQQCustomer:2]nameNick:100)-1)
		Else 
			[QQQCustomer:2]nameFirst:73:=$working
		End if 
		[QQQCustomer:2]company:2:=[QQQCustomer:2]nameLast:23+", "+[QQQCustomer:2]nameFirst:73
		[QQQCustomer:2]individual:72:=True:C214
		SAVE RECORD:C53([QQQCustomer:2])
	End if 
	NEXT RECORD:C51([QQQCustomer:2])
End for 
REDRAW WINDOW:C456