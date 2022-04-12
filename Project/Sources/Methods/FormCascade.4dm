//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/30/19, 08:17:02
// ----------------------------------------------------
// Method: FormCascade
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Script cascade & resize 20190116.4d

ARRAY LONGINT:C221($alWnd; 0)

WINDOW LIST:C442($alWnd)
$viLeft:=2
If (Is macOS:C1572)
	$viTop:=45  // Leave enough room for the Tool bar
Else 
	$viTop:=34
End if 
C_LONGINT:C283($viWnd; $cntWindows; $findRay)
C_TEXT:C284($processName)

C_BOOLEAN:C305($vbCascade)
// ### bj ### 20190130_0849
// temporary to set window sizes
$vbCascade:=False:C215


$cntWindows:=Size of array:C274($alWnd)
// ARRAY INTEGER($alProcess;$cntWindows)
For ($viWnd; $cntWindows; 1; -1)
	$processNum:=Window process:C446($alWnd{$viWnd})
	$findRay:=Find in array:C230(<>aPrsNum; $processNum)
	If ($findRay<1)  // did not find a process
		DELETE FROM ARRAY:C228($alWnd; $viWnd; 1)
	Else 
		C_LONGINT:C283($tasks; $prsNum; $state; $tics)
		C_TEXT:C284($curProcessName)
		PROCESS PROPERTIES:C336($processNum; $curProcessName; $state; $tics)
		Case of 
			: (Window kind:C445($alWnd{$viWnd})=Modal dialog:K27:2)
				DELETE FROM ARRAY:C228($alWnd; $viWnd; 1)
			: ($curProcessName="Console@")
				DELETE FROM ARRAY:C228($alWnd; $viWnd; 1)
			Else 
				
				GET WINDOW RECT:C443($viWL; $viWT; $viWR; $viWB; $alWnd{$viWnd})
				$viWidth:=1020
				$viWR:=$viLeft+$viWidth
				
				$viHeight:=710
				$viWB:=$viTop+$viHeight
				
				$viWL:=$viLeft
				$viWT:=$viTop
				SET WINDOW RECT:C444($viWL; $viWT; $viWR; $viWB; $alWnd{$viWnd})
				If ($vbCascade)
					$viLeft:=$viLeft+10
					$viTop:=$viTop+21
				End if 
				//
				SHOW PROCESS:C325($processNum)
				BRING TO FRONT:C326($processNum)
		End case 
	End if 
End for 