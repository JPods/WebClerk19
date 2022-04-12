KeyModifierCurrent
C_LONGINT:C283($error)
//  CHOPPED  $error:=AL_GetSelect(eOrdList; aRayLines)
Case of 
	: (CmdKey=1)
		
		RelateByArray(->aOItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
		RelateByArray(->aOItemNum; ->[Item:4]itemNum:1)
	: (OptKey=1)
	Else 
		ListItemAvail(->aOItemNum; ->aRayLines)
End case 

