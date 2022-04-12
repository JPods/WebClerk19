//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 04/17/02
	//Who: Janani, Arkware
	//Description: This will generate the Order report based on the Vendor Invoice#
	VERSION_960
End if 


C_LONGINT:C283($i; $k; $vLoop1; $vLoop2)
ARRAY TEXT:C222(aText1; 0)
ARRAY REAL:C219(aReal1; 0)
ARRAY TEXT:C222(aText2; 0)
ARRAY REAL:C219(aReal2; 0)
ARRAY LONGINT:C221($aReceipt; 0)
$VendInvNum:=Request:C163("Enter Vendor Invoice# to check for Open Orders.")
TRACE:C157
If ((OK=1) & ($VendInvNum#""))
	MESSAGES OFF:C175
	QUERY:C277([POReceipt:95]; [POReceipt:95]vendorInvoiceNum:4=$VendInvNum)
	If (Records in selection:C76([POReceipt:95])=0)
		jAlertMessage(9201)
	Else 
		SELECTION TO ARRAY:C260([POReceipt:95]idNum:1; $aReceipt)  // if more than one Receipt ID found for a given Vendor Invoice#
		
		For ($vLoop1; 1; Size of array:C274($aReceipt))  //loop to get the records selection for each ReceiptID criteria
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=$aReceipt{$vLoop1})
			If (Records in selection:C76([InventoryStack:29])#0)
				FIRST RECORD:C50([InventoryStack:29])
				For ($vLoop2; 1; Records in selection:C76([InventoryStack:29]))
					INSERT IN ARRAY:C227(aReal1; 1)
					INSERT IN ARRAY:C227(aText1; 1)
					aReal1{1}:=[InventoryStack:29]qtyAvailable:14
					aText1{1}:=[InventoryStack:29]itemNum:2
					NEXT RECORD:C51([InventoryStack:29])
				End for 
			End if 
		End for 
		If (Size of array:C274(aText1)=0)  //test once the array to make sure some results were returned for the ReceiptID
			//If (Records in selection([InvStack])=0)
			jAlertMessage(9201)
		Else 
			
			//SELECTION TO ARRAY([InvStack]ItemNum;aText1;[InvStack]QtyAvailable;aReal1)
			SORT ARRAY:C229(aText1; aReal1)
			$k:=Size of array:C274(aReal1)
			For ($i; 1; $k)
				$w:=Find in array:C230(aText2; aText1{$i})
				If ($w=-1)
					INSERT IN ARRAY:C227(aText2; 1; 1)
					INSERT IN ARRAY:C227(aReal2; 1; 1)
					aText2{1}:=aText1{$i}
					aReal2{1}:=aReal1{$i}
				Else 
					aReal2{$w}:=aReal2{$w}+aReal1{$i}
				End if 
			End for 
			QUERY:C277([Order:3]; [Order:3]dateInvoiceComp:6=!00-00-00!; *)
			QUERY:C277([Order:3];  | [Order:3]dateInvoiceComp:6=!1901-01-01!)
			$k:=Records in selection:C76([Order:3])
			ORDER BY:C49([Order:3]; [Order:3]dateNeeded:5; [Order:3]dateOrdered:4)
			CREATE EMPTY SET:C140([Order:3]; "Current")
			FIRST RECORD:C50([Order:3])
			For ($i; 1; $k)
				$e:=0
				$addSet:=False:C215
				QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
				FIRST RECORD:C50([Order:3])
				$relatedRec:=Records in selection:C76([OrderLine:49])
				For ($e; 1; $relatedRec)
					If ([OrderLine:49]qtyBackLogged:8>0)
						$w:=Find in array:C230(aText2; [OrderLine:49]itemNum:4)
						If ($w>0)
							If (aReal2{$w}>0)
								aReal2{$w}:=aReal2{$w}-[OrderLine:49]qtyBackLogged:8
								ADD TO SET:C119([Order:3]; "Current")
							End if 
						End if 
					End if 
					NEXT RECORD:C51([OrderLine:49])
				End for 
				NEXT RECORD:C51([Order:3])
			End for 
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			ARRAY TEXT:C222(aText1; 0)
			ARRAY REAL:C219(aReal1; 0)
			ARRAY TEXT:C222(aText2; 0)
			ARRAY REAL:C219(aReal2; 0)
			ProcessTableOpen(->[Order:3])
			MESSAGES ON:C181
		End if 
	End if 
End if 