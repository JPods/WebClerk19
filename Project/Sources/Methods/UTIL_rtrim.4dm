//%attributes = {}

If (Count parameters:C259=2)
	C_TEXT:C284($0; $result; $1; $2; $lastChar)
	C_BOOLEAN:C305($done)
	C_LONGINT:C283($length)
	$result:=$1
	$length:=Length:C16($1)
	$done:=False:C215
	Repeat 
		$lastChar:=Substring:C12($result; Length:C16($result); 1)
		If ($lastChar=$2)
			$result:=Substring:C12($result; 1; Length:C16($result)-1)  // remove last char
		Else 
			$done:=True:C214
		End if 
	Until ($done)
	$0:=$result
End if 