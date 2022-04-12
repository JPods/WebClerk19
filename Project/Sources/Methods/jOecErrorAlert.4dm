//%attributes = {"publishedWeb":true}
C_TEXT:C284(transErrMsg)
C_LONGINT:C283(transErr)
BEEP:C151
BEEP:C151
BEEP:C151
Case of 
	: (transErr=2000)
		transErrMsg:="The order record is locked.  Changes cannot be made."
	: (transErr=1000)
		ALERT:C41("Order "+String:C10([Invoice:26]orderNum:1)+" is locked by another user.")
		$Cancel:=0
	: (transErr=1001)
		ALERT:C41("Invoice "+String:C10([Invoice:26]invoiceNum:2)+" is locked by another user.")
		$Cancel:=0
	Else 
		ALERT:C41("Error "+String:C10(transErr)+" has occured.")
		$Cancel:=0
End case 
ALERT:C41(transErrMsg)