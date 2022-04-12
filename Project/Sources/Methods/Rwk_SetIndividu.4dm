//%attributes = {"publishedWeb":true}
//Procedure: Rwk_SetIndividu
CONFIRM:C162("Set Last, First and Individual?")
If (OK=1)
	CONFIRM:C162("Set, there is NO UNDO?")
	If (OK=1)
		Case of 
			: (ptCurTable=(->[QQQCustomer:2]))
				If (vHere<2)
					vi2:=Records in selection:C76([QQQCustomer:2])
				Else 
					vi2:=1
				End if 
				FIRST RECORD:C50([QQQCustomer:2])
				For (vi1; 1; vi2)
					MESSAGE:C88(String:C10(vi1)+" of "+String:C10(vi2))
					[QQQCustomer:2]company:2:=[QQQCustomer:2]nameLast:23+", "+[QQQCustomer:2]nameFirst:73
					[QQQCustomer:2]individual:72:=True:C214
					SAVE RECORD:C53([QQQCustomer:2])
					If (vHere<2)
						NEXT RECORD:C51([QQQCustomer:2])
					End if 
				End for 
			: (ptCurTable=(->[Lead:48]))
				If (vHere<2)
					vi2:=Records in selection:C76([Lead:48])
				Else 
					vi2:=1
				End if 
				FIRST RECORD:C50([Lead:48])
				For (vi1; 1; vi2)
					MESSAGE:C88(String:C10(vi1)+" of "+String:C10(vi2))
					[Lead:48]Company:5:=[Lead:48]NameLast:2+", "+[Lead:48]NameFirst:1
					[Lead:48]Individual:31:=True:C214
					SAVE RECORD:C53([Lead:48])
					If (vHere<2)
						NEXT RECORD:C51([Lead:48])
					End if 
				End for 
		End case 
	End if 
End if 
REDRAW WINDOW:C456