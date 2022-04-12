//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/28/06, 10:52:28
// ----------------------------------------------------
// Method: Email_clipManyReturns
// Description
// 
//
// Parameters
// ----------------------------------------------------
CLOSE DOCUMENT:C267(sumDoc)
CLOSE DOCUMENT:C267(myDoc)

myDoc:=Open document:C264("")
If (OK=1)
	sumDoc:=Create document:C266("")
	Repeat 
		RECEIVE PACKET:C104(myDoc; vText1; "\n")
		vText2:=""
		If (OK=1)
			vi8:=Position:C15(Char:C90(64); vText1)
			If (vi8>0)
				vi8:=Position:C15("<"; vText1)
				vi7:=Position:C15("hostmaster"; vText1)
				vi6:=Position:C15("mailer"; vText1)
				vi5:=(Position:C15("rfc822"; vText1))
				Case of 
					: (vi5>0)
						SEND PACKET:C103(sumDoc; Substring:C12(vText1; vi5+6))
					: (vText1="Message-ID@")
					: (vText1="Mailer-@")
						//
					: ((vText1="hostmaster@") | (vText1="Postmast@"))
						//
					: (vi8>0)
						
						//Tx_ClipArround 
						vText2:=Tx_ClipBetween(vText1; "<"; ">")
						Case of 
							: (vText2="Mailer-dae@")
								//
							: (Position:C15(Char:C90(64); vText2)<2)
								SEND PACKET:C103(sumDoc; vText1+"\r")
							Else 
								SEND PACKET:C103(sumDoc; vText2+"\r")
						End case 
					Else 
						SEND PACKET:C103(sumDoc; vText1+"\r")
				End case 
			End if 
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(sumDoc)
	CLOSE DOCUMENT:C267(myDoc)
End if 

If (False:C215)
	myDoc:=Open document:C264("")
	If (OK=1)
		sumDoc:=Create document:C266("")
		Repeat 
			RECEIVE PACKET:C104(myDoc; vText1; "\n")
			If (OK=1)
				vi8:=Position:C15("TO:"; vText1)
				If (vi8>0)
					vText2:=Tx_ClipBetween(vText1; "<"; ">")
					SEND PACKET:C103(sumDoc; vText2+"\r")
				End if 
			End if 
		Until (OK=0)
		CLOSE DOCUMENT:C267(sumDoc)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 