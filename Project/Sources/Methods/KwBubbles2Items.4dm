//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: KwBubbles2Items
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1)
C_LONGINT:C283($i; $k; $keyCnt; $keyInc; $myOK)
If (Count parameters:C259=0)
	$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
Else 
	myDoc:=EI_UniqueDoc($1)
	$myOK:=OK
End if 
If ($myOK=1)
	$k:=Records in selection:C76([Word:99])
	FIRST RECORD:C50([Word:99])
	For ($i; 1; $k)
		MESSAGE:C88(String:C10($i))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[Word:99]relatedAlpha:8)
		If (Records in selection:C76([Item:4])=1)
			SEND PACKET:C103(myDoc; [Word:99]reference:6+"\t"+[Word:99]wordOnly:3+"\t"+[Word:99]relatedAlpha:8+"\t"+"f"+"\t"+[Item:4]description:7+"\r")
		Else 
			SEND PACKET:C103(myDoc; [Word:99]reference:6+"\t"+[Word:99]wordOnly:3+"\t"+[Word:99]relatedAlpha:8+"\t"+"m"+"\t"+[Item:4]description:7+"\r")
		End if 
		NEXT RECORD:C51([Word:99])
	End for 
	CLOSE DOCUMENT:C267(myDoc)
End if 

REDRAW WINDOW:C456