//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-06-28T05:00:00Z)
// Method: SerCalClose
// Description 
// Parameters
// ----------------------------------------------------


UNLOAD RECORD:C212([Base:1])
//jsetDefaultFile ([Customer])
UNLOAD RECORD:C212([Customer:2])
UNLOAD RECORD:C212([Service:6])
ENABLE MENU ITEM:C149(1; 4)
ENABLE MENU ITEM:C149(1; 5)
ENABLE MENU ITEM:C149(1; 6)
ENABLE MENU ITEM:C149(1; 7)
ptCurTable:=(->[Base:1])