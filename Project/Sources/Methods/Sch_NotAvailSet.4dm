//%attributes = {"publishedWeb":true}
//Procedure: Sch_NotAvailSet
C_LONGINT:C283($2)  //the area
C_LONGINT:C283($sizeRay; $recSel; $increment)
$sizeRay:=Size of array:C274($1->)
$recSel:=Records in selection:C76([PeriodAvailable:74])
$increment:=3600\<>viTmIncr
For ($index; 1; $sizeRay)
	// -- AL_SetCellColor($2; 1; $index; 0; 0; aTmpInt2x1; "black"; 0; ""; (15*16)+3)
	// -- AL_SetCellColor($2; 2; $index; 0; 0; aTmpInt2x1; "black"; 0; ""; (15*16)+3)
	// -- AL_SetCellColor($2; 3; $index; 0; 0; aTmpInt2x1; "black"; 0; ""; (15*16)+3)
	// -- AL_SetCellColor($2; 4; $index; 0; 0; aTmpInt2x1; "black"; 0; ""; (15*16)+3)
End for 
FIRST RECORD:C50([PeriodAvailable:74])
For ($i; 1; $recSel)
	For ($index; 1; $sizeRay)
		If (([PeriodAvailable:74]timeBegin:2<=$1->{$index}) & ([PeriodAvailable:74]timeEnd:3>=($1->{$index}+$increment)))  //&([PeriodAvailable]TimeBegin<($1{$index}+$increment))&
			// -- AL_SetCellColor($2; 3; $index; 0; 0; aTmpInt2x1; "black"; 0; "white"; 0)
			
			// -- AL_SetCellColor($2; 1; $index; 0; 0; aTmpInt2x1; "black"; 0; "white"; 0)
			// -- AL_SetCellColor($2; 2; $index; 0; 0; aTmpInt2x1; "black"; 0; "white"; 0)
			// -- AL_SetCellColor($2; 3; $index; 0; 0; aTmpInt2x1; "black"; 0; "white"; 0)
			// -- AL_SetCellColor($2; 4; $index; 0; 0; aTmpInt2x1; "black"; 0; "white"; 0)
		End if 
	End for 
	NEXT RECORD:C51([PeriodAvailable:74])
End for 
UNLOAD RECORD:C212([PeriodAvailable:74])