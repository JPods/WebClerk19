//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: itemXREFfromTxtFile
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//

myDoc:=Open document:C264("")
sumDoc:=Create document:C266("")
TRACE:C157
If (OK=1)
	Repeat 
		RECEIVE PACKET:C104(myDoc; $theLine; "\r")  //first line
		$keepGoing:=(OK=1)
		If ($keepGoing)
			TextToArray($theLine; ->aText5; "\t"; True:C214)  //first line
			$rightSize:=(Size of array:C274(aText5)=2)
			If ($rightSize)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aText5{1})
				If (Records in selection:C76([Item:4])=1)
					ARRAY LONGINT:C221(<>aItemLines; 1)
					<>aItemLines{1}:=1
					ARRAY LONGINT:C221(<>aLsSrRec; 1)
					<>aLsSrRec{1}:=Record number:C243([Item:4])
					QUERY:C277([Item:4]; [Item:4]itemNum:1=aText5{2})
					If (Records in selection:C76([Item:4])=1)
						XRef_BuildFromRay
					Else 
						SEND PACKET:C103(sumDoc; "Missing Related"+"\t"+aText5{2}+"\r")
					End if 
				Else 
					SEND PACKET:C103(sumDoc; "Missing Master"+"\t"+aText5{1}+"\r")
				End if 
			End if 
		End if 
	Until ($keepGoing=False:C215)
	CLOSE DOCUMENT:C267(myDoc)
	CLOSE DOCUMENT:C267(sumDoc)
End if 