//%attributes = {"publishedWeb":true}

UNLOAD RECORD:C212([Control:1])
//jsetDefaultFile ([Customer])
UNLOAD RECORD:C212([Customer:2])
UNLOAD RECORD:C212([Lead:48])
UNLOAD RECORD:C212([Service:6])
ENABLE MENU ITEM:C149(1; 4)
ENABLE MENU ITEM:C149(1; 5)
ENABLE MENU ITEM:C149(1; 6)
ENABLE MENU ITEM:C149(1; 7)
ptCurTable:=(->[Control:1])