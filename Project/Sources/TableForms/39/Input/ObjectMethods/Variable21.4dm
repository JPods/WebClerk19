KeyModifierCurrent
Case of 
	: (CmdKey=1)
		RelateByArray(->aPoItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
		RelateByArray(->aPoItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
	Else 
		ListItemAvail(->aPoItemNum; ->aRayLines)
End case 

