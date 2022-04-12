//%attributes = {}
//CashDrawerOpen

C_LONGINT:C283(bOpenCashDrawer)
ON ERR CALL:C155("jOECNoAction")
SET CHANNEL:C77(<>vCashDrawerPort; <>vCashDrawerProtocal)
If (OK=1)
	SET TIMEOUT:C268(<>vCashDrawerOpen)  //set the length of the system error for timeout
	SEND PACKET:C103(Char:C90(<>CashDrawerCharNum))  // SEND get weight command
End if 
