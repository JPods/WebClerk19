//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/28/06, 06:42:09
// ----------------------------------------------------
// Method: CommissionCalculator
// Description
// 
//
// Parameters
// ----------------------------------------------------

jBetweenDates("Ordered in Period.")
If (OK=1)
	ARRAY LONGINT:C221($aEmployeeRecs; 0)
	ARRAY TEXT:C222($aNameID; 0)
	SELECTION TO ARRAY:C260([Employee:19]; $aEmployeeRecs; [Employee:19]nameID:1; $aNameID)
	$cntRecs:=Size of array:C274($aNameID)
	For ($incRecs; 1; $cntRecs)
		GOTO RECORD:C242([Employee:19]; $aEmployeeRecs{$incRecs})
		QUERY:C277([Invoice:26]; [Invoice:26]daysPaid:27>=vdDateBeg; *)
		QUERY:C277([Invoice:26];  & [Invoice:26]daysPaid:27<=vdDateEnd; *)
		QUERY:C277([Invoice:26];  & [Invoice:26]salesNameID:23=[Employee:19]nameID:1)
		
		vi2:=Records in selection:C76([Invoice:26])
	End for 
End if 