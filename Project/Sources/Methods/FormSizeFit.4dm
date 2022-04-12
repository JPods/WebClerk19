//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/01/20, 22:10:56
// ----------------------------------------------------
// Method: FormSizeFit
// Description
// 
//
// Parameters
// ----------------------------------------------------


$viWinRef:=Current form window:C827

// get window dimensions
GET WINDOW RECT:C443($viWindowLeft; $viWindowTop; $viWindowRight; $viWindowBottom; $viWinRef)

//get screen dimensions
$viScreenHeight:=Screen height:C188
$viScreenWidth:=Screen width:C187

$viScreenLeft:=0
$viScreenTop:=0
$viScreenRight:=$viScreenLeft+$viScreenWidth
$viScreenBottom:=$viScreenTop+$viScreenHeight

// calculate window width & height
$viWindowWidth:=$viWindowRight-$viWindowLeft
$viwindowHeight:=$viWindowBottom-$viWindowTop


// If window is taller than the screen
If ($viWindowHeight>$viScreenHeight)
	$viWindowHeight:=$viScreenHeight
End if 

// if the window is wider than the screen
If ($viWindowWidth>$viScreenWidth)
	$viWindowWidth:=$viScreenWidth
End if 

// if window is outside the screen boundaries
If (($viWindowleft<$viScreenLeft) | ($viWindowTop<$viScreenTop) | ($viWindowRight>$viScreenRight) | ($viWindowBottom>$viScreenBottom))
	
	// reset form to default size
	FormSizeAuto
	
	$viWinRef:=Current form window:C827
	
	// get window dimensions
	GET WINDOW RECT:C443($viWindowLeft; $viWindowTop; $viWindowRight; $viWindowBottom; $viWinRef)
	
	// calculate window width & height
	$viWindowWidth:=$viWindowRight-$viWindowLeft
	$viwindowHeight:=$viWindowBottom-$viWindowTop
	
	// calculate offset
	$viOffsetX:=Int:C8(($viScreenwidth-$viWindowWidth)/2)
	$viOffsetY:=Int:C8(($viScreenHeight-$viWindowHeight)/2)
	
	
	// calculate new window dimensions centered on screen
	$viWindowLeft:=$viScreenleft+$viOffsetX
	$viWindowTop:=$viScreenTop+$viOffsetY
	$viWindowRight:=$viWindowLeft+$viWindowWidth
	$viWindowBottom:=$viWindowTop+$viwindowHeight
	
End if 

// set window position
SET WINDOW RECT:C444($viWindowLeft; $viWindowTop; $viWindowRight; $viWindowBottom; $viWinRef)

// bring window to front
BRING TO FRONT:C326(Current process:C322)


