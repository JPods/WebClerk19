//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: FormatFillArrays
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

C_TEXT:C284($proInsert; $proReason)
ARRAY TEXT:C222(<>aFormatTemplates; 0)
ARRAY TEXT:C222(<>aFormatReals; 0)
$theFile:=Storage:C1525.folder.jitPrefPath+"RealFormats.txt"
If (HFS_Exists($theFile)=1)
	myDoc:=Open document:C264($theFile; "")
	If (OK=1)
		While (OK=1)
			RECEIVE PACKET:C104(myDoc; $styleName; "\t")
			RECEIVE PACKET:C104(myDoc; $styleFormat; "\r")
			If (OK=1)
				$w:=Size of array:C274(<>aFormatTemplates)+1
				INSERT IN ARRAY:C227(<>aFormatTemplates; $w; 1)
				INSERT IN ARRAY:C227(<>aFormatReals; $w; 1)
				<>aFormatTemplates{$w}:=$styleName
				<>aFormatReals{$w}:=$styleFormat
			End if 
		End while 
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 