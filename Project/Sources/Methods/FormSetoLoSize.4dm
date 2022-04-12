//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/29/19, 18:08:17
// ----------------------------------------------------
// Method: FormSetoLoSize
// Description
// 
//
// Parameters
// ----------------------------------------------------
// currently keeping iLo and oLo separate. This may not be necessary


C_LONGINT:C283($viWidthForm; $viHeightForm; $viPageCount; $viAdjWidth; $viAdjHeight)
C_BOOLEAN:C305($vbfixedWidth; $vbfixedHeight)
C_TEXT:C284($vtTitle; $vtFormName)
$vtFormName:=Current form name:C1298
FORM GET PROPERTIES:C674(ptCurTable->; $vtFormName; $viWidthForm; $viHeightForm; $viPageCount; $vbfixedWidth; $vbfixedHeight; $vtTitle)
// not using the forms defined in the oLo

C_LONGINT:C283($viLeft; $viTop; $viRight; $viBottom)
C_LONGINT:C283($viWindowWidth; $viWindowHeight)

GET WINDOW RECT:C443($viLeft; $viTop; $viRight; $viBottom)
$viWindowWidth:=$viRight-$viLeft
$viWindowHeight:=$viBottom-$viTop

If ($viWindowWidth<635)  // set a minimum size
	$viWindowWidth:=635
End if 
If ($viWindowHeight<475)
	$viWindowHeight:=475
End if 

// check for screen size


C_LONGINT:C283($viWorkingWidth; $viWorkingHeight)
$viWorkingWidth:=Screen width:C187-200  // set maximum usable area
$viWorkingHeight:=Screen height:C188-80



If ($viWindowWidth>$viWorkingWidth)  // if too wide
	// ### bj ### 20190129_1300 easy of reading
	// make it fit in the window
	$viWindowWidth:=$viWorkingWidth
Else 
	$viWindowWidth:=$viWindowWidth
End if 
If ($viWindowHeight>$viWorkingHeight)
	$viWindowHeight:=$viWorkingHeight
Else 
	$viWindowHeight:=$viWindowHeight
End if 
C_BOOLEAN:C305(<>vbForceWindowStandard)
If (<>vbForceWindowStandard)
	$viWindowWidth:=<>viiLoWindowWidth
	$viWindowHeight:=<>viiLoWindowHeight
End if 



C_BOOLEAN:C305($doCancel)
$doCancel:=False:C215
// check for screen overrun 
C_LONGINT:C283($viContraintHeight; $viContraintWidth)
If (($viLeft+$viWindowWidth>Screen width:C187) | ($viLeft<20))
	$viLeft:=2
End if 
If (($viTop+$viWindowHeight>Screen height:C188) | ($viTop<50))
	If (Is macOS:C1572)
		$viTop:=45  // Leave enough room for the Tool bar
	Else 
		$viTop:=34
	End if 
End if 
If (($viWindowWidth+(2*$viLeft))<Screen width:C187)
	$viRight:=$viLeft+$viWindowWidth
Else 
	$viRight:=Screen width:C187-120
	$doCancel:=True:C214
End if 
If (($viWindowHeight+(2*$viTop))<Screen height:C188)
	$viBottom:=$viTop+$viWindowHeight
Else 
	$viBottom:=Screen height:C188-120
	$doCancel:=True:C214
End if 

SET WINDOW RECT:C444($viLeft; $viTop; $viRight; $viBottom)

// cause window sizing to be saved
// ### bj ### 20190130_0841
If ($doCancel)
	KeyModifierCurrent
	If ((Shift down:C543) & (Windows Ctrl down:C562) & (Macintosh command down:C546))
		CANCEL:C270
	End if 
End if 

C_LONGINT:C283(viFormLeftolo; viFormTopolo; viFormRightolo; viFormBottomolo)  // ;viFormWinRefolo)

GET WINDOW RECT:C443(viFormLeftolo; viFormTopolo; viFormRightolo; viFormBottomolo)