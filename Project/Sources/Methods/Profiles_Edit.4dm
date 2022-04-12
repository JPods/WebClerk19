//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/22/18, 12:47:38
// ----------------------------------------------------
// Method: Profiles_Edit
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($selected; $sizeRay; $theline; $err)
C_POINTER:C301($ptCurTable)
C_LONGINT:C283($viAreaList; $1)
$viAreaList:=$1


GOTO SELECTED RECORD:C245([Profile:59]; $selected)
Ref:=Open form window:C675([Profile:59]; "Input"; Movable form dialog box:K39:8; *)
MODIFY RECORD:C57([Profile:59])

ptCurTable:=$ptCurTable  // restore pointer to working table
iLoPagePopUpMenuBar(ptCurTable)  // reload menus
jSetAutoReMenus
aPages:=$aPages  // restore page selection

Profiles_Relate($viAreaList)

//  --  CHOPPED  AL_UpdateArrays($viAreaList; -2)
// -- AL_SetLine($viAreaList; viVert)
// -- AL_SetScroll($viAreaList; viVert; viHorz)

// -- AL_SetLine($viAreaList; viVert)
// -- AL_SetScroll($viAreaList; viVert; viHorz)
GOTO OBJECT:C206($viAreaList)
//AL_GotoCell($viAreaList; viVert; viHorz)