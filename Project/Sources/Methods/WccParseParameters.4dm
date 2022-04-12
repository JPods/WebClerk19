//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccParseParameters 
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 

C_TEXT:C284($1)
C_LONGINT:C283($0)
C_TEXT:C284($workText; $inText; $outText; $vtCommand; $vtValue)
C_LONGINT:C283($p; $pEnd; $w; $k; $i; $pEqual; $pSpace)

ARRAY TEXT:C222(atParaName; 0)
ARRAY TEXT:C222(atParaValue; 0)
$workText:=$1
Repeat 
	// find the division between the parameter and its value
	$pEqual:=Position:C15("="; $workText)
	If ($pEqual>0)
		// clip command from working into a workable string
		$vtCommand:=Substring:C12($workText; 1; $pEqual-1)
		// clip command from working
		$workText:=Substring:C12($workText; $pEqual+1)
		// put working into a value to be parsed
		$vtValue:=$workText
		// trim
		$viLastSpace:=Txt_GetLastSpace($vtCommand)
		If ($viLastSpace>0)
			$vtCommand:=Substring:C12($vtCommand; $viLastSpace+1)
		End if 
		$vtValue:=Txt_TweenReturn($vtValue; "\""; "\"")
		APPEND TO ARRAY:C911(atParaName; $vtCommand)
		APPEND TO ARRAY:C911(atParaValue; $vtValue)
	End if 
Until ($pEqual=0)

$0:=Size of array:C274(atParaName)

