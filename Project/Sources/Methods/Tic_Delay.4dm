//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/11/16, 17:03:29
// ----------------------------------------------------
// Method: Tic_Delay
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $NumDelay)
$NumDelay:=Tickcount:C458+$1
Repeat 
	IDLE:C311
Until (Tickcount:C458>$NumDelay)