//%attributes = {"publishedWeb":true}
TRACE:C157
//Method: Blob_LoadTest
C_BLOB:C604($myBlob)
C_TEXT:C284($vLoadText; $mySendText)
C_LONGINT:C283($vLen)
myDoc:=Open document:C264("")
If (OK=1)
	Repeat 
		RECEIVE PACKET:C104(myDoc; $vLoadText; 500)
		If (OK=1)
			$vLen:=BLOB size:C605($myBlob)
			TEXT TO BLOB:C554($vLoadText; $myBlob; UTF8 text without length:K22:17; $vLen)
		End if 
	Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
	If (BLOB size:C605($myBlob)<32000)
		$mySendText:=BLOB to text:C555($myBlob; 3)  //;32000)
		SET TEXT TO PASTEBOARD:C523($mySendText)
	End if 
End if 

