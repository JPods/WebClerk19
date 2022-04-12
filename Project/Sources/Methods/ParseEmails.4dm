//%attributes = {}
myDoc:=Open document:C264("")
If (OK=1)
	sumDoc:=Create document:C266("")
	RECEIVE PACKET:C104(myDoc; vText1; "\r")
	Repeat 
		vi8:=Position:C15("TO:"; vText1)
		If (vi8>0)
			vText2:=Tx_ClipBetween(vText1; "<"; ">")
			SEND PACKET:C103(sumDoc; vText2+"\r")
		End if 
		RECEIVE PACKET:C104(myDoc; vText1; "\r")
	Until (OK=0)
	CLOSE DOCUMENT:C267(sumDoc)
	CLOSE DOCUMENT:C267(myDoc)
End if 
