If (False:C215)
	If (Size of array:C274(aRptLines)#1)
		ALERT:C41("Select one report to set as Primary Override.")
	Else 
		Case of 
			: (ptCurTable=(->[Invoice:26]))
				$cntRecs:=Records in selection:C76([Invoice:26])
				CONFIRM:C162("Set Primary Form to: "+aRptNames{aRptLines{1}}+" Records: "+String:C10($cntRecs))
				If (OK=1)
					FIRST RECORD:C50([Invoice:26])
					For ($incRecs; 1; $cntRecs)
						[Invoice:26]primaryForm:89:=aRptNames{aRptLines{1}}
						SAVE RECORD:C53([Invoice:26])
						NEXT RECORD:C51([Invoice:26])
					End for 
				End if 
			: (ptCurTable=(->[Order:3]))
				$cntRecs:=Records in selection:C76([Order:3])
				CONFIRM:C162("Set Primary Form to: "+aRptNames{aRptLines{1}}+" Records: "+String:C10($cntRecs))
				If (OK=1)
					FIRST RECORD:C50([Order:3])
					For ($incRecs; 1; $cntRecs)
						[Order:3]primaryForm:111:=aRptNames{aRptLines{1}}
						SAVE RECORD:C53([Order:3])
						NEXT RECORD:C51([Order:3])
					End for 
				End if 
			: (ptCurTable=(->[Proposal:42]))
				$cntRecs:=Records in selection:C76([Proposal:42])
				CONFIRM:C162("Set Primary Form to: "+aRptNames{aRptLines{1}}+" Records: "+String:C10($cntRecs))
				If (OK=1)
					FIRST RECORD:C50([Proposal:42])
					For ($incRecs; 1; $cntRecs)
						[Proposal:42]primaryForm:80:=aRptNames{aRptLines{1}}
						SAVE RECORD:C53([Proposal:42])
						NEXT RECORD:C51([Proposal:42])
					End for 
				End if 
			: (ptCurTable=(->[PO:39]))
				$cntRecs:=Records in selection:C76([PO:39])
				CONFIRM:C162("Set Primary Form to: "+aRptNames{aRptLines{1}}+" Records: "+String:C10($cntRecs))
				If (OK=1)
					FIRST RECORD:C50([PO:39])
					For ($incRecs; 1; $cntRecs)
						[PO:39]primaryForm:76:=aRptNames{aRptLines{1}}
						SAVE RECORD:C53([PO:39])
						NEXT RECORD:C51([PO:39])
					End for 
				End if 
		End case 
	End if 
	//Else 
	//ALERT("You must be in the UserReport to change Primary Report.")
End if 