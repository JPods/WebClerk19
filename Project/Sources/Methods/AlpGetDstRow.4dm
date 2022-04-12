//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-15T00:00:00, 15:56:35
// ----------------------------------------------------
// Method: AlpGetDstRow
// Description
// Modified: 07/15/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $alpArea)  //ALP area
C_POINTER:C301($2)  //Row number in area that was dragged to

C_LONGINT:C283($error)

$alpArea:=$1

//  CHOPPED  $error:=AL_GetAreaPtrProperty($alpArea; ALP_Area_DragDstRow; $2)
