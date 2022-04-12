//%attributes = {"publishedWeb":true}
C_TEXT:C284($WandID)
C_TEXT:C284($StrIn; $ScanStr)
C_LONGINT:C283($index; $myOK)
C_BOOLEAN:C305($ItemFlag; $doEnd)
RECEIVE PACKET:C104(myDoc; $StrIn; "\r")
Case of 
	: (($StrIn="Text") | ($StrIn="Load Line"))  //standard order file    
		$index:=0
		Repeat 
			RECEIVE PACKET:C104(myDoc; $StrIn; "\t")
			RECEIVE PACKET:C104(myDoc; $ScanStr; "\r")
			If (OK=1)
				$index:=$index+1
				INSERT IN ARRAY:C227(aTWItemNum; $index)
				INSERT IN ARRAY:C227(aTWQty; $index)
				aTWItemNum{$index}:=$StrIn
				aTWQty{$index}:=Num:C11($ScanStr)
			End if 
		Until (OK=0)
		OrderItmQtyList(->aTWItemNum; ->aTWQty)
	: ($StrIn="TW1")  //TimeWand I
	: ($StrIn="TW2")  //TimeWand II
		//retrieve wand info from file
		RECEIVE PACKET:C104(myDoc; $StrIn; "\r")
		If (OK=1)
			$WandID:=$StrIn
			SET CHANNEL:C77(21; 27652)  //modem port XON/XOFF 19200 8n1
			SET TIMEOUT:C268(10)
			RECEIVE BUFFER:C172($StrIn)  //flush the buffer
			//lock all timewand IIs
			SEND PACKET:C103("G"+Storage:C1525.char.crlf)
			RECEIVE BUFFER:C172($StrIn)
			//unlock a timewand II
			SEND PACKET:C103("I "+$WandID+Storage:C1525.char.crlf)
			RECEIVE PACKET:C104($StrIn; "\n")
			If ((OK=1) & (Substring:C12($StrIn; 1; 4)="TWII"))
				//download scan file
				SEND PACKET:C103("D"+Storage:C1525.char.crlf)
				RECEIVE PACKET:C104($StrIn; "\n")  //header line discard
				$index:=0
				$ItemFlag:=True:C214
				RECEIVE PACKET:C104($StrIn; "\n")
				While ((OK=1) & ($StrIn#("T 000"+"\r")))
					If ($ItemFlag)
						$ScanStr:=Substring:C12($StrIn; 20; Length:C16($StrIn)-20)  //scan text starts 19, strip 1st letter 20, string ends w/ vCR (len -1)
						$index:=$index+1
						INSERT IN ARRAY:C227(aTWItemNum; $index)
						aTWItemNum{$index}:=$ScanStr
						$ItemFlag:=False:C215
					Else 
						$ScanStr:=Substring:C12($StrIn; 19; Length:C16($StrIn)-19)  //scan text starts 19, string ends w/ vCR (len -1)
						INSERT IN ARRAY:C227(aTWQty; $index)
						aTWQty{$index}:=Num:C11($ScanStr)
						$ItemFlag:=True:C214
					End if 
					RECEIVE PACKET:C104($StrIn; "\n")
				End while 
				If ((OK=1) & ($ItemFlag))
					//clear scan file
					SEND PACKET:C103("Z"+Storage:C1525.char.crlf)
					RECEIVE PACKET:C104($StrIn; "\n")
					//set time in wand
					$ScanStr:=String:C10(Current date:C33; 4)
					$StrIn:=Substring:C12($ScanStr; 7; 2)+Substring:C12($ScanStr; 1; 2)+Substring:C12($ScanStr; 4; 2)
					$ScanStr:=String:C10(Current time:C178; 1)
					$StrIn:=$StrIn+Substring:C12($ScanStr; 1; 2)+Substring:C12($ScanStr; 4; 2)+Substring:C12($ScanStr; 7; 2)
					SEND PACKET:C103("T"+$StrIn+Storage:C1525.char.crlf)
					RECEIVE PACKET:C104($StrIn; "\n")
					//display "Order Sent" on wand
					SEND PACKET:C103("M1"+"Order Sent      "+Storage:C1525.char.crlf)
					SEND PACKET:C103("M2"+"Scans Cleared   "+Storage:C1525.char.crlf)  //blank 2nd line
					//lock wand
					SEND PACKET:C103("G"+Storage:C1525.char.crlf)
					RECEIVE PACKET:C104($StrIn; "\n")
					OrderItmQtyList(->aTWItemNum; ->aTWQty)
				Else 
					//lock wand
					SEND PACKET:C103("G"+Storage:C1525.char.crlf)
					ALERT:C41("The scans in the wand are incomplete.")
				End if 
			Else 
				//lock wand
				SEND PACKET:C103("G"+Storage:C1525.char.crlf)
				ALERT:C41("The TimeWand II: "+$WandID+", can't be found.")
			End if 
		End if 
End case 