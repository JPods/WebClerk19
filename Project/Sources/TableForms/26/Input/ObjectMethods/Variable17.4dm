entryEntity.shipVia:=DE_PopUpArray(Self:C308)
Find Ship Zone(->[Invoice:26]zip:12; ->[Invoice:26]zone:6; ->[Invoice:26]shipVia:5; ->[Invoice:26]country:13; ->[Invoice:26]siteID:86)
// zzzqqq U_DTStampFldMod(->[Invoice:26]commentProcess:73; ->[Invoice:26]shipVia:5)
QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
C_LONGINT:C283($inc; $cnt)
CREATE EMPTY SET:C140([LoadTag:88]; "Current")
$cnt:=Records in selection:C76([LoadTag:88])
READ WRITE:C146([LoadTag:88])
FIRST RECORD:C50([LoadTag:88])
For ($inc; 1; $cnt)
	If (Not:C34(Locked:C147([LoadTag:88])))
		[LoadTag:88]carrierid:8:=[Invoice:26]shipVia:5
		SAVE RECORD:C53([LoadTag:88])
	Else 
		ADD TO SET:C119([LoadTag:88]; "Current")
	End if 
	NEXT RECORD:C51([LoadTag:88])
End for 
If (Records in set:C195("Current")>0)
	USE SET:C118("current")
	ALERT:C41("Some LoadTags were locked.")
	ProcessTableOpen(Table:C252(->[LoadTag:88]))
End if 
CLEAR SET:C117("Current")
READ ONLY:C145([LoadTag:88])
