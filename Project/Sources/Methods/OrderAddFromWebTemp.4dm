//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/16/12, 15:24:31
// ----------------------------------------------------
// Method: OrderAddFromWebTemp
// Description
// 
//
// Parameters
// ----------------------------------------------------
vText10:=Request:C163("Enter EventLogID")
If (OK=1)
	vi10:=Num:C11(vText10)
	If (vi10>0)
		QUERY:C277([WebTempRec:101]; [WebTempRec:101]idEventLog:1=vi10)
		vi2:=Records in selection:C76([WebTempRec:101])
		CONFIRM:C162("Add "+String:C10(vi2)+" lines to this order?")
		If (OK=1)
			FIRST RECORD:C50([WebTempRec:101])
			For (vi1; 1; vi2)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[WebTempRec:101]itemNum:3)
				pPartNum:=[Item:4]itemNum:1
				pDescript:=[WebTempRec:101]description:15
				pUnitCost:=[Item:4]costAverage:13
				OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; False:C215)
				aOQtyOrder{aoLineAction}:=[WebTempRec:101]qtyOrdered:4
				aoLnComment{aoLineAction}:=[WebTempRec:101]comment:13
				aOUnitPrice{aoLineAction}:=[WebTempRec:101]discountedPrice:10
				aOUnitCost{aoLineAction}:=[WebTempRec:101]cost:30
				aODescpt{aoLineAction}:=[WebTempRec:101]description:15
				OrdLnExtend(aoLineAction)
				[WebTempRec:101]posted:5:=True:C214
				SAVE RECORD:C53([WebTempRec:101])
				NEXT RECORD:C51([WebTempRec:101])
			End for 
			If (eOrdList>0)
				//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
			End if 
		End if 
	End if 
End if 
