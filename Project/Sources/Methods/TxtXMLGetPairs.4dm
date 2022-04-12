//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-14T00:00:00, 20:04:15
// ----------------------------------------------------
// Method: TxtXMLGetPairs
// Description
// Modified: 11/14/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $workingText)
C_LONGINT:C283($0)
$0:=1
//
TextToArray($1; ->aText3; "\r")
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aText3)
If ($k=0)
	$0:=-1
Else 
	ARRAY TEXT:C222(aXMLReceived; $k)
	ARRAY TEXT:C222(aXMLMatched; $k)
	ARRAY POINTER:C280(aXMLFieldPointer; $k)
	ARRAY TEXT:C222(aXMLType; $k)
	For ($i; 1; $k)
		TextToArray(aText3{$i}; ->aText4; "\r")
		If (Size of array:C274(aText4)#5)
			ALERT:C41("Error in XML template "+aText3{$i})
			$0:=-1
			$i:=$k
		Else 
			aXMLReceived{$i}:=aText4{1}
			aXMLMatched{$i}:=aText4{2}
			aXMLFieldPointer{$i}:=Field:C253(Num:C11(aText4{3}); Num:C11(aText4{4}))
			aXMLType{$i}:=aText4{5}
		End if 
	End for 
End if 
//