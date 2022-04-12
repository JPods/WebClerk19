If (False:C215)
	//Object Method: b43 
	//Date: 07/01/02
	//Who: Bill
	//Description: Write XML file
End if 
C_LONGINT:C283($i; $k; $myOK)

If ((Size of array:C274(aMatchField)=Size of array:C274(aImpFields)) & (Size of array:C274(aMatchField)>0))
	$myReason:=Request:C163("XML matched pairs for: ")
	If ((OK=1) & ($myReason#""))
		$k:=Size of array:C274(aImpFields)
		myDocName:=""
		$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
		If ($myOK=1)
			SEND PACKET:C103(myDoc; "XML:  "+$myReason+Storage:C1525.char.crlf)
			TRACE:C157
			For ($i; 1; $k)
				Case of 
					: (aMatchField{$i}="Not Imported")
						SEND PACKET:C103(myDoc; aImpFields{$i}+"\t"+aMatchField{$i}+"\t"+"0"+"\t"+"0"+"\t"+"zzzz"+Storage:C1525.char.crlf)
					Else 
						SEND PACKET:C103(myDoc; aImpFields{$i}+"\t"+aMatchField{$i}+"\t"+String:C10(curTableNum)+"\t"+String:C10(aMatchNum{$i})+"\t"+"load"+Storage:C1525.char.crlf)
				End case 
			End for 
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
End if 