//%attributes = {}


// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/08/18, 11:50:24
// ----------------------------------------------------
// Method: FormSizeAuto
// Description:  
// Adjust size of window to fit current Form
//
// Parameters:  None
// ----------------------------------------------------

If (False:C215)
	C_LONGINT:C283($viWindowWidth; $viWindowHeight; $viLeft; $viTop; $viRight; $viBottom; $viPadding)
	
	FORM GET PROPERTIES:C674(Current form table:C627->; Current form name:C1298; $viFormWidth; $viFormHeight)
	
	$vhWinRef:=Current form window:C827
	$type:=Type:C295($vhWinRef)
	
	GET WINDOW RECT:C443($viLeft; $viTop; $viRight; $viBottom; $vhWinRef)
	$viWindowWidth:=$viRight-$viLeft
	$viWindowHeight:=$viBottom-$viTop
	
	If (Current form name:C1298="Output")
		// 50% of Screen Height
		$viFormHeight:=Screen height:C188*0.6
	End if 
	
	
	If (Is macOS:C1572)
		$viPadding:=10
	Else 
		$viPadding:=20
	End if 
	
	// added 20 pixels for the widow border might need to be larger for Windoze Machines
	$videltaWidth:=$viFormWidth-$viWindowWidth+$viPadding
	$videltaHeight:=$viFormHeight-$viWindowHeight+$viPadding
	
	C_BOOLEAN:C305($vbWindowOffScreen)
	Case of 
		: ($vbWindowOffScreen)
			WindowCascade
			
			MAXIMIZE WINDOW:C453  // sizes the window to fill the screen
			//RESIZE FORM WINDOW(Screen width*-0.5; Screen height*-0.5)
			RESIZE FORM WINDOW:C890(-20; -20)
		: (($videltaWidth=0) & ($videltaHeight=0))
			
		Else 
			//RESIZE FORM WINDOW($videltaWidth+$viWindowWidth; $videltaHeight+$viWindowHeight)
			RESIZE FORM WINDOW:C890($videltaWidth; $videltaHeight)  // works off the the delta, not the new size
	End case 
End if 