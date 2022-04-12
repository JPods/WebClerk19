//%attributes = {"publishedWeb":true}
vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; vi2)
	vi9:=Position:C15("-CCS"; [Item:4]itemNum:1)
	vtext11:=Substring:C12([Item:4]itemNum:1; 1; vi9-1)
	If (Length:C16(vtext11)=4)
		ConsoleMessage([Item:4]itemNum:1)
		[Item:4]itemNum:1:="0"+[Item:4]itemNum:1
		SAVE RECORD:C53([Item:4])
	End if 
	NEXT RECORD:C51([Item:4])
End for 
UNLOAD RECORD:C212([Item:4])

