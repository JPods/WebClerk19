C_LONGINT:C283($myOK)

$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
If ($myOK=1)
	SEND PACKET:C103(myDoc; vTextSummary)
	CLOSE DOCUMENT:C267(myDoc)
End if 