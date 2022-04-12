//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PeachTreeCustomers
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

CLOSE DOCUMENT:C267(myDoc)

C_TEXT:C284($myText; $myText2)
myDoc:=Open document:C264(document)
If (OK=1)
	RECEIVE PACKET:C104(myDoc; $myText; 15000)
	Repeat 
		$testLen:=Length:C16($myText)
		If ($testLen<14000)
			RECEIVE PACKET:C104(myDoc; $myText2; 15000)
		End if 
		If ((OK=1) | ($testLen>0))
			$myText:=$myText+$myText2
			$p:=Position:C15("ITEM NUMBER"; $myText)
			If ($p>0)
				
				$finalText:=TxtParseByPosition($myText; "ITEM NUMBER   :         "; 1; 30)
				If ($finalText#"")
					QUERY:C277([Item:4]; [Item:4]itemNum:1=$finalText)
					//If (Records in selection([Item])=0)
					//CREATE RECORD([Item])
					//[Item]ItemNum:=$finalText
					$finalText:=TxtParseByPosition($myText; "DESCRIPTION   :         "; 1; 33)
					$finalText:=TxtParseByPosition($myText; "RECVG UNITS   :         "; 1; 30)
					$finalText:=TxtParseByPosition($myText; "VENDOR 1      :"; 1; 40)
					$finalText:=TxtParseByPosition($myText; "CURRENT COST  :              "; 1; 30)
					$finalText:=TxtParseByPosition($myText; "RECVG UNITS   :         "; 1; 30)
					
				Else 
					$myText:=""
				End if 
				
			End if 
		End if 
	Until ($p=0)
	CLOSE DOCUMENT:C267(myDoc)
End if 