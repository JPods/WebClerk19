C_LONGINT:C283($incRecs; $cntRecs)
$cntRecs:=Records in set:C195("UserSet")

CONFIRM:C162("QuickQuote pull items into selected "+String:C10($cntRecs)+" Special Discounts?")
If (OK=1)
	CREATE SET:C116(ptCurTable->; "Current")
	USE SET:C118("UserSet")  //select the highlighted records
	FIRST RECORD:C50([SpecialDiscount:44])
	For ($incRecs; 1; $cntRecs)
		//
		QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4)
		Disc_ArraysDo(Records in selection:C76([ItemDiscount:45]))
		//
		//[SpecialDiscount]obSync:=DateTime_DTTo
		//
		Disc_AddItems
		//
		Disc_ArraysDo(-5)
		SAVE RECORD:C53([SpecialDiscount:44])
		NEXT RECORD:C51([SpecialDiscount:44])
	End for 
	USE SET:C118("Current")  //select the highlighted records
	CLEAR SET:C117("Current")
End if 

