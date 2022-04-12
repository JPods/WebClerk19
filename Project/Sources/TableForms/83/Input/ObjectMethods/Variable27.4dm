entryEntity.approvalOth:=DE_PopUpArray(Self:C308)
If ([Requisition:83]approvalCood:16#Old:C35([Requisition:83]approvalCood:16))
	$tempStr:="Other2 released "+[Requisition:83]approvalOth:18+"."
	// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)
	vDate4:=Current date:C33
	vTime4:=Current time:C178
	[Requisition:83]dtApprOth:19:=DateTime_Enter
End if 