//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/10/07, 14:43:21
// ----------------------------------------------------
// Method: WindowCascade
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($1; $vbFront)
$vbFront:=True:C214
If (Count parameters:C259>1)
	$vbFront:=$1
End if 

WINDOW LIST:C442($alWnd)
$vlLeftOffSet:=5
$vlTopOffSet:=53  // Leave enough room for the Tool bar
C_LONGINT:C283($vlWnd; $cntWindows; $findRay)
C_TEXT:C284($processName)
$cntWindows:=Size of array:C274($alWnd)
// ARRAY LONGINT($alProcess;$cntWindows)
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
				GET WINDOW RECT:C443($vlWindowLeft; $vlWindowTop; $vlWindowRight; $vlWindowBottom; $alWnd{$vlWnd})
				If ($vlWindowRight-$vlWindowLeft-$vlLeftOffSet<Screen width:C187)
					$vlWindowRight:=$vlLeftOffSet+($vlWindowRight-$vlWindowLeft)
				Else 
					$vlWindowRight:=Screen width:C187
				End if 
				If ($vlWindowBottom-$vlWindowTop-$vlTopOffSet<Screen height:C188)
					$vlWindowBottom:=$vlTopOffSet+($vlWindowBottom-$vlWindowTop)
				Else 
					$vlWindowBottom:=Screen height:C188
				End if 
				$vlWindowLeft:=$vlLeftOffSet
				$vlWindowTop:=$vlTopOffSet
				SET WINDOW RECT:C444($vlWindowLeft; $vlWindowTop; $vlWindowRight; $vlWindowBottom; $alWnd{$vlWnd})
				$vlLeftOffSet:=$vlLeftOffSet+10
				$vlTopOffSet:=$vlTopOffSet+21
				
				If ($vbFront)
					SHOW PROCESS:C325($processNum)
					BRING TO FRONT:C326($processNum)
				End if 
		End case 
	End if 
End for 
