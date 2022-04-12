//%attributes = {"publishedWeb":true}
//Procedure: Rpt_ProdByCust
C_TEXT:C284($1)
C_LONGINT:C283($i; $k; $w; $cntLn; $incLn; $doOrd)
If (<>ptPrintTable=(->[Vendor:38]))
	QUERY:C277([InventoryStack:29]; [InventoryStack:29]vendorID:10=[Vendor:38]vendorID:1; *)
	QUERY:C277([InventoryStack:29];  & [InventoryStack:29]dateEntered:3=vdDateBeg; *)
	QUERY:C277([InventoryStack:29];  & [InventoryStack:29]dateEntered:3=vdDateEnd)
	$cntLn:=Records in selection:C76([InventoryStack:29])
	FIRST RECORD:C50([InventoryStack:29])
	ARRAY TEXT:C222(aTmp35Str1; 0)
	ARRAY TEXT:C222(aTmp80Str1; 0)
	ARRAY REAL:C219(aTmpReal1; 0)
	ARRAY REAL:C219(aTmpReal2; 0)
	ARRAY REAL:C219(aTmpReal3; 0)
	ARRAY REAL:C219(aTmpReal4; 0)
	ARRAY REAL:C219(aTmpReal5; 0)
	For ($incLn; 1; $cntLn)
		$w:=Find in array:C230(aTmp35Str1; [InventoryStack:29]itemNum:2)
		If ($w=-1)
			$w:=Size of array:C274(aTmp35Str1)
			INSERT IN ARRAY:C227(aTmp35Str1; $w)
			INSERT IN ARRAY:C227(aTmp80Str1; $w)
			INSERT IN ARRAY:C227(aTmpReal1; $w)
			INSERT IN ARRAY:C227(aTmpReal2; $w)
			INSERT IN ARRAY:C227(aTmpReal3; $w)
			INSERT IN ARRAY:C227(aTmpReal4; $w)
			INSERT IN ARRAY:C227(aTmpReal5; $w)
			aTmp35Str1{$w}:=[InventoryStack:29]itemNum:2
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[InventoryStack:29]itemNum:2)
			aTmp80Str1{$w}:=[Item:4]description:7
			UNLOAD RECORD:C212([Item:4])
		End if 
		aTmpReal1{$w}:=aTmpReal1{$w}+[InventoryStack:29]qtyOnHand:9
		aTmpReal2{$w}:=aTmpReal2{$w}+([InventoryStack:29]unitCost:11*[InventoryStack:29]qtyOnHand:9)
		aTmpReal3{$w}:=aTmpReal3{$w}+[InventoryStack:29]extendedCost:17
		aTmpReal4{$w}:=aTmpReal4{$w}+[InventoryStack:29]nonProcCosts:22
		aTmpReal5{$w}:=aTmpReal5{$w}+[InventoryStack:29]duties:21
		NEXT RECORD:C51([InventoryStack:29])
	End for 
Else 
	$doOrd:=0
	If (Count parameters:C259>0)
		If ($1="Order")
			$doOrd:=1
		End if 
	End if 
	$k:=Records in selection:C76([Customer:2])
	If ($k=0)
		BEEP:C151
	Else 
		If (OK=1)
			Case of 
				: ($doOrd=0)
					QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]customerID:2=[Customer:2]customerID:1; *)
					QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]dateShipped:25>=vdDateBeg; *)
					QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]dateShipped:25<=vdDateEnd)
					$cntLn:=Records in selection:C76([InvoiceLine:54])
					FIRST RECORD:C50([InvoiceLine:54])
					ARRAY TEXT:C222(aTmp35Str1; 0)
					ARRAY TEXT:C222(aTmp80Str1; 0)
					ARRAY REAL:C219(aTmpReal1; 0)
					ARRAY REAL:C219(aTmpReal2; 0)
					ARRAY REAL:C219(aTmpReal3; 0)
					ARRAY REAL:C219(aTmpReal4; 0)
					For ($incLn; 1; $cntLn)
						$w:=Find in array:C230(aTmp35Str1; [InvoiceLine:54]itemNum:4)
						If ($w=-1)
							$w:=Size of array:C274(aTmp35Str1)
							INSERT IN ARRAY:C227(aTmp35Str1; $w)
							INSERT IN ARRAY:C227(aTmp80Str1; $w)
							INSERT IN ARRAY:C227(aTmpReal1; $w)
							INSERT IN ARRAY:C227(aTmpReal2; $w)
							INSERT IN ARRAY:C227(aTmpReal3; $w)
							INSERT IN ARRAY:C227(aTmpReal4; $w)
							aTmp35Str1{$w}:=[InvoiceLine:54]itemNum:4
							aTmp80Str1{$w}:=[InvoiceLine:54]description:5
						End if 
						aTmpReal1{$w}:=aTmpReal1{$w}+[InvoiceLine:54]qty:7
						aTmpReal2{$w}:=aTmpReal2{$w}+[InvoiceLine:54]extendedPrice:11
						aTmpReal3{$w}:=aTmpReal3{$w}+[InvoiceLine:54]extendedCost:13
						If (aTmpReal2{$w}#0)
							aTmpReal4{$w}:=Round:C94((aTmpReal2{$w}-aTmpReal3{$w})/aTmpReal2{$w}*100; 2)
						Else 
							aTmpReal4{$w}:=0
						End if 
						NEXT RECORD:C51([InvoiceLine:54])
					End for 
				: ($doOrd=1)
					QUERY:C277([OrderLine:49]; [OrderLine:49]customerID:2=[Customer:2]customerID:1; *)
					QUERY:C277([OrderLine:49];  & [OrderLine:49]dateOrdered:25>=vdDateBeg; *)
					QUERY:C277([OrderLine:49];  & [OrderLine:49]dateOrdered:25<=vdDateEnd)
					$cntLn:=Records in selection:C76([OrderLine:49])
					FIRST RECORD:C50([OrderLine:49])
					ARRAY TEXT:C222(aTmp35Str1; 0)
					ARRAY TEXT:C222(aTmp80Str1; 0)
					ARRAY REAL:C219(aTmpReal1; 0)
					ARRAY REAL:C219(aTmpReal2; 0)
					ARRAY REAL:C219(aTmpReal3; 0)
					ARRAY REAL:C219(aTmpReal4; 0)
					For ($incLn; 1; $cntLn)
						$w:=Find in array:C230(aTmp35Str1; [OrderLine:49]itemNum:4)
						If ($w=-1)
							$w:=Size of array:C274(aTmp35Str1)
							INSERT IN ARRAY:C227(aTmp35Str1; $w)
							INSERT IN ARRAY:C227(aTmp80Str1; $w)
							INSERT IN ARRAY:C227(aTmpReal1; $w)
							INSERT IN ARRAY:C227(aTmpReal2; $w)
							INSERT IN ARRAY:C227(aTmpReal3; $w)
							INSERT IN ARRAY:C227(aTmpReal4; $w)
							aTmp35Str1{$w}:=[OrderLine:49]itemNum:4
							aTmp80Str1{$w}:=[OrderLine:49]description:5
						End if 
						aTmpReal1{$w}:=aTmpReal1{$w}+[OrderLine:49]qty:6
						aTmpReal2{$w}:=aTmpReal2{$w}+[OrderLine:49]extendedPrice:11
						aTmpReal3{$w}:=aTmpReal3{$w}+[OrderLine:49]extendedCost:13
						If (aTmpReal2{$w}#0)
							aTmpReal4{$w}:=Round:C94((aTmpReal2{$w}-aTmpReal3{$w})/aTmpReal2{$w}*100; 2)
						Else 
							aTmpReal4{$w}:=0
						End if 
						NEXT RECORD:C51([OrderLine:49])
					End for 
			End case 
		End if 
	End if 
End if 