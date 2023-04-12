Case of 
	: (ALProEvt=0)
	: (ALProEvt=1)
		ARRAY LONGINT:C221(aItemLines; 0)
		//  CHOPPED  $error:=AL_GetSelect(eSaleItList; aItemLines)
	: (ALProEvt=2)
		//  CHOPPED  $error:=AL_GetSelect(eSaleItList; aItemLines)
		C_LONGINT:C283($i; $k)
		$k:=Size of array:C274(aItemLines)
		For ($i; 1; $k)
			C_LONGINT:C283($dtBegin; $dtEnd)
			$dtBegin:=DateTime_DTTo(vdDateBeg; ?00:00:00?)
			$dtEnd:=DateTime_DTTo(vdDateEnd; ?24:00:00?)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aPartNum{$i})
			
			DB_ShowCurrentSelection(->[Item:4]; ""; 1; "For "+[Item:4]itemNum:1; 2)
			
			QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=aPartNum{$i}; *)
			QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15>=$dtBegin; *)
			QUERY:C277([DInventory:36];  & [DInventory:36]dtCreated:15<=$dtEnd)
			DB_ShowCurrentSelection(->[DInventory:36]; ""; 1; "For "+aPartNum{$i}; 2)
			
		End for 
	: (ALProEvt=-1)
	: (ALProEvt=-2)
	: (ALProEvt=-2)  //Edit menu Select All
		AL_CmdAll(->aPartNum; ->aItemLines)
End case 
ALProEvt:=0