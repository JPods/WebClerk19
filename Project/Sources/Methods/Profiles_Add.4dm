//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/21/18, 09:07:46
// ----------------------------------------------------
// Method: Profiles_Add
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($selected; $viAreaList; $1)

$viAreaList:=$1

If ((viVert<=0) | (viVert>Records in selection:C76([Profile:59])))
	viVert:=1
End if 
viVert:=Records in selection:C76([Profile:59])+1

CREATE RECORD:C68([Profile:59])

viTableNum:=Table:C252(ptCurTable)
viFieldNum:=STR_GetUniqueFieldNum(Table name:C256(viTableNum))
vpField:=Field:C253(viTableNum; viFieldNum)
viType:=Type:C295(vpField->)
If (viType=Is longint:K8:6)
	vtDocAlphaID:=String:C10(vpField->)
Else 
	vtDocAlphaID:=vpField->
End if 

viResult:=AddProfile(viTableNum; vtDocAlphaID; ""; "")

QUERY:C277([Profile:59]; [Profile:59]tableNum:1=viTableNum; *)
QUERY:C277([Profile:59]; [Profile:59]idForeign:3=vtDocAlphaID; *)
QUERY:C277([Profile:59])

//  --  CHOPPED  AL_UpdateArrays($viAreaList; -2)
// -- AL_SetLine($viAreaList; viVert)
// -- AL_SetScroll($viAreaList; viVert; viHorz)
GOTO OBJECT:C206($viAreaList)
//  --  CHOPPED  AL_GotoCell($viAreaList; viVert; viHorz)