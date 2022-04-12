//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/06/20, 08:38:04
// ----------------------------------------------------
// Method: ds_TestingSub
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($1)
C_TEXT:C284($2; $vtTask)

$vtTask:=$2

Case of 
	: ($vtTask="Capitalize")
		$entity:=$1
		$name:=$entity.LastName
		If (Not:C34($name=Null:C1517))
			$name:=Uppercase:C13(Substring:C12($name; 1; 1))+Lowercase:C14(Substring:C12($name; 2))
		End if 
		$entity.lastname:=$name
End case 