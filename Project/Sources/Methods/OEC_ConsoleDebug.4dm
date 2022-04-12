//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/19/19, 20:48:06
// ----------------------------------------------------
// Method: OEC_ConsoleDebug
// Description
// 
//
// Parameters
// ----------------------------------------------------


//must open myErrDoc before calling procedure
If (<>VIDEBUGMODE>410)
	ConsoleMessage("Error: "+String:C10(error))
End if 