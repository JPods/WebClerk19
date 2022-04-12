//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/04/20, 21:27:20
// ----------------------------------------------------
// Method: jsonArraytoText
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($0; $vtBuild)
vi2:=Size of array:C274($1->)
For (vi1; 1; vi2)
	$vtBuild:=$vtBuild+"['"+$1->{vi1}+"','"+$1->{vi1}+"']"
	If (vi1<vi2)
		$vtBuild:=$vtBuild+","
	End if 
End for 
$0:=$vtBuild

If (False:C215)
	vText10:=""
	vi2:=Size of array:C274(aText10)
	For (vi1; 1; vi2)
		vText10:=vText10+"['"+aText10{vi1}+"','"+aText10{vi1}+"']"
		If (vi1<vi2)
			vText10:=vText10+","
		End if 
	End for 
End if 