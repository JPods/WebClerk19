//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $1; $w)
If ($1>0)
	myDocName:=""
	$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "Create Quicken QIF File")
	If ($myOK=1)
		FIRST RECORD:C50([PO:39])
		SEND PACKET:C103(myDoc; "!Type:Bank"+"\r")
		For ($i; 1; $1)
			$w:=Find in array:C230(<>aTerms; [PO:39]terms:17)
			If ($w>0)
				$dateDue:=[PO:39]dateComplete:4+<>aTermDueDay{$w}
			Else 
				$dateDue:=[PO:39]dateComplete:4
			End if 
			If ($dateDue<Current date:C33)
				$dateDue:=Current date:C33
			End if 
			SEND PACKET:C103(myDoc; "D"+String:C10($dateDue)+"\r")
			SEND PACKET:C103(myDoc; "T"+String:C10(-[PO:39]amount:19)+"\r")
			SEND PACKET:C103(myDoc; "N*****"+"\r")
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
			SEND PACKET:C103(myDoc; "P"+[Vendor:38]company:2+"\r")
			SEND PACKET:C103(myDoc; "A"+[Vendor:38]address1:4+"\r")
			SEND PACKET:C103(myDoc; "A"+[Vendor:38]city:6+", "+[Vendor:38]state:7+" "+[Vendor:38]zip:8+"\r")
			SEND PACKET:C103(myDoc; "L"+[PO:39]attnOther:38+"\r")
			SEND PACKET:C103(myDoc; "^"+"\r")
			NEXT RECORD:C51([PO:39])
		End for 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 