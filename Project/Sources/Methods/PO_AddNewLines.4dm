//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/01/13, 23:57:01
// ----------------------------------------------------
// Method: PO_AddNewLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (myCycle=10)  //from an order; new PO
		If ((Is new record:C668([PO:39])) & (<>vbCust2PO))
			[PO:39]shipToCompany:8:=[Order:3]company:15
			[PO:39]address1:9:=[Order:3]address1:16
			[PO:39]address2:10:=[Order:3]address2:17
			[PO:39]city:11:=[Order:3]city:18
			[PO:39]state:12:=[Order:3]state:19
			[PO:39]zip:13:=[Order:3]zip:20
			[PO:39]country:14:=[Order:3]country:21
			[PO:39]attention:26:=[Order:3]attention:44
			[PO:39]phone:15:=[Order:3]phone:67
			$temp:=""
			$k:=Length:C16(Storage:C1525.default.fax)
			For ($i; 1; $k)
				$w:=Character code:C91(Storage:C1525.default.fax[[$i]])
				$temp:=$temp+(Storage:C1525.default.fax[[$i]]*(Num:C11(($w>47) & ($w<58))))  //
			End for 
			[PO:39]fax:16:=[Customer:2]fax:66
			//  Put  the formating in the form  jFormatPhone(->[PO]phone; ->[PO]fax)
			[PO:39]shipDate:36:=Current date:C33
			[PO:39]shipVia:33:=[Order:3]shipVia:13
			[PO:39]shipInstruct:31:=[Order:3]shipInstruct:46
		End if 
		[PO:39]idNumProject:6:=[Order:3]projectNum:50
		[PO:39]idNumOrder:18:=[Order:3]idNum:2
		[PO:39]customerPo:34:=[Order:3]customerPO:3
		[PO:39]dateNeeded:3:=[Order:3]dateNeeded:5-[Customer:2]shippingDays:22-2
		[PO:39]buyer:7:=Current user:C182
		[PO:39]refCustomer:47:=[Order:3]company:15
		
		
	: (myCycle=11)  //from an order; existing PO
		[PO:39]idNumOrder:18:=[Order:3]idNum:2
		If ([PO:39]customerPo:34="")
			[PO:39]customerPo:34:=[Order:3]customerPO:3
		End if 
	: (myCycle=12)  //from Vendor Low Items ; new PO
		[PO:39]buyer:7:=Current user:C182
	: (myCycle=13)  //from vendor low items; existing PO
End case 
READ ONLY:C145([Item:4])
C_LONGINT:C283($index; $soa; $ordLinesSelected)

C_LONGINT:C283($foundDup)
Case of 
	: ((myCycle=10) | (myCycle=11))
		$ordLinesSelected:=Size of array:C274(aOrdLnSel)
		For ($index; 1; $ordLinesSelected)
			$foundDup:=Find in array:C230(aOrdLinesProcessed; aoUniqueID{aOrdLnSel{$index}})
			If ($foundDup<0)
				APPEND TO ARRAY:C911(aOrdLinesProcessed; aoUniqueID{aOrdLnSel{$index}})
				pQtyOrd:=aOQtyBL{aOrdLnSel{$index}}
				
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{aOrdLnSel{$index}})
				Case of 
					: (Records in selection:C76([Item:4])>1)
						ConsoleMessage("Multiple ItemNus: "+aOItemNum{aOrdLnSel{$index}})
					: (Records in selection:C76([Item:4])=0)
						ConsoleMessage("No ItemNum: "+aOItemNum{aOrdLnSel{$index}})
					Else 
						listItemsFill(->[PO:39]; True:C214)  //[Item] selection may be empty
						$soa:=Size of array:C274(aPOOrdRef)
						If ((aOLocation{aOrdLnSel{$index}}<0) | (Record number:C243([Item:4])=-1))  //&(aOLocation{aOrdLnSel{$index}}>-150))      
							Case of 
								: (<>vOrder2POByBLQ=2)
									aPoQtyOrder{$soa}:=aOQtyOrder{aOrdLnSel{$index}}
								: (<>vOrder2POByBLQ=3)
									aPoQtyOrder{$soa}:=aOQtyBL{aOrdLnSel{$index}}
								Else 
									aPoQtyOrder{$soa}:=0
							End case 
							// Modified by: williamjames (130325)
							
							If (<>Order2POCost210=3)
								pUnitPrice:=aOUnitCost{aOrdLnSel{$index}}
								aPoUnitCost{$soa}:=pUnitPrice
							End if 
							aPOQtyBL{$soa}:=aPoQtyOrder{$soa}
							aPODescpt{$soa}:=aODescpt{aOrdLnSel{$index}}
							aPoLComment{$soa}:=aoLnComment{aOrdLnSel{$index}}
							PoLnExtend($soa)
						End if 
						If (aPoItemNum{$soa}="")
							aPoItemNum{$soa}:=aOItemNum{aOrdLnSel{$index}}
						End if 
						If (aPODescpt{$soa}="")
							aPODescpt{$soa}:=aODescpt{aOrdLnSel{$index}}
						End if 
						aPOOrdRef{$soa}:=[Order:3]idNum:2  //last line was the one added
						aPOCustRef{$soa}:=[Order:3]company:15
				End case 
			End if 
		End for 
	: ((myCycle=12) | (myCycle=13))
		For ($index; 1; Size of array:C274(aLwItmLines))
			pQtyOrd:=aLItmQtyLow{aLwItmLines{$index}}
			GOTO RECORD:C242([Item:4]; aLItmRecNum{aLwItmLines{$index}})
			listItemsFill(->[PO:39]; True:C214)
		End for 
	: ((myCycle=14) | (myCycle=15))
		For ($index; 1; Size of array:C274(aReqSelLns))
			pQtyOrd:=aRqQty{aReqSelLns{$index}}
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aRqItem{aReqSelLns{$index}})
			listItemsFill(->[PO:39]; True:C214)
		End for 
End case 
UNLOAD RECORD:C212([Item:4])
READ WRITE:C146([Item:4])
myCycle:=0
myOK:=0