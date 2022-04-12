//%attributes = {"invisible":true,"shared":true}
// CodeAnalysis_GetAssetInfo (selector; ptr1; ptr2)
// CodeAnalysis_GetAssetInfo (text; pointer; pointer)
//
// DESCRIPTION
//   This method is called by the Code Analysis component
//   to fetch information from the host structure.
//   These calls must all be called from the host structure.
//
C_TEXT:C284($1; $vt_selector)
C_POINTER:C301($2; $vp_pointer1)
C_POINTER:C301($3; $vp_pointer2)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (06/26/2013)
// ----------------------------------------------------

If (Asserted:C1132((Count parameters:C259=3) | (Count parameters:C259=2); "Expected 2 or 3 parameters"))
	$vt_selector:=$1
	$vp_pointer1:=$2
	If (Count parameters:C259=3)
		$vp_pointer2:=$3
	End if 
	
	Case of 
		: ($vt_selector="MethodVersion")
			$vp_pointer1->:=1
			
		: ($vt_selector="GetListOfPicts")
			PICTURE LIBRARY LIST:C564($vp_pointer1->; $vp_pointer2->)
			
		: ($vt_selector="GetPict")
			GET PICTURE FROM LIBRARY:C565($vp_pointer1->; $vp_pointer2->)
			
		: ($vt_selector="GetListOfLists")
			LIST OF CHOICE LISTS:C957($vp_pointer1->; $vp_pointer2->)
			
		: ($vt_selector="GetList")
			$vp_pointer2->:=Load list:C383($vp_pointer1->)
			
		: ($vt_selector="GetListOfProjectForms")
			FORM GET NAMES:C1167($vp_pointer1->)
			
		: ($vt_selector="GetListOfTableForms")
			FORM GET NAMES:C1167(Table:C252($vp_pointer1->)->; $vp_pointer2->)
			
		: ($vt_selector="GetFormProperties")
			C_LONGINT:C283($vl_tableNo; $vl_formWidth; $vl_formHeight; $vl_numPages)
			C_BOOLEAN:C305($vb_formFixedWidth; $vb_formFixedHeight)
			C_TEXT:C284($vt_formName; $vt_title)
			
			$vl_tableNo:=$vp_pointer1->
			$vt_formName:=$vp_pointer2->
			
			If ($vl_tableNo>0)  // Is this a table form or a project form?
				FORM GET PROPERTIES:C674(Table:C252($vl_tableNo)->; $vt_formName; $vl_formWidth; $vl_formHeight; $vl_numPages; $vb_formFixedWidth; $vb_formFixedHeight; $vt_title)
			Else 
				FORM GET PROPERTIES:C674($vt_formName; $vl_formWidth; $vl_formHeight; $vl_numPages; $vb_formFixedWidth; $vb_formFixedHeight; $vt_title)
			End if 
			
			// Pack the results into a result
			$vp_pointer2->:=String:C10($vl_formWidth)+"\t"+String:C10($vl_formHeight)+"\t"+String:C10($vl_numPages)+"\t"
			$vp_pointer2->:=$vp_pointer2->+Choose:C955($vb_formFixedWidth; "True"; "False")+"\t"
			$vp_pointer2->:=$vp_pointer2->+Choose:C955($vb_formFixedHeight; "True"; "False")+"\t"
			$vp_pointer2->:=$vp_pointer2->+$vt_title
	End case 
	
	
	
	
End if 


