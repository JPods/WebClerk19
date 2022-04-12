//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/14/13, 15:23:13
// ----------------------------------------------------
// Method: DSSetMachineID
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $input)
If ((Count parameters:C259=1) & (Size of array:C274(<>asiteIDs)>1))
	$input:=$1
	QUERY:C277([DefaultSetup:86]; [DefaultSetup:86]variableName:7="siteID"; *)
	QUERY:C277([DefaultSetup:86];  & [DefaultSetup:86]machine:13=Current machine:C483)
	KeyModifierCurrent
	Case of 
		: ($input="")
			// skip if there is no value to enter
		: (Records in selection:C76([DefaultSetup:86])=0)
			CONFIRM:C162("Do you want to create a siteID Default for this machine at "+$1+"?")
			If (OK=1)
				DSCreateRecord("siteID"; $1; "Is String Var"; "Manage items by site.")
			Else 
				$1:=""
			End if 
		: (([DefaultSetup:86]value:9#$1) & ((OptKey=1) | (CmdKey=1)))
			CONFIRM:C162("Do you want to override the machine siteID of "+[DefaultSetup:86]value:9+" with "+$input+"?"; "Skip"; "Override")
			If (OK=1)
				[DefaultSetup:86]value:9:=$1
				SAVE RECORD:C53([DefaultSetup:86])
			End if 
		: (False:C215)  //[DefaultSetup]Value#$1)
			CONFIRM:C162("Do you want to override the machine siteID of "+[DefaultSetup:86]value:9+" with "+$input+"?"; "Skip"; "Override")
			If (OK=1)
				$1:=""
			End if 
	End case 
	REDUCE SELECTION:C351([DefaultSetup:86]; 0)
End if 

