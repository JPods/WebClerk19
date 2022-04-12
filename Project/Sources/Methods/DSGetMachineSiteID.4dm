//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/11/13, 18:11:52
// ----------------------------------------------------
// Method: DSGetMachinesiteID
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)
$0:=""  //initialize to empty 
//
If (Size of array:C274(<>asiteIDs)>1)  //  there is a header
	QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="siteID"; *)
	QUERY:C277([DefaultSetup:86];  & [DefaultSetup:86]machine:13=Current machine:C483)
	Case of 
		: (Records in selection:C76([DefaultSetup:86])=1)
			If ([DefaultSetup:86]value:9="")
				DELETE RECORD:C58([DefaultSetup:86])
			Else 
				$0:=[DefaultSetup:86]value:9
			End if 
		: (Records in selection:C76([DefaultSetup:86])=0)
			If (allowAlerts_boo)
				If (Size of array:C274(<>asiteIDs)>1)
				End if 
				ALERT:C41("Manually set siteID.")
			Else 
				$0:=<>asiteIDs{2}
			End if 
		Else   // (Records in selection([DefaultSetup])=1)
			FIRST RECORD:C50([DefaultSetup:86])
			$0:=[DefaultSetup:86]value:9
			If (allowAlerts_boo)
				ALERT:C41("Multiple defaults. Contact database adminstrator.")
			End if 
	End case 
End if 