//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $i)
READ ONLY:C145([DefaultQQQ:15])
READ ONLY:C145([Rep:8])
READ ONLY:C145([Invoice:26])
READ ONLY:C145([Payment:28])
PRINT SETTINGS:C106
If (OK=1)
	QUERY:C277([DefaultQQQ:15]; [DefaultQQQ:15]PrimeDefault:176=1)
	If (vHere=1)
		FIRST RECORD:C50([QQQCustomer:2])
		For ($i; 1; Records in selection:C76([QQQCustomer:2]))
			//    DaysPastDueOne 
			If ([QQQCustomer:2]lateNotice:64<=(Current date:C33-<>tcLateFreq))
				PrntStateWrap
			End if 
			NEXT RECORD:C51([QQQCustomer:2])
		End for 
		UNLOAD RECORD:C212([Invoice:26])
		UNLOAD RECORD:C212([Payment:28])
	Else 
		//  DaysPastDueOne 
		PrntStateWrap
		[QQQCustomer:2]lateNotice:64:=Current date:C33
		SAVE RECORD:C53([QQQCustomer:2])
	End if 
	vOverDueBy:=""
	vHeading:=""
	vClosing:=""
	UNLOAD RECORD:C212([Rep:8])
	UNLOAD RECORD:C212([DefaultQQQ:15])
	READ WRITE:C146([Rep:8])
	READ WRITE:C146([Invoice:26])
	READ WRITE:C146([Payment:28])
	//jArrayTerms 
	
	//jArrayTrmClr 
End if 