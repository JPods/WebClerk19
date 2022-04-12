//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/29/12, 13:09:16
// ----------------------------------------------------
// Method: TimeStatus
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($curCnt; <>tcStatDeLay)
KeyModifierCurrent
If ((OptKey=1) | (vlStatTime=0))
	TM_RiteStatus
Else 
	$curCnt:=DateTime_Enter
	If ((($curCnt-vlStatTime)\60)>=<>tcStatDeLay)
		TM_RiteStatus
	End if 
End if 