If (False:C215)
	Version_0501
End if 
//viScanByAction

If ((Size of array:C274(aoLnSelect)<1) | (Size of array:C274(aOItemNum)<1))
	ALERT:C41("No order line selected.")
Else 
	If (PKNo_ScanPack)
		If (aTmp20Str4>0)
			viScanByAction:=aTmp20Str4
			If (aTmp20Str4=3)
				PKQtyManual
			End if 
		End if 
	Else 
		ALERT:C41("Must have PackingManual Privileges.")
	End if 
End if 