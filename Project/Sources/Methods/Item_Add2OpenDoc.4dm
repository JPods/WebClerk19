//%attributes = {"publishedWeb":true}
//Method: Item_Add2OpenDoc
C_POINTER:C301($1)
C_TEXT:C284($2; $3)
C_REAL:C285($4; $5; $6)
C_TEXT:C284($7; $addDescript)
$addDescript:=""
$qtyOrd:=0
$unitPrice:=0
$theDiscount:=0
C_REAL:C285($qtyOrd; $unitPrice; $theDiscount)
If (Count parameters:C259>1)
	If (Count parameters:C259>2)
		$pricePoint:=$3
		If (Count parameters:C259>3)
			$qtyOrd:=$4
			If (Count parameters:C259>5)
				$unitPrice:=$5
				If (Count parameters:C259>5)
					$theDiscount:=$6
					If (Count parameters:C259>6)
						$addDescript:=$7
					End if 
				End if 
			End if 
		End if 
	End if 
	If ([Item:4]itemNum:1#$2)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$2)
	End if 
	If (Records in selection:C76([Item:4])=1)
		If ($qtyOrd=0)
			$qtyOrd:=[Item:4]qtySaleDefault:15
		End if 
		Case of 
			: ($1=(->[Proposal:42]))
				If ($pricePoint#"")
					[Proposal:42]typeSale:20:=$pricePoint
				End if 
				pPartNum:=[Item:4]itemNum:1
				pDescript:=[Item:4]description:7
				[Item:4]qtySaleDefault:15:=$qtyOrd  //do not save item
				viPrplLnCnt:=viPrplLnCnt+1
				PpLnAdd((Size of array:C274(aPLineNum)+1); 1; True:C214)
				//aOQtyOrder{aoLineAction}:=$qtyOrd
				If ($addDescript#"")
					aPDescpt{aPLineAction}:=$addDescript+", "+aPDescpt{aPLineAction}
				End if 
				If (($unitPrice#0) | ($theDiscount#0))
					If ($theDiscount=-999)
						If ($unitPrice>0)
							aPUnitPrice{aPLineAction}:=Round:C94($unitPrice/$qtyOrd; <>tcDecimalUP+3)
							pUnitPrice:=aPUnitPrice{aPLineAction}
						Else 
							aPUnitPrice{aPLineAction}:=1
							pUnitPrice:=1
						End if 
					Else 
						If ($unitPrice#0)
							aPUnitPrice{aPLineAction}:=$unitPrice
						End if 
						If ($theDiscount#0)
							aPDiscnt{aPLineAction}:=$theDiscount
						End if 
					End if 
					PpLnExtend(aPLineAction)
				End if 
				If (ePropList>0)
					//  --  CHOPPED  AL_UpdateArrays(ePropList; -2)
				End if 
			: ($1=(->[Order:3]))
				If ($pricePoint#"")
					[Order:3]typeSale:22:=$pricePoint
				End if 
				pPartNum:=[Item:4]itemNum:1
				pDescript:=[Item:4]description:7
				[Item:4]qtySaleDefault:15:=$qtyOrd  //do not save item
				viOrdLnCnt:=viOrdLnCnt+1
				OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; True:C214)
				If ($addDescript#"")
					aODescpt{aoLineAction}:=aODescpt{aoLineAction}+", "+$addDescript
				End if 
				If (($unitPrice#0) | ($theDiscount#0))
					If ($theDiscount=-999)
						If ($unitPrice>0)
							aOUnitPrice{aoLineAction}:=Round:C94($unitPrice/$qtyOrd; <>tcDecimalUP+3)
							pUnitPrice:=aPUnitPrice{aPLineAction}
						Else 
							aOUnitPrice{aoLineAction}:=1
							pUnitPrice:=1
						End if 
					Else 
						If ($unitPrice#0)
							aOUnitPrice{aoLineAction}:=$unitPrice
						End if 
						If ($theDiscount#0)
							aODiscnt{aoLineAction}:=$theDiscount
						End if 
					End if 
					OrdLnExtend(aoLineAction)
				End if 
				If (eOrdList>0)
					//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
				End if 
				//: ($1=(->[Invoice]))
				//pPartNum:=[Item]ItemNum
				//pDescript:=[Item]Description
				//[Item]QtySaleDefault:=$qtyOrd//do not save item
				//viPrplLnCnt:=1
				//PpLnAdd ((Size of array(aPLineNum)+1);1;True)
				////aOQtyOrder{aoLineAction}:=$pQtyOrd
				//If (($unitPrice#0)|($theDiscount#0))
				//If ($unitPrice#0)
				//aPUnitPrice{aPLineAction}:=$unitPrice
				//End if 
				//If ($theDiscount#0)
				//aPDiscnt{aPLineAction}:=$theDiscount
				//End if 
				//PpLnExtend (aPLineAction)
				//End if 
				//: ($1=(->[PO]))
				//pPartNum:=[Item]ItemNum
				//pDescript:=[Item]Description
				//[Item]QtySaleDefault:=$qtyOrd//do not save item
				//viPrplLnCnt:=1
				//PpLnAdd ((Size of array(aPLineNum)+1);1;True)
				////aOQtyOrder{aoLineAction}:=$pQtyOrd
				//If (($unitPrice#0)|($theDiscount#0))
				//If ($unitPrice#0)
				//aPUnitPrice{aPLineAction}:=$unitPrice
				//End if 
				//If ($theDiscount#0)
				//aPDiscnt{aPLineAction}:=$theDiscount
				//End if 
				//PpLnExtend (aPLineAction)
				//End if 
		End case 
	Else 
		If (allowAlerts_boo)
			BEEP:C151
		End if 
	End if 
Else 
	If (allowAlerts_boo)
		BEEP:C151
	End if 
End if 


