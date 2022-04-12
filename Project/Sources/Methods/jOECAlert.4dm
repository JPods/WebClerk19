//%attributes = {"publishedWeb":true}
// 
C_BOOLEAN:C305($doErr)
$doErr:=False:C215
Case of 
	: (ptCurTable=(->[Invoice:26]))
		If (error=-9998)
			$thisInvoice:=[Invoice:26]invoiceNum:2
			$endLoop:=False:C215
			Repeat 
				[Invoice:26]invoiceNum:2:=[Invoice:26]invoiceNum:2+1
				SAVE RECORD:C53([Invoice:26])
				If (Record number:C243([Invoice:26])#-3)
					$endLoop:=True:C214
				End if 
			Until ($endLoop)
			READ WRITE:C146([QQQCounter:41])
			GOTO RECORD:C242([QQQCounter:41]; Table:C252(ptCurTable))
			[QQQCounter:41]Counter:1:=[Invoice:26]invoiceNum:2+1
			SAVE RECORD:C53([QQQCounter:41])
		Else 
			$doErr:=True:C214
		End if 
	Else 
		$doErr:=True:C214
End case 
If ($doErr)
	ALERT:C41("Error "+String:C10(Error)+"!!!")
End if 