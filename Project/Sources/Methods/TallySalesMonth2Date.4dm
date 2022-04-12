//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/18/08, 16:05:16
// ----------------------------------------------------
// Method: TallySalesMonth2Date
// Description
// 
//
// Parameters
// ----------------------------------------------------

vdDateBeg:=Date_ThisMon(Current date:C33; 0)
vdDateEnd:=Current date:C33

ALL RECORDS:C47([Customer:2])
C_LONGINT:C283($incRec; 1; $cntRec)
$cntRec:=Records in selection:C76([Customer:2])
//ThermoInitExit ("Processing Sales MTD";$cntRec;True)
$viProgressID:=Progress New

For ($incRec; 1; $cntRec)
	//Thermo_Update ($incRec)
	ProgressUpdate($viProgressID; $incRec; $cntRec; "Processing Sales MTD")
	
	QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=vdDateBeg; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]dateInvoiced:35<=vdDateEnd; *)
	QUERY:C277([Invoice:26];  & [Invoice:26]customerID:3=[Customer:2]customerID:1)
	If (Records in selection:C76([Invoice:26])>0)
		[Customer:2]salesMTD:46:=Sum:C1([Invoice:26]amount:14)
	Else 
		[Customer:2]salesMTD:46:=0
	End if 
	SAVE RECORD:C53([Customer:2])
	NEXT RECORD:C51([Customer:2])
End for 
//Thermo_Close 
Progress QUIT($viProgressID)

//
If (False:C215)
	vdDateBeg:=Date_ThisMon(Current date:C33; 0)
	vdDateEnd:=Current date:C33
	//
	ALL RECORDS:C47([Customer:2])
	vi2:=Records in selection:C76([Customer:2])
	For (vi1; 1; vi2)
		QUERY:C277([Invoice:26]; [Invoice:26]dateInvoiced:35>=vdDateBeg; *)
		QUERY:C277([Invoice:26];  & [Invoice:26]dateInvoiced:35<=vdDateEnd; *)
		QUERY:C277([Invoice:26];  & [Invoice:26]customerID:3=[Customer:2]customerID:1)
		If (Records in selection:C76([Invoice:26])>0)
			[Customer:2]salesMTD:46:=Sum:C1([Invoice:26]amount:14)
		Else 
			[Customer:2]salesMTD:46:=0
		End if 
		SAVE RECORD:C53([Customer:2])
		NEXT RECORD:C51([Customer:2])
	End for 
End if 
