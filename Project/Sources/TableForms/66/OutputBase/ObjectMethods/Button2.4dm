ALL RECORDS:C47([WorkOrder:66])
$k:=Records in selection:C76([WorkOrder:66])
For ($i; 1; $k)
	If ([WorkOrder:66]idNumTask:22#0)
		QUERY:C277([Order:3]; [Order:3]orderNum:2=[WorkOrder:66]idNumTask:22)
		If (Records in selection:C76([Order:3])=1)
			TaskIDAssign(->[Order:3]idNumTask:85)
			SAVE RECORD:C53([Order:3])
			[WorkOrder:66]profile1:37:=String:C10([Order:3]orderNum:2)
			[WorkOrder:66]idNumTask:22:=[Order:3]idNumTask:85
		Else 
			[WorkOrder:66]profile1:37:=String:C10([WorkOrder:66]idNumTask:22)
			[WorkOrder:66]idNumTask:22:=2
		End if 
		SAVE RECORD:C53([WorkOrder:66])
	End if 
	NEXT RECORD:C51([WorkOrder:66])
End for 



If (False:C215)
	vText2:=""
	PrintPack2TextBlock(->[WorkOrder:66]actionBy:8; ->vText1)
	vText2:=vText2+"\r"+vText1
	
	SET TEXT TO PASTEBOARD:C523(vText1)
	
	PrintPack2TextBlock(->[WorkOrder:66]rate:23; ->vText1; 2)
	vText2:=vText2+"\r"+vText1
	
	SET TEXT TO PASTEBOARD:C523(vText1)
	
	WO_FillArrays(Records in selection:C76([WorkOrder:66]))
	PrintPack2TextBlock(->aWoNameID; ->vText1)
	
	vText2:=vText2+"\r"+vText1
	SET TEXT TO PASTEBOARD:C523(vText1)
	PrintPack2TextBlock(->aWoDateNd; ->vText1; 1)
	vText2:=vText2+"\r"+vText1
	SET TEXT TO PASTEBOARD:C523(vText1)
	PrintPack2TextBlock(->aWoRate; ->vText1; 2)
	vText2:=vText2+"\r"+vText1
	SET TEXT TO PASTEBOARD:C523(vText1)
	
	
	
	SET TEXT TO PASTEBOARD:C523(vText2)
	
End if 