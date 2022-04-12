//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-08-26T00:00:00, 21:06:26
// ----------------------------------------------------
// Method: WC_StartUpShutDownFlip
// Description
// Modified: 08/26/17
// 
// WebClerkStartUp
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($err; $i; $tasks; $w; $localIP; $tcpVers; $otVer)
C_TEXT:C284($testFolder)
C_LONGINT:C283($1; $flipWebClerk; <>vlServerAge; <>dtStartWebClerk; $err)
$flipWebClerk:=10
If (Count parameters:C259>0)
	$flipWebClerk:=$1
End if 

$w:=Find in array:C230(<>aPrsNameWeb; "WC_@")  // look in active processes for a running webclerk if found, turn off
If (($w>0) & ($flipWebClerk#1))  // found an element
	$startWebClerk:=0  // turn switch off
	WC_ShutDown
	
	DELAY PROCESS:C323(Current process:C322; 30)
	$w:=Find in array:C230(<>aPrsName; "Proces@")
	If ($w>-1)
		POST OUTSIDE CALL:C329(<>aPrsNum{$w})
	End if 
Else 
	
	WC_StartUp
	
End if 