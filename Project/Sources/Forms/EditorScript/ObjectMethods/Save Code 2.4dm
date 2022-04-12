C_TEXT:C284($theText; $name; $docName; $theFile)
KeyModifierCurrent
$theText:=vTextSummary
C_LONGINT:C283($w)
$docName:=""
TRACE:C157
If (Length:C16($theText)=0)
	ALERT:C41("Select script to capture.")
Else 
	$w:=Position:C15(<>vCR; $theText)
	If (($w>20) | ($w=0))
		$w:=20
	End if 
	If (CmdKey=1)
		$docName:=Request:C163("Name of Catagory"; Substring:C12($theText; 1; $w))
		$p:=Position:C15("."; $docName)
		If ($p>2)
			$docName:=Substring:C12($docName; 1; $p-1)
		End if 
	End if 
	$name:=Request:C163("Name of Script"; Substring:C12($theText; 1; $w))
	If ((OK=1) & ($name#""))
		OK:=0
		If ($docName#"")
			$theFile:=<>jitPrefPath+"P_"+$docName+".txt"
			If (HFS_Exists($theFile)=0)
				myDoc:=Create document:C266($theFile; "")
				$w:=Size of array:C274(aiLoText4)+1
				INSERT IN ARRAY:C227(aiLoText4; $w; 1)
				aiLoText4:=$w
				aiLoText4{aiLoText4}:=$docName
				ARRAY TEXT:C222(aiLoText1; 1)
				ARRAY TEXT:C222(aiLoText2; 1)
				ARRAY TEXT:C222(aiLoText3; 1)
				aiLoText1{1}:=$name
				aiLoText2{1}:=$theText
				aiLoText3{1}:=""
			Else 
				myDoc:=Append document:C265($theFile)
			End if 
		Else 
			$w:=Size of array:C274(aiLoText1)+1
			INSERT IN ARRAY:C227(aiLoText1; $w; 1)
			INSERT IN ARRAY:C227(aiLoText2; $w; 1)
			INSERT IN ARRAY:C227(aiLoText3; $w; 1)
			aiLoText1{$w}:=$name
			aiLoText2{$w}:=$theText
			aiLoText3{$w}:=""
			$theFile:=<>jitPrefPath+"P_"+ailoText4{ailoText4}+".txt"
			If (HFS_Exists($theFile)=1)
				myDoc:=Append document:C265($theFile)
			End if 
		End if 
		If (OK=1)
			$theText:=Replace string:C233($theText; <>vCR; "~")
			SEND PACKET:C103(myDoc; $name+<>vTab+$theText+<>vTab+<>vCR)
			CLOSE DOCUMENT:C267(myDoc)
		End if 
		//Tx_ListIn (<>jitPrefPath+"P_"+aiLoText4{aiLoText4}+".txt")
		
	End if 
End if 