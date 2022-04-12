myDoc:=Open document:C264("")
If (OK=1)
	iLoText2:=document
	RECEIVE PACKET:C104(myDoc; iLoText2; 700)
	CLOSE DOCUMENT:C267(myDoc)
End if 