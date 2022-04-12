If (False:C215)
	//Method:
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
//aPalletsAvailable{1}:="Pallets"
//aPalletsAvailable{2}:="Add to New Pallet"
//aPalletsAvailable{3}:="Open Pallet Window"

If (aPalletsAvailable>1)
	//Case of 
	//: ((aPalletsAvailable=2)&([Order]customerID#""))//"Add to New Pallet"
	//CONFIRM("Add to new pallet")
	//If (OK=1)
	//PKPalletPack (-3;iLoInteger5)//new pallet, selected lines 0/1;Alert
	//
	//PKListPalletsAvailable ([Order]customerID)
	//End if 
	//ALERT("Pallet Built")
	//: (aPalletsAvailable=3)//"Open Pallet Window"
	//PKPalletWindow 
	//Else 
	C_LONGINT:C283(iLoInteger5)
	TRACE:C157
	KeyModifierCurrent
	If (CmdKey=1)
		CONFIRM:C162("Palletize selected boxes")
		If (OK=1)
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPalletsUniqueID{aPalletsAvailable})
			[LoadTag:88]completeid:36:=2
			SAVE RECORD:C53([LoadTag:88])
			UNLOAD RECORD:C212([LoadTag:88])
		End if 
	Else 
		If (iLoInteger5=1)
			CONFIRM:C162("Palletize selected boxes")
			If (OK=1)
				PKPalletPack(aPalletsUniqueID{aPalletsAvailable}; iLoInteger5)
			End if 
		Else 
			CONFIRM:C162("Palletize available boxes")
			If (OK=1)
				PKPalletPack(aPalletsUniqueID{aPalletsAvailable}; iLoInteger5)
			End if 
		End if 
	End if 
	//End case 
End if 
aPalletsAvailable:=1

