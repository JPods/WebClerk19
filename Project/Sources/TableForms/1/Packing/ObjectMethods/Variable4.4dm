If (Size of array:C274(aoLnSelect)>0)
	If (iLoReal3<aOQtyBL{aoLnSelect{1}})
		iLoReal3:=iLoReal3+1
		iLoReal4:=iLoReal4+aOUnitWt{aoLnSelect{1}}
	Else 
		BEEP:C151
		BEEP:C151
	End if 
Else 
	ALERT:C41("Select an order line")
End if 