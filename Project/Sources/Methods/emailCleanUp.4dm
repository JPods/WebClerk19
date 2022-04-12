//%attributes = {}






C_LONGINT:C283(vi1; $k)
vi2:=Records in selection:C76([Customer:2])
FIRST RECORD:C50([Customer:2])
For (vi1; 1; vi2)
	If ([Customer:2]email:81#"")
		[Customer:2]email:81:=[Customer:2]email:81
		If (Position:C15("&~"; [Customer:2]email:81)>2)
			
		Else 
			[Customer:2]comment:15:="EmailRemoved: :"+[Customer:2]email:81+"\r"+[Customer:2]comment:15
			[Customer:2]email:81:=""
		End if 
		SAVE RECORD:C53([Customer:2])
	End if 
	NEXT RECORD:C51([Customer:2])
End for 


C_LONGINT:C283(vi1; $k)
vi2:=Records in selection:C76([Customer:2])
FIRST RECORD:C50([Customer:2])
For (vi1; 1; vi2)
	vi4:=Position:C15("\r"; [Customer:2]comment:15)
	vText1:=Substring:C12([Customer:2]comment:15; 1; vi4-1)
	[Customer:2]shipInstruct:24:=Replace string:C233(vText1; "EmailRemoved: :"; "")
	SAVE RECORD:C53([Customer:2])
	NEXT RECORD:C51([Customer:2])
End for 
UNLOAD RECORD:C212([Customer:2])


C_LONGINT:C283(vi1; $k)

ALERT:C41("Char: "+String:C10(Num:C11(<>tcDefaultAllowEmailChar)))
vi2:=Records in selection:C76([Customer:2])
FIRST RECORD:C50([Customer:2])
For (vi1; 1; vi2)
	If ([Customer:2]email:81="")
		If (Position:C15(Char:C90(64); [Customer:2]shipInstruct:24)>2)
			[Customer:2]email:81:=[Customer:2]shipInstruct:24
			SAVE RECORD:C53([Customer:2])
		End if 
	End if 
	NEXT RECORD:C51([Customer:2])
End for 
UNLOAD RECORD:C212([Customer:2])




