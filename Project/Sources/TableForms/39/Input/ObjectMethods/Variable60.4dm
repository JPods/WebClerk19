C_LONGINT:C283($error; $columnCnt; $grp1; $grpCnt1; $grp2; $grpCnt2; $grp3; $grpCnt3)
$grp1:=1  //starting array
$grpCnt1:=12  //count of arrays
$grp2:=$grp1+$grpCnt1  //9
$grpCnt2:=12
$grp3:=$grp2+$grpCnt2  //21
$grpCnt3:=10
//$error:=// -- AL_SetArraysNam ($1;$grp1;$grpCnt1;"aPoItemNum";"aPOVndrAlph";
//"aPOQtyOrder";"aPOQtyNow";"aPOQtyRcvd";"aPoHoldQty";"aPOLnCmplt



If (bRecByChang=1)
	//// -- AL_SetWidths (ePOList;$grp1;$grpCnt1;56;5;40;46;40;10;103;48;5;3;65)
	
	// -- AL_SetWidths(ePOList; $grp1; $grpCnt1; 96; 5; 46; 46; 46; 46; 13; 168; 77; 5; 50; 108)
	// -- AL_SetWidths(ePOList; $grp2; $grpCnt2; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50)
	// -- AL_SetWidths(ePOList; $grp3; $grpCnt3; 50; 50; 70; 50; 50; 50; 50; 50; 50; 60)
	
	
Else 
	//// -- AL_SetWidths (ePOList;$grp1;$grpCnt1;56;5;40;5;33;10;106;64;27;5;72)
	
	// -- AL_SetWidths(ePOList; $grp1; $grpCnt1; 96; 5; 67; 5; 48; 5; 26; 168; 108; 51; 5; 122)
	// -- AL_SetWidths(ePOList; $grp2; $grpCnt2; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50; 50)
	// -- AL_SetWidths(ePOList; $grp3; $grpCnt3; 50; 50; 70; 50; 50; 50; 50; 50; 50; 60)
	
End if 

//  --  CHOPPED  AL_UpdateArrays(ePOList; -2)

