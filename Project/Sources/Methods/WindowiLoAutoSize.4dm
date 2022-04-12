//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 2017-05-01T00:00:00, 19:10:05
// ----------------------------------------------------
// Method: WindowiLoAutoSize
// Description
// Modified: 05/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------


// Script Input Layout Auto Size 20140925
// Execute_TallyMaster("iloAutoSize";"Scripts";3)

C_LONGINT:C283(vlWidth; vlHeight; vlLeft; vlTop; vlRight; vlBottom)


FORM GET PROPERTIES:C674(ptCurTable->; "Input"; vlwidth; vlheight)

GET WINDOW RECT:C443(vlLeft; vlTop; vlRight; vlBottom)

vlRight:=vlLeft+vlWidth+100
vlBottom:=vlTop+vlheight+10

SET WINDOW RECT:C444(vlLeft; vlTop; vlRight; vlBottom)
