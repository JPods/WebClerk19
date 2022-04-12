If (False:C215)
	
	curTableNum:=Table:C252(->[CashJournal:52])
	<>ptCurTable:=Table:C252(curTableNum)
	C_TEXT:C284($text)
	$text:="Query([CashJournal];[CashJournal]UniqueID="+String:C10([Payment:28]jrnlid:25)+")"
	DB_ShowCurrentSelection(Table:C252(curTableNum); $text; 1; "")
End if 