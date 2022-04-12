//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-07-19T00:00:00, 14:42:43
// ----------------------------------------------------
// Method: Util_UniqueToArray
// Description
// Modified: 07/19/15
// Structure: CEv13_131005
// 
//
// Parameters
// $1 text to process
// $2 pointer to the array of unique values
// ----------------------------------------------------


C_TEXT:C284($1; $theText)
C_POINTER:C301($2; $ptArrayUnique)
C_TEXT:C284($3; $output; $dataOut)
ARRAY TEXT:C222($aTextValues; 0)
ARRAY TEXT:C222($aUniqueText; 0)
ARRAY LONGINT:C221($aUniqueNumbers; 0)

If (Count parameters:C259>1)
	$theText:=$1
	$ptArrayUnique:=$2
	$output:=$3
Else 
	$theText:=Get text from pasteboard:C524
	$ptArrayUnique:=(->$aUniqueText)
	$output:="clipboard"
End if 
C_LONGINT:C283($typeArray)
$typeArray:=Type:C295($ptArrayUnique)
$dataOut:=""
// clean up the text data
$theText:=Replace string:C233($theText; "; "; ",")
$theText:=Replace string:C233($theText; "; "; ",")
$theText:=Replace string:C233($theText; " "; ",")
ARRAY TEXT:C222(aLoScripts20; 0)
TextToArray($theText; ->aLoScripts20)
COPY ARRAY:C226(aLoScripts20; $aTextValues)
ARRAY TEXT:C222(aLoScripts20; 0)
C_LONGINT:C283($theNumber; $w; $i; $k)

If ($typeArray=LongInt array:K8:19)
	C_LONGINT:C283($theNumber; $w)
	$k:=Size of array:C274($aTextValues)
	For ($i; 1; $k)
		$theNumber:=Num:C11($aTextValues{$i})
		$w:=Find in array:C230($aUniqueNumbers; $theNumber)
		If ($w=-1)
			APPEND TO ARRAY:C911($aUniqueNumbers; $theNumber)
			$dataOut:=$dataOut+"\r"+String:C10($theNumber)
		End if 
	End for 
	COPY ARRAY:C226($aUniqueNumbers; $ptArrayUnique->)
Else 
	$k:=Size of array:C274($aTextValues)
	For ($i; 1; $k)
		$w:=Find in array:C230($aUniqueText; $aTextValues{$i})
		If ($w=-1)
			APPEND TO ARRAY:C911($aUniqueText; $aTextValues{$i})
			$dataOut:=$dataOut+"\r"+$aTextValues{$i}
		End if 
	End for 
	COPY ARRAY:C226($aUniqueText; $ptArrayUnique->)
End if 

Case of 
	: ($output="clipboard")
		SET TEXT TO PASTEBOARD:C523($dataOut)
	: (($output="") | ($output="array"))
		// already copied to this
	Else 
		
		
End case 

