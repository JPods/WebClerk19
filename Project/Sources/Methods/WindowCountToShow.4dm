//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/29/21, 15:04:03
// ----------------------------------------------------
// Method: WindowCountToShow
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($viCount)
C_OBJECT:C1216($obWindows)
$obWindows:=New object:C1471("count"; 0; "topOffset"; 0; "leftOffset"; 0)
WINDOW LIST:C442($alWnd)
C_LONGINT:C283($vlWnd; $cntWindows; $findRay)
C_TEXT:C284($processName)
$cntWindows:=Size of array:C274($alWnd)
$viCount:=0
For ($vlWnd; $cntWindows; 1; -1)
	$processNum:=Window process:C446($alWnd{$vlWnd})
	$findRay:=Find in array:C230(<>aPrsNum; $processNum)
	If ($findRay<1)  // did not find a process
		DELETE FROM ARRAY:C228($alWnd; $vlWnd; 1)
	Else 
		C_LONGINT:C283($tasks; $prsNum; $state; $tics)
		C_TEXT:C284($curProcessName)
		PROCESS PROPERTIES:C336($processNum; $curProcessName; $state; $tics)
		Case of 
			: (Window kind:C445($alWnd{$vlWnd})=Modal dialog:K27:2)
				DELETE FROM ARRAY:C228($alWnd; $vlWnd; 1)
			: ($curProcessName="Console@")
				DELETE FROM ARRAY:C228($alWnd; $vlWnd; 1)
			Else 
				$viCount:=$viCount+1
		End case 
	End if 
End for 
$obWindows.count:=$viCount
$obWindows.topOffset:=$viCount*20
$obWindows.leftOffset:=$viCount*30
$0:=$obWindows