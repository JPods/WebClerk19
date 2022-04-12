
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/12/18, 15:34:15
// ----------------------------------------------------
// Method: [Invoice].LoadTags.b62
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($incRec; $cntRec)
// ### jwm ### 20180712_1533 Get selected lines
ARRAY LONGINT:C221(aShipSel; 0)
//  CHOPPED  $error:=AL_GetSelect(eShipList; aShipSel)
$cntRec:=Size of array:C274(aShipSel)
CONFIRM:C162("Fill down TrackingID "+iLo40String1+"in "+String:C10($cntRec)+" packages.")
If (OK=1)
	For ($incRec; 1; $cntRec)
		aPKtrackID{aShipSel{$incRec}}:=iLo40String1
	End for 
	doSearch:=62
End if 