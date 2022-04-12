//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/28/20, 10:16:29
// ----------------------------------------------------
// Method: C_UpdateYears
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_DATE:C307($1)  //Start date
C_POINTER:C301($2)  //Years array
C_LONGINT:C283($3)  //CS zone


C_LONGINT:C283($i; $LcurYear)
ARRAY TEXT:C222(C_Tyears_R; 10)
If (Count parameters:C259>0)
	$LcurYear:=Year of:C25($1)
	For ($i; -4; 5)
		$2->{$i+5}:=String:C10($i+$LcurYear)
	End for 
	$2->:=5
	//  CHOPPED   Area_Refresh($3)
End if 