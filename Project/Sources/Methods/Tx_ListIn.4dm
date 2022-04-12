//%attributes = {"publishedWeb":true}
//Procedure: Tx_ListIn

C_TEXT:C284($1)

C_TEXT:C284($theFile; $proName; $proInsert; $proReason)
ARRAY TEXT:C222(ailoText1; 0)
ARRAY TEXT:C222(ailoText2; 0)
ARRAY TEXT:C222(ailoText3; 0)
$theFile:=$1
If (HFS_Exists($theFile)=1)
	myDoc:=Open document:C264($theFile; "")
	If (OK=1)
		While (OK=1)
			RECEIVE PACKET:C104(myDoc; $proName; "\t")
			RECEIVE PACKET:C104(myDoc; $proInsert; "\t")
			RECEIVE PACKET:C104(myDoc; $proReason; "\r")
			If (OK=1)
				$w:=Size of array:C274(ailoText1)+1
				INSERT IN ARRAY:C227(ailoText1; $w; 1)
				INSERT IN ARRAY:C227(ailoText2; $w; 1)
				INSERT IN ARRAY:C227(ailoText3; $w; 1)
				ailoText1{$w}:=$proName
				ailoText2{$w}:=Replace string:C233($proInsert; "~"; "\r")
				ailoText3{$w}:=$proReason
			End if 
		End while 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
Else 
	ALERT:C41($1+" file is missing.")
	INSERT IN ARRAY:C227(ailoText1; 1; 1)
	INSERT IN ARRAY:C227(ailoText2; 1; 1)
	INSERT IN ARRAY:C227(ailoText3; 1; 1)
	ailoText1{1}:="missing file"
	ailoText2{1}:="missing value"
	ailoText3{1}:="missing explanation"
End if 