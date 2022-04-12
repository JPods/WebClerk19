C_LONGINT:C283($myOK)
myDocName:=""
$myOK:=EI_OpenDoc(->myDocName; ->sumDoc; "Select File to Read"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
If ($myOK=1)
	C_TEXT:C284($myText)
	myDocName:=document
	<>vEoF:=Get document size:C479(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
	RECEIVE PACKET:C104(sumDoc; $myText; <>vEoF)
	vTextSummary:=vTextSummary+"\r"+"\r"+$myText
	CLOSE DOCUMENT:C267(sumDoc)
	//**WR INSERT TEXT (eLetterArea;vText)
End if 