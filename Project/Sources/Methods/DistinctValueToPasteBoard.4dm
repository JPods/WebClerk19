//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-14T00:00:00, 19:14:46
// ----------------------------------------------------
// Method: DistinctValueToPasteBoard
// Description
// Modified: 08/14/17
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $ptField)

//  C_LONGINT($typeField;$lenField;$numField)
// C_BOOLEAN($indexed;$isUnique;$isInvisible)

ArrayDistinct($1)
Case of 
	: (Type:C295($ptField->)=Is longint:K8:6)
		vi2:=Size of array:C274(aLDistinct)
		vText1:=""
		For (vi1; 1; vi2)
			vText1:=vText1+String:C10(aLDistinct{vi1})+"\r"
		End for 
		ALERT:C41("Values are available in array: atDistinct: "+String:C10(Size of array:C274(aLDistinct)))
	: (Type:C295($ptField->)=Is alpha field:K8:1)
		vi2:=Size of array:C274(atDistinct)
		vText1:=""
		For (vi1; 1; vi2)
			vText1:=vText1+atDistinct{vi1}+"\r"
		End for 
	Else 
		vText1:="Not a text or longint field"
		ALERT:C41("Values are available in array: atDistinct: "+String:C10(Size of array:C274(atDistinct)))
End case 
SET TEXT TO PASTEBOARD:C523(vText1)
