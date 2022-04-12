If ([Order:3]customerid:1#"")  //"Add to New Pallet"
	CONFIRM:C162("Add to new pallet")
	If (OK=1)
		PKPalletPack(-3; iLoInteger5)  //new pallet, selected lines 0/1;Alert
		//
		PKListPalletsAvailable([Order:3]customerid:1)
	End if 
	ALERT:C41("Pallet Built")
Else 
	ALERT:C41("No Customer")
End if 