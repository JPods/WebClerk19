//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/16/20, 23:50:15
// ----------------------------------------------------
// Method: WindowWithinScreen
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $viReference; $2; $viLeftOffSet; $3; $viTopOffSet)
C_LONGINT:C283($viWindowWidth; $viWindowHeight)
$viReference:=$1
If (Count parameters:C259>1)
	$viLeftOffSet:=$2
	If (Count parameters:C259>2)
		$viTopOffSet:=$3
	End if 
End if 
If ($viLeftOffSet<5)
	$viLeftOffSet:=5
End if 
If ($viLeftOffSet<53)
	$viTopOffSet:=53
End if 
If ($viReference=0)
	GET WINDOW RECT:C443($viWindowLeft; $viWindowTop; $viWindowRight; $viWindowBottom)  // do the front most window of the current process
Else 
	GET WINDOW RECT:C443($viWindowLeft; $viWindowTop; $viWindowRight; $viWindowBottom; $viReference)
End if 
$viWindowWidth:=$viWindowRight-$viWindowLeft
$viWindowHeight:=$viWindowBottom-$viWindowTop
//
$viWindowLeft:=$viLeftOffSet
If ($viWindowWidth+$viLeftOffSet>Screen width:C187)
	$viWindowRight:=Screen width:C187-$viLeftOffSet-10
Else 
	$viWindowRight:=$viWindowWidth+$viLeftOffSet
End if 
$viWindowTop:=$viTopOffSet
If ($viWindowHeight+$viTopOffSet>Screen height:C188)
	$viWindowBottom:=Screen height:C188-$viTopOffSet-10
Else 
	$viWindowBottom:=$viWindowHeight+$viTopOffSet
End if 
//


SET WINDOW RECT:C444($viWindowLeft; $viWindowTop; $viWindowRight; $viWindowBottom; $viReference)