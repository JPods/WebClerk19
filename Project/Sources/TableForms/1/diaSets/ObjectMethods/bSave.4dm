C_LONGINT:C283($myOK; $error; $noInsert)
C_TEXT:C284($myFileName)

C_TEXT:C284(vtSetName)
If (vHere>0)
	
	If (vtSetName="")
		vtSetName:=Request:C163("Please enter set name")
	End if 
	
	If (vtSetName#"")
		
		$vtConfirm:="Save Set \""+vtSetName+"\" \r\rWith "+String:C10(Records in selection:C76(ptCurTable->))+" "+Table name:C256(ptCurTable)+" Records"
		CONFIRM:C162($vtConfirm; " Save "; " Cancel ")
		If (OK=1)
			
			If ((aText4>0) & (aText4<=Size of array:C274(aText4)))
				$vtUUIDKey:=aText4{atext4}  // currently selected element of aText4
			Else 
				$vtUUIDKey:=""
			End if 
			
			HIGHLIGHT TEXT:C210(vtSetName; 1; 100)
			Set_Action("save"; vtSetName; Table:C252(ptCurTable); $vtUUIDKey)
			ALpLoadSets
		End if 
	End if 
End if 