//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k)
ARRAY TEXT:C222(aText1; 0)
ARRAY REAL:C219(aReal1; 0)
ARRAY TEXT:C222(aText2; 0)
ARRAY REAL:C219(aReal2; 0)
$Receipt:=Num:C11(Request:C163("Enter Receipt ID to check for Open Orders."))
If ((OK=1) & ($Receipt#0))
	MESSAGES OFF:C175
	QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=$Receipt)
	If (Records in selection:C76([InventoryStack:29])=0)
		jAlertMessage(9201)
	Else 
		SELECTION TO ARRAY:C260([InventoryStack:29]itemNum:2; aText1; [InventoryStack:29]qtyAvailable:14; aReal1)
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
			$relatedRecs:=Records in selection:C76([OrderLine:49])
			For ($e; 1; $relatedRecs)
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