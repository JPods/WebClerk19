//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-13T00:00:00, 15:40:57
// ----------------------------------------------------
// Method: AlpSetRowsOpts
// Description
// Modified: 07/13/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $alpArea)  //ALP area
C_LONGINT:C283($2; $multipleSelAllowed)  //allow multiple line selection
C_LONGINT:C283($3; $noSelAllowed)  //allow no row selection
C_LONGINT:C283($4; $dragLineAllowed)  //allow drag line
C_LONGINT:C283($5; $dragFrom2NonAlpObjAllowed)  //accept drag from and to not ALP object
C_LONGINT:C283($6; $maintainOptionsRows)  //maintain row(s) option(s) during drag
C_LONGINT:C283($7; $noHightLightRow)  //disable row hightlighting

$alpArea:=$1

If (Count parameters:C259>1)
	$multipleSelAllowed:=$2
	// -- AL_SetAreaLongProperty($alpArea; ALP_Area_SelMultiple; $multipleSelAllowed)
End if 

If (Count parameters:C259>2)
	$noSelAllowed:=$3
	// -- AL_SetAreaLongProperty($alpArea; ALP_Area_SelNone; $noSelAllowed)
End if 

If (Count parameters:C259>3)
	$dragLineAllowed:=$4
	// -- AL_SetAreaLongProperty($alpArea; ALP_Area_DragLine; $dragLineAllowed)
End if 

If (Count parameters:C259>4)
	$dragFrom2NonAlpObjAllowed:=$5
	// -- AL_SetAreaLongProperty($alpArea; ALP_Area_DragAcceptLine; $dragFrom2NonAlpObjAllowed)
End if 

If (Count parameters:C259>5)
	$maintainOptionsRows:=$6
	// -- AL_SetAreaLongProperty($alpArea; ALP_Area_MoveRowOptions; $maintainOptionsRows)
End if 

If (Count parameters:C259>6)
	$noHightLightRow:=$7
	// -- AL_SetAreaLongProperty($alpArea; ALP_Area_SelNoHighlight; $noHightLightRow)
End if 
