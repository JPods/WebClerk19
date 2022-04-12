//%attributes = {"publishedWeb":true}
myDoc:=Open document:C264("")
If (OK=1)
	TRACE:C157
	C_TEXT:C284($paRecord)
	C_LONGINT:C283($p; $theCount)
	ARRAY TEXT:C222($myText; 0)
	RECEIVE PACKET:C104(myDoc; $paRecord; "\r")
	$theCount:=0
	Repeat 
		$p:=Position:C15("\t"; $paRecord)
		$theCount:=$theCount+1
		If ($p>0)
			INSERT IN ARRAY:C227($myText; $theCount)
			$myText{$theCount}:=Substring:C12($paRecord; 1; $p-1)
			$paRecord:=Substring:C12($paRecord; $p+1)
			$p:=Position:C15("\t"; $paRecord)
		End if 
	Until ($p=0)
	INSERT IN ARRAY:C227($myText; $theCount)
	$myText{$theCount}:=$paRecord
	$theCount:=$theCount-1
	//Repeat 
	For ($i; 1; $theCount)
		RECEIVE PACKET:C104(myDoc; $myText{$i}; "\t")
	End for 
	RECEIVE PACKET:C104(myDoc; $myText{$theCount+1}; "\r")
	//Until (OK=0)
	CLOSE DOCUMENT:C267(myDoc)
End if 