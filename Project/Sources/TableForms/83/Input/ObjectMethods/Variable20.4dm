entryEntity.approvalSales:=DE_PopUpArray(Self:C308)
If ([Requisition:83]approvalSales:11#Old:C35([Requisition:83]approvalSales:11))
	$tempStr:="Sales Release "+[Requisition:83]approvalSales:11+"."
	// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)
	vDate1:=Current date:C33
	vTime1:=Current time:C178
	[Requisition:83]dtApprSales:12:=DateTime_Enter
End if 