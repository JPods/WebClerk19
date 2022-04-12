//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/08/13, 09:20:36
// ----------------------------------------------------
// Method: EssentialVariableSet
// Description
// 
//
// Parameters
// ----------------------------------------------------
QUERY:C277([TallyMaster:60]; [TallyMaster:60]Purpose:3="EssentialSetups")
If (Records in selection:C76([TallyMaster:60])>0)
	ARRAY LONGINT:C221($aRecords; 0)
	SELECTION TO ARRAY:C260([TallyMaster:60]; $aRecords)
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		GOTO RECORD:C242([TallyMaster:60]; $aRecords{$i})
		ExecuteText(0; [TallyMaster:60]Script:9)
	End for 
End if 
REDUCE SELECTION:C351([TallyMaster:60]; 0)