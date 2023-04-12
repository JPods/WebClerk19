//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/15/18, 22:23:21
// ----------------------------------------------------
// Method: PathTest
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $ptPath)
C_TEXT:C284($2; $variableName; $thePath; $systemPath)
C_LONGINT:C283($3; $v411; $viValid)

If (<>viDebugMode>410)
	$v411:=411
End if 

$ptPath:=$1

$thePath:=$ptPath->


$systemPath:=PathToSystem($thePath)


$variableName:="not stated"
If (Count parameters:C259>1)
	$variableName:=$2
	If (Count parameters:C259>2)
		$v411:=$3
	End if 
End if 





$viValid:=Test path name:C476($thePath)

Case of 
	: ($viValid<0)
		If ($v411=411)
			ConsoleLog("vtLocalPath invalid: "+$ptPath->)
		End if 
	: ($viValid=0)
		$ptPath->:=$ptPath->+"\\"
		If ($v411=411)
			ConsoleLog("vtLocalPath,folder: "+$ptPath->)
		End if 
	: ($viValid=1)
		If ($v411=411)
			ConsoleLog("vtLocalPath,doc: "+$ptPath->)
		End if 
End case 

