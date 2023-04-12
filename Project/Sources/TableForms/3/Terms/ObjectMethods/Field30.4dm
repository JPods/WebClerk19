C_TEXT:C284($tempAcct; $tempPO)
C_LONGINT:C283($k; $curRec)
//KeyModifierCurrent 
If (<>vbDuplicatePONum)
	If (([Order:3]customerID:1#"") & ([Order:3]customerPO:3#""))
		$tempAcct:=[Order:3]customerID:1
		$tempPO:=[Order:3]customerPO:3  //Substring([Order]CustPONum;2;36)
		PUSH RECORD:C176([Order:3])
		QUERY:C277([Order:3]; [Order:3]customerID:1=$tempAcct; *)
		QUERY:C277([Order:3];  & [Order:3]customerPO:3=$tempPO)
		$k:=Records in selection:C76([Order:3])
		If ($k>0)
			//CONFIRM("CANCEL ORDER, there are "+String($k)+" orders for this customer with this PO number."+"\r"+"\r"+"Click OK to CANCEL this Order"+"\r"+"\r"+"Click CANCEL to continue with this Order.")
			// ### jwm ### 20150810_2351
			CONFIRM:C162("ERROR: DUPLICATE PO NUMBER\r\r There are "+String:C10($k; "###,###,##0")+" orders for this customer account\r with PO Number \""+$tempPO+"\""; " Cancel Order "; " Continue ")
			
			POP RECORD:C177([Order:3])
			//[Order]CustPONum:=$tempPO
			If (OK=1)
				jCancelButton
			End if 
		Else 
			POP RECORD:C177([Order:3])
		End if 
	End if 
End if 
// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; Self:C308)