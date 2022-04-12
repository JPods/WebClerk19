//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/30/18, 11:12:39
// ----------------------------------------------------
// Method: PathToDocument
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptText)
C_TEXT:C284($path)
ARRAY TEXT:C222(aList; 0)
$path:=Select document:C905(""; ""; "Select the desired document"; Alias selection:K24:10+Multiple files:K24:7+Package open:K24:8+Package selection:K24:9; aList)
If (OK=1)
	If (Size of array:C274(aList)=1)
		If (Count parameters:C259=1)
			$1->:=$1->+("\r"*2*(Num:C11($1->="")))+$path
		Else 
			SET TEXT TO PASTEBOARD:C523($path)
			ConsoleMessage($path)
		End if 
	Else 
		$path:=""
		$k:=Size of array:C274(aList)
		C_LONGINT:C283($i; $k)
		For ($i; 1; $k)
			$path:=$path+aList{$i}+"\r"
		End for 
		If (Count parameters:C259=1)
			$1->:=$1->+("\r"*2*(Num:C11($1->#"")))+$path
		Else 
			SET TEXT TO PASTEBOARD:C523($path)
			ConsoleMessage($path)
		End if 
	End if 
End if 
