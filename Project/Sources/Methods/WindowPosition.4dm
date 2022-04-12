//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-12-15T00:00:00, 13:33:39
// ----------------------------------------------------
// Method: WindowPosition
// Description
// Modified: 12/15/16
// 
// 
//
// Parameters
// ----------------------------------------------------

// Script Window Position 20161215

//<declarations>
//==================================
//  Type variables 
//==================================

C_TEXT:C284(<>WindowPosition)
C_LONGINT:C283(vibottom; viCenterHeight; viCenterWidth; vileft; viNewBottom; viNewLeft; viNewRight)
C_LONGINT:C283(viNewTop; viOffset; viright; viStart; vitop; viWinHeight; viWinWidth)

//==================================
//  Initialize variables 
//==================================

vibottom:=0
viCenterHeight:=0
viCenterWidth:=0
vileft:=0
viNewBottom:=0
viNewLeft:=0
viNewRight:=0
viNewTop:=0
viOffset:=0
viright:=0
viStart:=0
vitop:=0
viWinHeight:=0
viWinWidth:=0
//</declarations>


viStart:=-100
ARRAY LONGINT:C221(alWindows; 0)
WINDOW LIST:C442(alWindows)
viOffset:=Size of array:C274(alWindows)%15*20


///  ReWORK



Case of 
		
	: (Current user:C182="Jim Medlen")
		<>WindowPosition:="Center"
		viStart:=-100
		
	: (Current user:C182="Huey")
		<>WindowPosition:="BottomCenter"
		viStart:=-60
		
End case 

If (<>WindowPosition="Center")
	
	GET WINDOW RECT:C443(vileft; vitop; viright; vibottom)
	viWinWidth:=viright-vileft
	viWinHeight:=vibottom-vitop
	viCenterHeight:=Screen height:C188/2
	viCenterWidth:=Screen width:C187/2
	viNewLeft:=viCenterWidth-(viWinWidth/2)+viStart+viOffset
	viNewRight:=viNewLeft+viWinWidth
	viNewTop:=viCenterHeight-(viWinHeight/2)+viStart+viOffset
	viNewBottom:=viNewTop+viWinHeight
	SET WINDOW RECT:C444(viNewLeft; viNewTop; viNewRight; viNewBottom)
	
End if 

If (<>WindowPosition="BottomRight")
	// move window bottom right
	GET WINDOW RECT:C443(vileft; vitop; viright; vibottom)
	viWinWidth:=viright-vileft
	viWinHeight:=vibottom-vitop
	viNewLeft:=Screen width:C187-viWinWidth
	viNewRight:=viNewLeft+viWinWidth
	viNewTop:=Screen height:C188-viWinHeight
	// viNewTop := 44  //top of screen
	viNewBottom:=viNewTop+viWinHeight
	SET WINDOW RECT:C444(viNewLeft; viNewTop; viNewRight; viNewBottom)
	
	// Set Header Background Light Yellow
	OBJECT SET RGB COLORS:C628(*; "HeaderBG"; 0x00FFFFFF; 0x00FFFF33)
	
End if 

If (<>WindowPosition="BottomCenter")
	
	GET WINDOW RECT:C443(vileft; vitop; viright; vibottom)
	viWinWidth:=viright-vileft
	viWinHeight:=vibottom-vitop
	viCenterHeight:=Screen height:C188/2
	viCenterWidth:=Screen width:C187/2
	viNewLeft:=viCenterWidth-(viWinWidth/2)+viStart+viOffset
	viNewRight:=viNewLeft+viWinWidth
	viNewTop:=(viCenterHeight*1.25)-(viWinHeight/2)+viStart+viOffset
	viNewBottom:=viNewTop+viWinHeight
	SET WINDOW RECT:C444(viNewLeft; viNewTop; viNewRight; viNewBottom)
	
End if 

<>WindowPosition:=""
