//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-13T00:00:00, 10:28:24
// ----------------------------------------------------
// Method: ALPGetDragLine
// Description
// Modified: 07/13/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $alpArea)  //ALP area
C_POINTER:C301($2)  //Drag row number
C_POINTER:C301($3)  //Drop row number
C_POINTER:C301($4)  //Drop area
C_LONGINT:C283($error)

$alpArea:=$1

//  CHOPPED  $error:=AL_GetAreaPtrProperty($alpArea; ALP_Area_DragSrcRow; $2)

If (Count parameters:C259>2)
	//  CHOPPED  $error:=AL_GetAreaPtrProperty($alpArea; ALP_Area_DragDstRow; $3)
End if 

If (Count parameters:C259>3)
	//  CHOPPED  $error:=AL_GetAreaPtrProperty($alpArea; ALP_Area_DragDstArea; $4)
End if 