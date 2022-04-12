//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: XRefRecordsOut
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($i; $k; $incXRef; $cntXRef)
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Item:4])
If ($k>0)
	If (Count parameters:C259>0)
		myDocName:=$1
	Else 
		myDocName:=""
	End if 
	$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
	If ($myOK=1)
		If (Count parameters:C259>1)
			ORDER BY:C49([Item:4]; $2->)
		Else 
			ORDER BY:C49([Item:4]; [Item:4]itemNum:1)
		End if 
		FIRST RECORD:C50([Item:4])
		For ($i; 1; $k)
			
			SEND PACKET:C103(myDoc; "<XRefRelation>"+"\t")
			SEND PACKET:C103(myDoc; "1"+"\t")
			SEND PACKET:C103(myDoc; "</XRefRelation>"+"\t")
			SEND PACKET:C103(myDoc; "<XRef>"+"\t")
			SEND PACKET:C103(myDoc; [Item:4]itemNum:1+"\t")
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=[Item:4]itemNum:1)
			$cntXRef:=Records in selection:C76([ItemXRef:22])
			If ($cntXRef>0)
				ORDER BY:C49([ItemXRef:22]; [ItemXRef:22]itemNumXRef:2)
				FIRST RECORD:C50([ItemXRef:22])
				For ($incXRef; 1; $cntXRef)
					SEND PACKET:C103(myDoc; [ItemXRef:22]itemNumXRef:2+"\t")
					NEXT RECORD:C51([ItemXRef:22])
				End for 
			End if 
			SEND PACKET:C103(myDoc; "</XRef>"+"\r")
			NEXT RECORD:C51([Item:4])
		End for 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 