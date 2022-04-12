If (Size of array:C274(aShipSel)>0)
	CONFIRM:C162("Delete packages?")
	If (OK=1)
		$k:=Size of array:C274(aShipSel)
		For ($i; $k; 1; -1)
			If (aPKUniqueIDSuperior{aShipSel{$i}}=0)
				If (aPKUniqueID{aShipSel{$i}}>0)
					QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{aShipSel{$i}})
					DELETE RECORD:C58([LoadTag:88])
				End if 
				PKArrayManage(-1; aShipSel{$i}; 1)
				doSearch:=2
			Else 
				ALERT:C41("LoadTag "+String:C10(aPKUniqueID{aShipSel{$i}})+" is part of a larger package"+"\r"+"\r"+"Use Shipment Packing Window to manage.")
			End if 
		End for 
	End if 
End if 