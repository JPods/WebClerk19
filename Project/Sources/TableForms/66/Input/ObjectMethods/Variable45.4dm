$k:=Size of array:C274(<>aItemLines)
If ($k>0)
	If (Size of array:C274(<>aLsSrRec)>=$k)
		GOTO RECORD:C242([Item:4]; <>aLsSrRec{<>aItemLines{1}})
		pPartNum:=[Item:4]itemNum:1
		WOLnFillItem(pPartNum; -5)
		C_LONGINT:C283($p)
		$p:=Position:C15("<&pbu"; [WorkOrder:66]Description:3)
		If ($p>0)
			[WorkOrder:66]Description:3:=Txt_jitConvert([WorkOrder:66]Description:3)
		End if 
		UNLOAD RECORD:C212([ItemSpec:31])
		UNLOAD RECORD:C212([Item:4])
	End if 
End if 