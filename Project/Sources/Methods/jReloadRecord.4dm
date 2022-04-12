//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/04/07, 21:41:19
// ----------------------------------------------------
// Method: jReloadRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($ptCurTable)
If (vHere>1)
	$curRecordNum:=Record number:C243(ptCurTable->)
	$ptCurTable:=ptCurTable
	If ($curRecordNum>-1)
		$lockedStatus:=Locked:C147(ptCurTable->)
		If ($lockedStatus=True:C214)
			//CONFIRM("Reload current Record; release in other processes?")
			//If (OK=1)
			C_LONGINT:C283($curProcess)
			$curProcess:=Current process:C322
			C_LONGINT:C283($index)
			C_LONGINT:C283($tasks; $prsNum; $state; $tics)
			$tasks:=Count tasks:C335
			C_LONGINT:C283($fia)
			C_LONGINT:C283($dtLaunch)
			//KeyModifierCurrent 
			For ($index; 1; $tasks)
				If (Process state:C330($index)>-1)
					$prsNum:=$index
					PROCESS PROPERTIES:C336($prsNum; $name; $state; $tics)
					If ($prsNum#$curProcess)
						If (($name#"Cache Manager@") & ($name#"User/") & ($name#"$@") & ($name#"Log") & ($name#"Processes") & ($name#"Design process@") & ($name#"Apple Events Ma@") & ($prsNum>-1))
							BRING TO FRONT:C326($prsNum)
							If (Record number:C243($ptCurTable->)=$curRecordNum)
								If (Not:C34(Locked:C147(ptCurTable->)))
									//jSaveRecord
									SAVE RECORD:C53($ptCurTable->)
									UNLOAD RECORD:C212($ptCurTable->)
									READ ONLY:C145($ptCurTable->)
									LOAD RECORD:C52($ptCurTable->)
								End if 
							End if 
						End if 
					End if 
				End if 
			End for 
			//If (Current process#$curProcess)
			BRING TO FRONT:C326($curProcess)
			UNLOAD RECORD:C212($ptCurTable->)
			READ WRITE:C146($ptCurTable->)
			LOAD RECORD:C52($ptCurTable->)
			//End if 
		End if 
		//End if 
	End if 
	Set_Window_Title(ptCurTable)
End if 
