//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/15/20, 01:25:44
// ----------------------------------------------------
// Method: FixImagePath
// Description
// 
//
// Parameters
// ----------------------------------------------------
// leave this so it can be run in ExecuteScript
C_LONGINT:C283(vi1; vi2; vi4)
vi2:=Records in selection:C76([Item:4])
FIRST RECORD:C50([Item:4])
For (vi1; 1; $k)
	vi4:=Position:C15("CommerceExpert"; [Item:4]imagePath:104)
	If (vi4>0)
		[Item:4]imagePath:104:=Substring:C12([Item:4]imagePath:104; vi4+15)
		[Item:4]imagePath:104:=Replace string:C233([Item:4]imagePath:104; ":"; Folder separator:K24:12)
		[Item:4]imagePath:104:=Replace string:C233([Item:4]imagePath:104; "\\"; Folder separator:K24:12)
		[Item:4]imagePath:104:=Storage:C1525.folder.jitF+[Item:4]imagePath:104
		[Item:4]profile6:94:="Worked image"
		SAVE RECORD:C53([Item:4])
	End if 
	NEXT RECORD:C51([Item:4])
End for 
UNLOAD RECORD:C212([Item:4])