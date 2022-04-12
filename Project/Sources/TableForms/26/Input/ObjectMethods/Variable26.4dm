KeyModifierCurrent
Case of 
	: (CmdKey=1)
		RelateByArray(->aiItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
		RelateByArray(->aiItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
	Else 
		ListItemAvail(->aiItemNum; ->aRayLines)
End case 