//%attributes = {"publishedWeb":true}
C_TEXT:C284($tempStr)
C_LONGINT:C283($i; $k)
C_BOOLEAN:C305($doArray)
$k:=Size of array:C274(aRayLines)
$doArray:=False:C215
For ($i; 1; $k)
	GOTO RECORD:C242([Order:3]; aOrdRecs{aRayLines{$i}})
	If (v8#[Order:3]status:59)
		$tempStr:="Status changed to "+v8+"."
		Case of 
			: (([Order:3]status:59="Completed") & ([Order:3]status:59#v8))
				[Order:3]dtProdCompl:57:=0  //DateTime_Enter (!00/00/00!;00:00:00)
			: (v8="Completed")
				[Order:3]dtProdCompl:57:=DateTime_Enter
		End case 
		[Order:3]status:59:=v8
		// zzzqqq jDateTimeStamp(->[Order:3]commentProcess:12; $tempStr)
		SAVE RECORD:C53([Order:3])
		aOrdStatus{aRayLines{$i}}:=v8
		$doArray:=True:C214
	End if 
End for 
If ($doArray)
	vTime3:=Current time:C178
	vDate3:=Current date:C33
	//  CHOPPED  AL_GetScroll(eOpenOrds; viVert; viHorz)
	//  --  CHOPPED  AL_UpdateArrays(eOpenOrds; -2)
	// -- AL_SetSelect(eOpenOrds; aRayLines)
	// -- AL_SetScroll(eOpenOrds; viVert; viHorz)
End if 