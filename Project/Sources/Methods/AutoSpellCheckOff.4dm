//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/21/14, 20:44:09
// ----------------------------------------------------
// Method: AutoSpellCheckOff
// Description
// 
//
// Parameters
// ----------------------------------------------------
// move to form method and do all pages
// ### jwm ### 20141002_1135



ARRAY TEXT:C222(objArray; 0)
ARRAY POINTER:C280(ptrArray; 0)
ARRAY LONGINT:C221(aiPage; 0)
C_LONGINT:C283(index)

// FORM GET OBJECTS(objArray;ptrArray;aiPage;*) * = current page
FORM GET OBJECTS:C898(objArray; ptrArray; aiPage)

For (index; 1; Size of array:C274(ptrArray))
	
	If ((Type:C295(objArray{index})=Is alpha field:K8:1) | (Type:C295(objArray{index})=Is string var:K8:2) | (Type:C295(objArray{index})=Is text:K8:3))
		//MESSAGE(objArray{index})
		OBJECT SET AUTO SPELLCHECK:C1173(*; objArray{index}; False:C215)
	End if 
	
End for 

