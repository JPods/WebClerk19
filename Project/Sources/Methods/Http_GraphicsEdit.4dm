//%attributes = {"publishedWeb":true}
CLEAR VARIABLE:C89(vPict1)
CLEAR VARIABLE:C89(vPict2)
CLEAR VARIABLE:C89(vPict3)
CLEAR VARIABLE:C89(vPict4)
CLEAR VARIABLE:C89(vPict5)
C_PICTURE:C286(vPict1; vPict2; vPict3; vPict4; vPict5)
C_BLOB:C604($loadBlob)
C_LONGINT:C283($err)
C_TEXT:C284($testFolder; $theDoc)
$testFolder:=<>WebFolder+"jitimages"+Folder separator:K24:12
$theDoc:=$testFolder+"Logo_Nav.gif"
TRACE:C157
If (HFS_Exists($theDoc)=1)
	DOCUMENT TO BLOB:C525($theDoc; $loadBlob)
	BLOB TO PICTURE:C682($loadBlob; vPict1)
End if 
$theDoc:=$testFolder+"Logo_Main.gif"
If (HFS_Exists($theDoc)=1)
	DOCUMENT TO BLOB:C525($theDoc; $loadBlob)
	BLOB TO PICTURE:C682($loadBlob; vPict2)
End if 
$theDoc:=$testFolder+"Logo_Splash.gif"
If (HFS_Exists($theDoc)=1)
	DOCUMENT TO BLOB:C525($theDoc; $loadBlob)
	BLOB TO PICTURE:C682($loadBlob; vPict3)
End if 
$theDoc:=$testFolder+"BkGrd_Nav_V.gif"
If (HFS_Exists($theDoc)=1)
	DOCUMENT TO BLOB:C525($theDoc; $loadBlob)
	BLOB TO PICTURE:C682($loadBlob; vPict4)
End if 
$theDoc:=$testFolder+"BkGrd_Main.gif"
If (HFS_Exists($theDoc)=1)
	DOCUMENT TO BLOB:C525($theDoc; $loadBlob)
	BLOB TO PICTURE:C682($loadBlob; vPict5)
End if 
FORM NEXT PAGE:C248