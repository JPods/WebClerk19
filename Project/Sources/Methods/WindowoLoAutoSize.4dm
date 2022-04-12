//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 2017-05-01T00:00:00, 19:11:41
// ----------------------------------------------------
// Method: WindowoLoAutoSize
// Description
// Modified: 05/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------


// Script Output Layout Auto Size 20161118
// Execute_TallyMaster("0loAutoSize";"Scripts";3)

C_LONGINT:C283(vlWidth; vlHeight; vlLeft; vlTop; vlRight; vlBottom)

// test to see if "If" statement can be removed
FORM GET PROPERTIES:C674(ptCurTable->; "Output"; vlwidth; vlheight)

GET WINDOW RECT:C443(vlLeft; vlTop; vlRight; vlBottom)


vlBottom:=vlTop+vlheight+800
vlRight:=vlLeft+vlWidth+10

SET WINDOW RECT:C444(vlLeft; vlTop; vlRight; vlBottom)
