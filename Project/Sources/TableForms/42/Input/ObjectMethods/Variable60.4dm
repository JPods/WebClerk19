C_LONGINT:C283($error; $columnCnt; $grp1; $grpCnt1; $grp2; $grpCnt2; $grp3; $grpCnt3)
$grp1:=1  //starting array
$grpCnt1:=12  //count of arrays
$grp2:=$grp1+$grpCnt1  //9
$grpCnt2:=14
$grp3:=$grp2+$grpCnt2  //21
$grpCnt3:=14
If (bRecByChang=1)
	// -- AL_SetWidths(ePropList; $grp1; $grpCnt1; 93; 3; 48; 32; 15; 3; 104; 15; 63; 34; 3; 85)
Else 
	// -- AL_SetWidths(ePropList; $grp1; $grpCnt1; 93; 3; 48; 3; 15; 3; 138; 15; 63; 34; 3; 85)
	//// -- AL_SetWidths (ePropList;$grp1;$grpCnt1;74;3;44;3;12;3;118;12;52;27;3;71)
End if 
// -- AL_SetWidths(ePropList; $grp2; $grpCnt2; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 54)
// -- AL_SetWidths(ePropList; $grp3; $grpCnt3; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50)
//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)