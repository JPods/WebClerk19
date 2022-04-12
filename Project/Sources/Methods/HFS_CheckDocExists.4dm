//%attributes = {"publishedWeb":true}
//Method: // zzzqqq HFS_CheckDocExists
C_TEXT:C284($1)
If (HFS_Exists($1)=0)
	ALERT:C41("Doc "+$1+"\r"+" does not exist.")
End if 