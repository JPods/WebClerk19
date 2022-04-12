//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/28/19, 15:48:27
// ----------------------------------------------------
// Method: FormSetiLoSize
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($viWidthForm; $viHeightForm; $viPageCount; $viAdjWidth; $viAdjHeight)
C_BOOLEAN:C305($vbfixedWidth; $vbfixedHeight)
C_TEXT:C284($vtTitle; $vtFormName)
$vtFormName:=Current form name:C1298
FORM GET PROPERTIES:C674(ptCurTable->; $vtFormName; $viWidthForm; $viHeightForm; $viPageCount; $vbfixedWidth; $vbfixedHeight; $vtTitle)

C_LONGINT:C283($viLeft; $viTop; $viRight; $viBottom)
C_LONGINT:C283($viWindowWidth; $viWindowHeight)

GET WINDOW RECT:C443($viLeft; $viTop; $viRight; $viBottom)
$viWindowWidth:=$viRight-$viLeft
$viWindowHeight:=$viBottom-$viTop

// not using the forms defined size in favor of a standard window. This may be a mistake on anything but iLo and oLo
// Set a changable max ilo size
// make it so machine name can change these variables on startup
C_LONGINT:C283(<>viiLoWindowWidth; <>viiLoWindowHeight)
If (<>viiLoWindowWidth=0)
	<>viiLoWindowWidth:=1030
End if 
If (<>viiLoWindowHeight=0)
	<>viiLoWindowHeight:=720
End if 

$viWorkingWidth:=Screen width:C187-20  // set maximum usable area
$viWorkingHeight:=Screen height:C188-60

Case of 
	: ($viWindowWidth>=<>viiLoWindowWidth)  // & ($viWindowWidth<$viWorkingWidth))
		$viWindowWidth:=<>viiLoWindowWidth
	: (($viWindowWidth<<>viiLoWindowWidth) & (<>viiLoWindowWidth<$viWorkingWidth))
		$viWindowWidth:=<>viiLoWindowWidth
	Else 
		$viWindowWidth:=$viWorkingWidth  // force it to fit the screen
End case 
Case of 
	: ($viWindowHeight>=<>viiLoWindowHeight)  // & ($viWindowHeight<$viWorkingHeight))
		$viWindowHeight:=<>viiLoWindowHeight
	: (($viWindowHeight<<>viiLoWindowHeight) & (<>viiLoWindowHeight<$viWorkingHeight))
		$viWindowHeight:=<>viiLoWindowHeight
	Else 
		$viWindowHeight:=$viWorkingHeight  // force it to fit the screen
End case 

// check for screen overrun 
C_LONGINT:C283($viContraintHeight; $viContraintWidth)
If (($viLeft+$viWindowWidth>Screen width:C187) | ($viLeft<20))
	$viLeft:=20
End if 
If (($viTop+$viWindowHeight>Screen height:C188) | ($viTop<50))
	$viTop:=50
End if 

If (ptCurTable=(->[TechNote:58]))
	$viRight:=$viLeft+$viWidthForm+20
	$viBottom:=$viTop+$viHeightForm+20
Else 
	$viRight:=$viLeft+$viWindowWidth
	$viBottom:=$viTop+$viWindowHeight
End if 
SET WINDOW RECT:C444($viLeft; $viTop; $viRight; $viBottom)