If (False:C215)
	//Method:
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
//array TEXT(aTmp20Str2;5)
//aTmp20Str2{1}:="Process"
//aTmp20Str2{2}:="Box"
//aTmp20Str2{3}:="Pallet"
//aTmp20Str2{4}:="Invoice"
//aTmp20Str2{5}:="Clear"
//aTmp20Str2:=1

If (aTmp20Str2>1)
	Case of 
		: (aTmp20Str2=2)  //"Box"
			PKBoxItemsTags
		: (aTmp20Str2=3)  //"Pallet"
			ALERT:C41("Use Pallet popup.")
			
			//Procedure: Web_Setup
			If (False:C215)
				C_LONGINT:C283($found)
				$found:=Prs_CheckRunnin("PalletsContainers")
				If ($found>0)
					BRING TO FRONT:C326($found)
					
				Else 
					<>ptCurTable:=ptCurTable
					<>prcControl:=1
					<>processAlt:=New process:C317("PackingPalletWin"; <>tcPrsMemory; "PalletsContainers")
				End if 
			End if 
			//    PKPalletPack 
			
		: (aTmp20Str2=4)  //"Invoice"
			C_TEXT:C284(dInventoryPK)
			dInventoryPK:="pk"
			PKOrder2Invoice
			dInventoryPK:=""
			UNLOAD RECORD:C212([Invoice:26])
		: (aTmp20Str2=5)  //clear
			CONFIRM:C162("Clear current Load Items")
			If (OK=1)
				
				LT_FillArrayLoadItems(0)
			End if 
		: (aTmp20Str2=6)  //Item in Package
			TRACE:C157
			PKPackageContents
	End case 
End if 
aTmp20Str2:=1