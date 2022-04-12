//%attributes = {"publishedWeb":true}
C_TEXT:C284($tempStr)
C_LONGINT:C283($i; $k)
C_BOOLEAN:C305($doArray)
$doArray:=False:C215
$k:=Size of array:C274(aRayLines)
For ($i; 1; $k)
	GOTO RECORD:C242([Order:3]; aOrdRecs{aRayLines{$i}})
	If (v11#[Order:3]actionBy:55)
		$tempStr:="Order Assigned to "+v11+"."
		[Order:3]actionBy:55:=v11
		// zzzqqq jDateTimeStamp(->[Order:3]commentProcess:12; $tempStr)
		[Order:3]dtProdRelease:56:=DateTime_Enter
		SAVE RECORD:C53([Order:3])
		aOrdNames{aRayLines{$i}}:=v11
		$doArray:=True:C214
	End if 
End for 
HIGHLIGHT TEXT:C210(v8; 1; 25)
If ($doArray)
	vDate3:=Current date:C33
	vTime3:=Current time:C178
	//  CHOPPED  AL_GetScroll(eOpenOrds; viVert; viHorz)
	//  --  CHOPPED  AL_UpdateArrays(eOpenOrds; -2)
	// -- AL_SetSelect(eOpenOrds; aRayLines)
	// -- AL_SetScroll(eOpenOrds; viVert; viHorz)
End if 