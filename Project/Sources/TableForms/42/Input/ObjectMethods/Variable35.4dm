KeyModifierCurrent
Case of 
	: (CmdKey=1)
		RelateByArray(->aPItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
		RelateByArray(->aPItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
	Else 
		ListItemAvail(->aPItemNum; ->aPPLnSelect)
End case 








