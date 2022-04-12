//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/05/06, 21:28:12
// ----------------------------------------------------
// Method: WO_ColorNameID
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (eCntWos>0)
	C_LONGINT:C283($cntWO; $findEmployee; $incWO)
	// ### bj ### 20201213_1227 QQQ???? fix to object storage
	$cntWO:=Size of array:C274(aWoNameID)
	For ($incWO; 1; $cntWO)
		$findEmployee:=Find in array:C230(<>aNameID; aWoNameID{$incWO})
		If (($findEmployee>0) & ($findEmployee<=Size of array:C274(<>aNameColorBG)))
			If (<>aNameColorBG{$findEmployee}#<>aNameColorFG{$findEmployee})
				// -- AL_SetCellColor(eCntWos; 4; $incWO; 0; 0; aTmpInt2x1; ""; <>aNameColorFG{$findEmployee}+1; ""; <>aNameColorBG{$findEmployee}+1)  //1st element is empty
			Else 
				// -- AL_SetCellColor(eCntWos; 4; $incWO; 0; 0; aTmpInt2x1; "black"; 0; "white"; 0)  //;"";15;"";0)
			End if 
		Else 
			// -- AL_SetCellColor(eCntWos; 4; $incWO; 0; 0; aTmpInt2x1; "black"; 0; "white"; 0)  //;"";15;"";0)
		End if 
	End for 
End if 