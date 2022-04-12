//%attributes = {}
// Script cascade & resize 20190801.4d

ARRAY LONGINT:C221($alWnd; 0)

WINDOW LIST:C442($alWnd)

// top of screen
$vlLeft:=2
If (Is macOS:C1572)
	$vlTop:=45  // Leave enough room for the Tool bar
Else 
	$vlTop:=34
End if 

// center of screen
viCenterHeight:=Screen height:C188/2
viCenterWidth:=Screen width:C187/2
$vlLeft:=viCenterWidth-(1020/2)
$vlTop:=viCenterHeight-(710/2)


C_LONGINT:C283($vlWnd; $cntWindows; $findRay)
C_TEXT:C284($processName)
$cntWindows:=Size of array:C274($alWnd)
// Array Longint($alProcess;$cntWindows)
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
				
				GET WINDOW RECT:C443($vlWL; $vlWT; $vlWR; $vlWB; $alWnd{$vlWnd})
				$viWidth:=1020
				$vlWR:=$vlLeft+$viWidth
				
				$viHeight:=710
				$vlWB:=$vlTop+$viHeight
				
				$vlWL:=$vlLeft
				$vlWT:=$vlTop
				SET WINDOW RECT:C444($vlWL; $vlWT; $vlWR; $vlWB; $alWnd{$vlWnd})
				$vlLeft:=$vlLeft+10
				$vlTop:=$vlTop+21
				//
				SHOW PROCESS:C325($processNum)
				BRING TO FRONT:C326($processNum)
		End case 
	End if 
End for 