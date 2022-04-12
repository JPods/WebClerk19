vR2:=vR3
C_TEXT:C284($tempStr; $fileCur)
doSearch:=22
Case of 
	: (ptCurTable=(->[Order:3]))
		$fileCur:=" current Order "+String:C10([Order:3]orderNum:2; "0000-0000")
	: (ptCurTable=(->[Invoice:26]))
		$fileCur:=" current Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")
	: (ptCurTable=(->[PO:39]))
		$fileCur:=" current PO "+String:C10([PO:39]poNum:5; "0000-0000")
	: (ptCurTable=(->[Proposal:42]))
		$fileCur:=" current Proposal "+String:C10([Proposal:42]proposalNum:5; "0000-0000")
End case 
$tempStr:="Qty changed to "+String:C10(vR2)+$fileCur+" ."
// zzzqqq jDateTimeStamp(->vText1; $tempStr)