If ([UserReport:46]SavedInternal:18)
	[UserReport:46]Creator:6:="GtSR"
	URpt_SetTypePop
	URpt_SetTypePrm
Else 
	CONFIRM:C162("Do you wish to clear this internal report?")
	If (OK=1)
		[UserReport:46]Creator:6:=""
		URpt_SetTypePop
		CLEAR VARIABLE:C89(reportDefinitionBlob)
		[UserReport:46]ReportBlob:27:=reportDefinitionBlob
		$result:=SR New Report(reportDefinitionBlob)
		If ($result=0)
			$result:=SR Set Area(eSRWin; reportDefinitionBlob)
		End if 
	End if 
End if 