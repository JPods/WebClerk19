//%attributes = {}
// Method: FORM_GET_PAGE_OBJECTS
// Description
// Returns the list of all objects present in
// a specific form page
//
// Parameters
// $1 - Pointer to a Text array
// $2 - Pointer to a Pointer array
// $3 - Pointer to a Longint array
// $4 - (Optional) Page number or current page if omitted
// ----------------------------------------------------

C_POINTER:C301($1; $object_atp)
C_POINTER:C301($2; $variable_app)
C_POINTER:C301($3; $page_alp)
C_LONGINT:C283($4; $curPage_l)
C_LONGINT:C283($foundat_l)

If (Count parameters:C259>=3)
	$object_atp:=$1
	$variable_app:=$2
	$page_alp:=$3
	If (Count parameters:C259>=4)
		$curPage_l:=$4
	Else 
		$curPage_l:=FORM Get current page:C276
	End if 
	
	ARRAY TEXT:C222(object_at; 0)
	ARRAY POINTER:C280(variable_ap; 0)
	ARRAY LONGINT:C221(page_al; 0)
	FORM GET OBJECTS:C898(object_at; variable_ap; page_al)
	
	Repeat 
		$foundat_l:=$foundat_l+1
		$foundat_l:=Find in array:C230(page_al; $curPage_l; $foundat_l)
		If ($foundat_l#-1)
			APPEND TO ARRAY:C911($object_atp->; object_at{$foundat_l})
			APPEND TO ARRAY:C911($variable_app->; variable_ap{$foundat_l})
			APPEND TO ARRAY:C911($page_alp->; page_al{$foundat_l})
		End if 
	Until ($foundat_l=-1)
End if 