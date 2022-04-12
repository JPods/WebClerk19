C_LONGINT:C283($i)
If (Size of array:C274(aPPLnSelect)>0)
	For ($i; 1; Size of array:C274(aPPLnSelect))
		Case of 
				//: ((<>vbDoSrlNums)&(aPSerial{aPPLnSelect{$i}}#<>ciSRNotSerialized))
				//QtyOrd_SerialCh (pQtyOrd;aPQtyOrder{aPPLnSelect{$i}})
			: ((aPPQDIR{aPPLnSelect{$i}}>-1) & (aPPricePt{aPPLnSelect{$i}}#"*"))
				aPQtyOrder{aPPLnSelect{$i}}:=pQtyOrd
				If (<>vbItemBundle)
					aPQtyOrder{aPPLnSelect{$i}}:=Item_BundleCheck(aPItemNum{aPPLnSelect{$i}}; aPQtyOrder{aPPLnSelect{$i}})
				End if 
				QtyOrd_PriceQty(aPPLnSelect{$i}; ->aPPQDIR; ->aPQtyOpen; ->aPItemNum; ->aPUnitPrice; ->aPDiscnt; ->aPSalesRate; ->aPRepRate)
				//aPUnitPrice{aPPLnSelect{$i}}:=pUnitPrice
				//aPDiscnt{aPPLnSelect{$i}}:=pDiscnt
				//aPSalesRate{aPPLnSelect{$i}}:=Round(vComSales*pComm*0.01;1)
				//aPRepRate{aPPLnSelect{$i}}:=Round(vComRep*pComm*0.01;1)
			Else 
				aPQtyOrder{aPPLnSelect{$i}}:=pQtyOrd
				If (<>vbItemBundle)
					aPQtyOrder{aPPLnSelect{$i}}:=Item_BundleCheck(aPItemNum{aPPLnSelect{$i}}; aPQtyOrder{aPPLnSelect{$i}})
				End if 
		End case 
		PpLnExtend(aPPLnSelect{$i})
	End for 
	vLineMod:=True:C214
End if 