//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/14/13, 15:23:22
// ----------------------------------------------------
// Method: DSSetsiteID
// Description
// 
//
// Parameters
// ----------------------------------------------------
$0:=""
If (Size of array:C274(<>asiteIDs)>1)
	C_OBJECT:C1216($obSel)
	$obSel:=ds:C1482.DefaultSetup.query("variableName = :1 AND machine = :2"; "siteID"; Current machine:C483)
	//UERY([DefaultSetup]; [DefaultSetup]variableName="siteID"; *)
	//UERY([DefaultSetup];  & [DefaultSetup]machine=Current machine)
	$obSel:=ds:C1482.DefaultSetup.all()
	Case of 
		: ($obSel.length=1)
			$0:=$obSel.first().value
			// $0:=[DefaultSetup]value
		: ($obSel.length>1)
			$0:=$obSel.first().value
			// $0:=[DefaultSetup]value
			ALERT:C41("There are multiple [DefaultSetup] for machine "+Current machine:C483)
		Else 
			ALERT:C41("You must create a [DefaultSetup] for machine "+Current machine:C483)
	End case 
	// REDUCE SELECTION([DefaultSetup]; 0)
End if 

