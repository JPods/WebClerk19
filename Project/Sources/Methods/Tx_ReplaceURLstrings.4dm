//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/14/18, 16:54:37
// ----------------------------------------------------
// Method: Tx_ReplaceURLstrings
// Description
// 
//This can be used for more than URLs, but that is the framework in which it was created
// Parameters
//  need to replace nothing, / ./ ../ with a URL 
// ----------------------------------------------------




C_TEXT:C284($0; $1; $starting; $working; $output; $2; $findString; $3; $endstring; $4; $replaceWith; $5; $replaceWhat)

If (Count parameters:C259=0)
	
Else 
	$starting:=$1  // for testing
	$working:=$1
	$findString:=$2
	$endstring:=$3
	$replaceWith:=$4  // set to "nofile" if the path is to be generalized to ./images...
	If (Count parameters:C259>4)
		$replaceWhat:=$5
	Else 
		$replaceWhat:="/,./,../"
	End if 
	ARRAY TEXT:C222($atReplaceWhat; 0)
End if 
$replaceWhat:=Replace string:C233($replaceWhat; ";"; ",")
TextToArray($replaceWhat; ->$atReplaceWhat; ",")

C_TEXT:C284($targetToWork)

$output:=""
C_LONGINT:C283($foundStart; $foundEnd; $foundLast)
C_LONGINT:C283($lengthFind)
C_LONGINT:C283($didNotFind)
C_LONGINT:C283($huntingLength)

$lengthFind:=Length:C16($findString)  // "src=\""
$foundLast:=0
Repeat 
	$foundStart:=Position:C15($findString; $working)
	If ($foundStart<1)
		$output:=$output+$working
		$working:=""
	Else 
		$foundLast:=$foundStart+1  // move past the find
		// will likely clip and not need this
		$output:=$output+Substring:C12($working; 1; $foundStart-1)+$findString  // send out clear part
		$working:=Substring:C12($working; $foundStart+$lengthFind)
		$foundLast:=Position:C15($endstring; $working)
		If ($foundLast>0)
			$targetToWork:=Substring:C12($working; 1; $foundLast-1)
			$working:=Substring:C12($working; $foundLast)  // clip the working while leaving the end delimiter
			C_LONGINT:C283($foundImages)
			$foundImages:=Position:C15("images/"; $targetToWork)
			If ($foundImages>0)
				If ($replaceWith="nofile")
					$targetToWork:="./"+Substring:C12($targetToWork; $foundImages)
				Else 
					$targetToWork:=Substring:C12($targetToWork; $foundImages+7)
					If ($targetToWork="/@")
						$targetToWork:=Substring:C12($targetToWork; 2)
					Else 
						If ($targetToWork="./@")
							$targetToWork:=Substring:C12($targetToWork; 3)
						End if 
					End if 
					$targetToWork:=$replaceWith+$targetToWork
				End if 
			End if 
		Else 
			$output:=$output+$working  // not found so dump the rest of the document
			$working:=""
		End if 
		$output:=$output+$targetToWork
	End if 
Until ($working="")
$0:=$output

