//%attributes = {"publishedWeb":true}
//Method: // zzzqqq Cust_IndividFil
//KeyModifierCurrent 
//TRACE
Case of 
	: ((ptCurTable=(->[QQQCustomer:2])) | (ptCurTable=(->[Invoice:26])) | (ptCurTable=(->[Order:3])) | (ptCurTable=(->[Proposal:42])))
		If ([QQQCustomer:2]individual:72)
			If ([QQQCustomer:2]nameLast:23="")
				//      
			Else 
				If (([QQQCustomer:2]company:2="") | (srCustomer=""))
					[QQQCustomer:2]company:2:=[QQQCustomer:2]nameLast:23+(", "*Num:C11(([QQQCustomer:2]nameLast:23#"") & ([QQQCustomer:2]nameFirst:73#"")))+[QQQCustomer:2]nameFirst:73
					srCustomer:=[QQQCustomer:2]company:2
				Else 
					CONFIRM:C162("Keep Company as is verses Last, First?")
					If (OK=0)
						[QQQCustomer:2]company:2:=[QQQCustomer:2]nameLast:23+(", "*Num:C11(([QQQCustomer:2]nameLast:23#"") & ([QQQCustomer:2]nameFirst:73#"")))+[QQQCustomer:2]nameFirst:73
						srCustomer:=[QQQCustomer:2]company:2
					Else 
						[QQQCustomer:2]individual:72:=False:C215
					End if 
				End if 
			End if 
		End if 
	: (ptCurTable=(->[Lead:48]))
		If ([Lead:48]Individual:31)
			If (([Lead:48]NameLast:2="") & ([Lead:48]NameFirst:1=""))
				//no action        
			Else 
				[Lead:48]Company:5:=[Lead:48]NameLast:2+(", "*Num:C11(([Lead:48]NameLast:2#"") & ([Lead:48]NameFirst:1#"")))+[Lead:48]NameFirst:1
				srCustomer:=[Lead:48]Company:5
			End if 
		End if 
End case 
If (Record number:C243(ptCurTable->)=-3)
	Case of 
		: (ptCurTable=(->[Invoice:26]))
			[Invoice:26]company:7:=[QQQCustomer:2]company:2
			[Invoice:26]attention:38:=[QQQCustomer:2]nameFirst:73+(" "*Num:C11(([QQQCustomer:2]nameLast:23#"") & ([QQQCustomer:2]nameFirst:73#"")))+[QQQCustomer:2]nameLast:23
		: (ptCurTable=(->[Order:3]))
			[Order:3]company:15:=[QQQCustomer:2]company:2
			[Order:3]attention:44:=[QQQCustomer:2]nameFirst:73+(" "*Num:C11(([QQQCustomer:2]nameLast:23#"") & ([QQQCustomer:2]nameFirst:73#"")))+[QQQCustomer:2]nameLast:23
		: (ptCurTable=(->[Proposal:42]))
			[Proposal:42]company:11:=[QQQCustomer:2]company:2
			[Proposal:42]attention:37:=[QQQCustomer:2]nameFirst:73+(" "*Num:C11(([QQQCustomer:2]nameLast:23#"") & ([QQQCustomer:2]nameFirst:73#"")))+[QQQCustomer:2]nameLast:23
	End case 
End if 