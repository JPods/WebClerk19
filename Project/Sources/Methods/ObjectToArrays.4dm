//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/27/20, 00:32:42
// ----------------------------------------------------
// Method: ObjectToArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($rayInc; $rayCnt)
C_OBJECT:C1216($1; $voPayLoad)
$voPayLoad:=$1
C_POINTER:C301($2; $aPtNames)
C_POINTER:C301($3; $aPtValues)
$aPtNames:=$2
$aPtValues:=$3
C_TEXT:C284($vtValue)
ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($aiTypes; 0)
OB GET PROPERTY NAMES:C1232($voPayLoad; $atNames; $aiTypes)
$rayCnt:=Size of array:C274($atNames)
For ($rayInc; 1; $rayCnt)
	APPEND TO ARRAY:C911($aPtNames->; $atNames{$rayInc})
	$viType:=$aiTypes{$rayInc}
	Case of 
		: (($viType=Is real:K8:4) | ($viType=Is longint:K8:6) | ($viType=Is integer 64 bits:K8:25) | ($viType=_o_Is float:K8:26) | ($viType=Is date:K8:7) | ($viType=Is time:K8:8))
			$vtValue:=String:C10(OB Get:C1224($voPayLoad; $atNames{$rayInc}; $viType))
		: ($viType=Is boolean:K8:9)
			$vtValue:=String:C10(Num:C11(OB Get:C1224($voPayLoad; $atNames{$rayInc}; $viType)))
		Else 
			$vtValue:=OB Get:C1224($voPayLoad; $atNames{$rayInc}; $viType)  // get the actual value
	End case 
	APPEND TO ARRAY:C911($aPtValues->; $vtValue)
End for 