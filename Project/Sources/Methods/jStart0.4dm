//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 09/21/16, 11:23:10
// ----------------------------------------------------
// Method: jStart0
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160921_1119 protect against deleted tables

//Procedure: jStartup

C_PICTURE:C286(<>pClock; <>pLauncher; <>pMagGlass; <>pAdminBt)
C_PICTURE:C286(<>pShipVia; <>pAddDelta; <>pAddLn; <>pDelLn; <>pChangeLn; <>pNavPallet)

//
vText1:=""
lbAddr1:="Address1"

// ### bj ### 20191025_1742


Execute_TallyMaster("ArchiveInternal"; "ArchiveInternal")


ARRAY TEXT:C222(<>aItemAction; 5)
<>aItemAction{1}:="Details"
<>aItemAction{2}:="Duplicate"
<>aItemAction{3}:="Item Record"
<>aItemAction{4}:="Prime Record"
<>aItemAction{5}:="QuickQuote"
<>aItemAction:=1  //set selection to Details


$cntTables:=Get last table number:C254
C_LONGINT:C283($cntTables; $incTables)  //use with Show Current Selection menu under Action
For ($incTables; 1; $cntTables)
	// ### jwm ### 20160921_1119 protect against deleted tables
	If (Is table number valid:C999($incTables))
		$setName:="<>set"+Table name:C256($incTables)
		CREATE SET:C116(Table:C252($incTables)->; $setName)
	End if 
	
End for 
