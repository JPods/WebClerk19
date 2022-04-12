//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/01/20, 19:27:04
// ----------------------------------------------------
// Method: do_Capitalize
// Description
// ORDA
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($1; $entity)
C_TEXT:C284($name)
$entity:=$1
$name:=$entity.nameLast
If (Not:C34($name=Null:C1517))
	Case of 
		: ($name[[2]]=".")
			// do nothing
		Else 
			$name:=Uppercase:C13($name[[1]])+Lowercase:C14(Substring:C12($name; 2))
	End case 
End if 
$entity.nameLast:=$name