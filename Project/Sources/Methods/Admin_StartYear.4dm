//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/20/08, 17:33:23
// ----------------------------------------------------
// Method: Admin_StartYear
// Description
// 
//
// Parameters
// ----------------------------------------------------


ALL RECORDS:C47([QQQCustomer:2])
$cntRec:=Records in selection:C76([QQQCustomer:2])
FIRST RECORD:C50([QQQCustomer:2])
ARRAY LONGINT:C221($aCustomersLocked; 0)
For ($incRec; 1; $cntRec)
	If (Not:C34(Locked:C147([QQQCustomer:2])))
		[QQQCustomer:2]salesLastYr:48:=[QQQCustomer:2]salesYTD:47
		[QQQCustomer:2]salesYTD:47:=0
		SAVE RECORD:C53([QQQCustomer:2])
	Else 
		APPEND TO ARRAY:C911($aCustomersLocked; Record number:C243([QQQCustomer:2]))
	End if 
	NEXT RECORD:C51([QQQCustomer:2])
End for 

While (Size of array:C274($aCustomersLocked)>0)
	DELAY PROCESS:C323(Current process:C322; 60*60)
	$cntRec:=Size of array:C274($aCustomersLocked)
	For ($incRec; $cntRec; 1; -1)
		GOTO RECORD:C242([QQQCustomer:2]; $aCustomersLocked{$incRec})
		If (Not:C34(Locked:C147([QQQCustomer:2])))
			[QQQCustomer:2]salesMTD:46:=0
			SAVE RECORD:C53([QQQCustomer:2])
			DELETE FROM ARRAY:C228($aCustomersLocked; $incRec; 1)
		End if 
	End for 
End while 