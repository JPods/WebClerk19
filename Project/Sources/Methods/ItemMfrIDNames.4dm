//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/27/06, 10:07:10
// ----------------------------------------------------
// Method: ItemmfrIDNames
// Description
// 
//
// Parameters
// ----------------------------------------------------


ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText2; 0)

vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	$w:=Find in array:C230(aText1; [Item:4]mfrName:91)
	If ($w<0)
		INSERT IN ARRAY:C227(aText1; 1; 1)
		INSERT IN ARRAY:C227(aText2; 1; 1)
		aText1{1}:=[Item:4]mfrName:91
		aText2{1}:=[Item:4]mfrID:53
	Else 
		$w:=Find in array:C230(aText2; [Item:4]mfrID:53)
		If ($w<0)
			INSERT IN ARRAY:C227(aText1; 1; 1)
			INSERT IN ARRAY:C227(aText2; 1; 1)
			aText1{1}:=[Item:4]mfrName:91
			aText2{1}:=[Item:4]mfrID:53
		End if 
	End if 
	NEXT RECORD:C51([Item:4])
End for 
SORT ARRAY:C229(aText1; aText2)
vi2:=Size of array:C274(aText1)
C_TEXT:C284(vText8)
For (vi1; 1; vi2)
	vText8:=vText8+aText1{vi1}+"\t"+aText2{vi1}+"\r"
End for 

SET TEXT TO PASTEBOARD:C523(vText8)


If (False:C215)
	ARRAY TEXT:C222($arrayText1; 0)
	ARRAY TEXT:C222($arrayText2; 0)
	
	$k:=Records in selection:C76([Item:4])
	FIRST RECORD:C50([Item:4])
	For ($i; 1; $k)
		$w:=Find in array:C230($arrayText1; [Item:4]mfrName:91)
		If ($w<1)
			INSERT IN ARRAY:C227($arrayText1; 1; 1)
			INSERT IN ARRAY:C227($arrayText2; 1; 1)
			$arrayText1{1}:=[Item:4]mfrName:91
			$arrayText2{1}:=[Item:4]mfrID:53
		Else 
			$w:=Find in array:C230($arrayText2; [Item:4]mfrID:53)
			If ($w<0)
				INSERT IN ARRAY:C227($arrayText1; 1; 1)
				INSERT IN ARRAY:C227($arrayText2; 1; 1)
				$arrayText1{1}:=[Item:4]mfrName:91
				$arrayText2{1}:=[Item:4]mfrID:53
				
			End if 
		End if 
		NEXT RECORD:C51([Item:4])
	End for 
	SORT ARRAY:C229($arrayText1; $arrayText2)
	$k:=Size of array:C274($arrayText1)
	C_TEXT:C284($theResult)
	For ($i; 1; $k)
		$theResult:=$theResult+$arrayText1{$i}+"\t"+$arrayText2{$i}+"\r"
	End for 
	
	SET TEXT TO PASTEBOARD:C523($theResult)
End if 