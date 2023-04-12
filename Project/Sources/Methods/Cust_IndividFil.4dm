//%attributes = {"publishedWeb":true}
//Method: // zzzqqq Cust_IndividFil
//KeyModifierCurrent 
//TRACE
Case of 
	: ((ptCurTable=(->[Customer:2])) | (ptCurTable=(->[Invoice:26])) | (ptCurTable=(->[Order:3])) | (ptCurTable=(->[Proposal:42])))
		If ([Customer:2]individual:72)
			If ([Customer:2]nameLast:23="")
				//      
			Else 
				If (([Customer:2]company:2="") | (srCustomer=""))
					[Customer:2]company:2:=[Customer:2]nameLast:23+(", "*Num:C11(([Customer:2]nameLast:23#"") & ([Customer:2]nameFirst:73#"")))+[Customer:2]nameFirst:73
					srCustomer:=[Customer:2]company:2
				Else 
					CONFIRM:C162("Keep Company as is verses Last, First?")
					If (OK=0)
						[Customer:2]company:2:=[Customer:2]nameLast:23+(", "*Num:C11(([Customer:2]nameLast:23#"") & ([Customer:2]nameFirst:73#"")))+[Customer:2]nameFirst:73
						srCustomer:=[Customer:2]company:2
					Else 
						[Customer:2]individual:72:=False:C215
					End if 
				End if 
			End if 
		End if 
		
End case 
If (Record number:C243(ptCurTable->)=-3)
	Case of 
		: (ptCurTable=(->[Invoice:26]))
			[Invoice:26]company:7:=[Customer:2]company:2
			[Invoice:26]attention:38:=[Customer:2]nameFirst:73+(" "*Num:C11(([Customer:2]nameLast:23#"") & ([Customer:2]nameFirst:73#"")))+[Customer:2]nameLast:23
		: (ptCurTable=(->[Order:3]))
			[Order:3]company:15:=[Customer:2]company:2
			[Order:3]attention:44:=[Customer:2]nameFirst:73+(" "*Num:C11(([Customer:2]nameLast:23#"") & ([Customer:2]nameFirst:73#"")))+[Customer:2]nameLast:23
		: (ptCurTable=(->[Proposal:42]))
			[Proposal:42]company:11:=[Customer:2]company:2
			[Proposal:42]attention:37:=[Customer:2]nameFirst:73+(" "*Num:C11(([Customer:2]nameLast:23#"") & ([Customer:2]nameFirst:73#"")))+[Customer:2]nameLast:23
	End case 
End if 