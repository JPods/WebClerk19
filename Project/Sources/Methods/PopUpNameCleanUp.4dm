//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-16T00:00:00, 14:54:14
// ----------------------------------------------------
// Method: PopUpNameCleanUp
// Description
// Modified: 12/16/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	READ WRITE:C146([PopupChoice:134])
	READ WRITE:C146([PopUp:23])
	If (Count parameters:C259=0)
		
		// correct any name conversion problems
		QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3="@")
		$RIS:=Records in selection:C76([PopUp:23])
		For ($Ndx; 1; $RIS)
			GOTO SELECTED RECORD:C245([PopUp:23]; $Ndx)
			[PopUp:23]arrayName:3:=Replace string:C233([PopUp:23]arrayName:3; ""; "<>")
			SAVE RECORD:C53([PopUp:23])
		End for 
		UNLOAD RECORD:C212([PopUp:23])
		
		PopUpNameCleanUp("<>aItmPro"; "<>aItemsProfile")
		PopUpNameCleanUp("<>aSpecPro"; "<>aItemSpecProfile")
		PopUpNameCleanUp("<>aItemsSpecProfile"; "<>aItemSpecProfile")
		
		PopUpNameCleanUp("<>aOrdersProfile"; "<>aOrdersProfile")
		PopUpNameCleanUp("<>aPOPro"; "<>aPOsProfile")
		PopUpNameCleanUp("<>aRqPro"; "<>aRequistitionsProfile")
		PopUpNameCleanUp("<>aWoPro"; "<>aWorkOrdersProfile")
		PopUpNameCleanUp("<>aSaleType"; "<>aTypeSale")
		PopUpNameCleanUp("<>aVendorProfile"; "<>aVendorsProfile")
		PopUpNameCleanUp("<>aRepProfile"; "<>aRepsProfile")
		PopUpNameCleanUp("<>aItmType"; "<>aItemsType")
		
		
		PopUpNameCleanUp("<>aRqStatus"; "<>aRequistitionsStatus")  // no variable name
		PopUpNameCleanUp("<>aSvReference"; "<>aServiceReference")  // no variable name
		PopUpNameCleanUp("<>aWdStatus"; "<>aWOdrawsStatus")  // no variable name
		PopUpNameCleanUp("<>aPplStatus"; "<>aProposalsStatus")
		PopUpNameCleanUp("<>aPOStatus"; "<>aPOsStatus")
		PopUpNameCleanUp("<>aRqAction"; "<>aRequisitionsAction")
		PopUpNameCleanUp("<>aOrdPro"; "<>aOrdersProfile")
		PopUpNameCleanUp("<>aWoStatus"; "<>aWorkOrdersStatus")
		PopUpNameCleanUp("<>aXRefAct"; "<>aItemXRefsAction")
		
		
		ALL RECORDS:C47([PopUp:23])
		C_LONGINT:C283($i; $k)
		$k:=Records in selection:C76([PopUp:23])
		FIRST RECORD:C50([PopUp:23])
		For ($i; 1; $k)
			[PopUp:23]arrayName:3:=Replace string:C233([PopUp:23]arrayName:3; "filefile"; "file")
			// [PopUp]ArrayName:=Replace string([PopUp]ArrayName;"file(\d+)";"file\1")
			SAVE RECORD:C53([PopUp:23])
			NEXT RECORD:C51([PopUp:23])
		End for 
	Else 
		
		C_TEXT:C284($1; $oldValuve; $2; $newValue)
		$oldValuve:=$1
		$newValue:=$2
		//  
		If ($oldValuve#$newValue)
			QUERY:C277([PopUp:23]; [PopUp:23]arrayName:3=$oldValuve+"@")
			vi2:=Records in selection:C76([PopUp:23])
			For (vi1; 1; vi2)
				[PopUp:23]arrayName:3:=Replace string:C233([PopUp:23]arrayName:3; $oldValuve; $newValue)
				If ([PopUp:23]listName:4="")  // Do not step on existing custom names
					[PopUp:23]listName:4:=Substring:C12([PopUp:23]arrayName:3; 4)
				End if 
				SAVE RECORD:C53([PopUp:23])
				NEXT RECORD:C51([PopUp:23])
			End for 
			UNLOAD RECORD:C212([PopUp:23])
			//
			QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=$oldValuve+"@")
			vi2:=Records in selection:C76([PopupChoice:134])
			For (vi1; 1; vi2)
				[PopupChoice:134]arrayName:1:=Replace string:C233([PopupChoice:134]arrayName:1; $oldValuve; $newValue)
				SAVE RECORD:C53([PopupChoice:134])
				NEXT RECORD:C51([PopupChoice:134])
			End for 
			UNLOAD RECORD:C212([PopupChoice:134])
		End if 
	End if 
End if 