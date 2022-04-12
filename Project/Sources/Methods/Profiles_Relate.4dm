//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/22/18, 12:56:58
// ----------------------------------------------------
// Method: Profiles_Relate
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($areaList; $1)

$areaList:=$1


If (Is new record:C668(ptCurTable->))
	REDUCE SELECTION:C351([Profile:59]; 0)
Else 
	viTableNum:=Table:C252(ptCurTable)
	vpField:=STR_GetUniqueFieldPointer(Table name:C256(viTableNum))
	viType:=Type:C295(vpField->)
	If (viType=Is longint:K8:6)
		vtDocAlphaID:=String:C10(vpField->)
	Else 
		vtDocAlphaID:=vpField->
	End if 
	READ WRITE:C146([Profile:59])
	
End if 

