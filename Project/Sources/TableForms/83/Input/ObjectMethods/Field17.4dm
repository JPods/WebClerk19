C_TEXT:C284($tempStr)
If ([Requisition:83]CurQty:23#Old:C35([Requisition:83]CurQty:23))
	$tempStr:="Qty changed to "+String:C10([Requisition:83]CurQty:23)+"."
	// zzzqqq jDateTimeStamp(->[Requisition:83]LogText:37; $tempStr)
	[Requisition:83]CurExtCost:50:=Round:C94(([Requisition:83]CurQty:23*(DiscountApply([Requisition:83]CurCost:22; [Requisition:83]CurDiscount:48; 10)))-[Requisition:83]CurFixedDiscout:49; <>tcDecimalTt)
End if 