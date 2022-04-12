myDoc:=Open document:C264(document)
If (OK=1)
	ARRAY TEXT:C222($aIncoming; 0)
	Repeat 
		$incomingText:=""
		RECEIVE PACKET:C104(myDoc; $incomingText; "\r")
		If (OK=1)
			$w:=Size of array:C274($aIncoming)
			INSERT IN ARRAY:C227($aIncoming; $w; 1)
			$aIncoming{$w}:=$incomingText
		End if 
	Until (OK=0)
End if 
$k:=Size of array:C274($aIncoming)
//If ($k<3)
// For ($i;1;$k)
