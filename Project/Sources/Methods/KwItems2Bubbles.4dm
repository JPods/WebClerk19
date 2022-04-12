//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: KwItems2Bubbles
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1)
C_LONGINT:C283($i; $k; $keyCnt; $keyInc; $myOK)
$doSubFile:=False:C215
If (Count parameters:C259=0)
	$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
Else 
	myDoc:=EI_UniqueDoc($1)
	$myOK:=OK
End if 
If ($myOK=1)
	SEND PACKET:C103(myDoc; "ItemNum"+"\t"+"Description"+"\t"+"KeyCount"+"\t"+"Model"+"\t"+"Bubble"+"\t"+"Repeated")
	FIRST RECORD:C50([Item:4])
	$k:=Records in selection:C76([Item:4])
	For ($i; 1; $k)
		MESSAGE:C88(String:C10($i))
		QUERY:C277([Word:99]; [Word:99]tableNum:2=4; *)
		// QUERY([Keyword]; & [Keyword]FieldNum=1;*)
		QUERY:C277([Word:99];  & [Word:99]relatedAlpha:8=[Item:4]itemNum:1)
		$keyCnt:=Records in selection:C76([Word:99])
		SEND PACKET:C103(myDoc; [Item:4]itemNum:1+"\t"+[Item:4]description:7+"\t"+String:C10($keyCnt))
		If ($keyCnt=0)
			SEND PACKET:C103(myDoc; "\r")
		Else 
			FIRST RECORD:C50([Word:99])
			For ($keyInc; 1; $keyCnt)
				SEND PACKET:C103(myDoc; "\t"+[Word:99]reference:6+"\t"+[Word:99]wordOnly:3)
				NEXT RECORD:C51([Word:99])
			End for 
			SEND PACKET:C103(myDoc; "\r")
		End if 
		NEXT RECORD:C51([Item:4])
	End for 
	CLOSE DOCUMENT:C267(myDoc)
End if 