//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/19/07, 12:06:10
// ----------------------------------------------------
// Method: InvoiceLineResetPrice
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($tempBase; $i)
C_REAL:C285($price)
If (Size of array:C274(aRayLines)>0)
	$tempBase:=vUseBase
	For ($i; 1; Size of array:C274(aRayLines))
		Case of 
			: (aiPricePt{aRayLines{$i}}#"*")
				LN_PricePoint(->pPricePt; ->[Invoice:26]typeSale:49; ->aiItemNum{aRayLines{$i}}; <>ptInvoiceDateFld; ->pUnitPrice; ->pDiscnt; ->pQtyOrd; ->vR1; ->vR2; aiPQDIR{aRayLines{$i}})
				aiPricePt{aRayLines{$i}}:=pPricePt
				aiUnitPrice{aRayLines{$i}}:=pUnitPrice
				aiDiscnt{aRayLines{$i}}:=pDiscnt
				aiRepRate{aRayLines{$i}}:=vR1
				aiSalesRate{aRayLines{$i}}:=vR2
			: (aiPricePt{aRayLines{$i}}="*")
				// aiPricePt{aRayLines{$i}}:="*"  // leave as user set
				//$price:=$price+aiExtPrice{aRayLines{$i}}
				//aiUnitPrice{aRayLines{$i}}:=0
				//aiDiscnt{aRayLines{$i}}:=0
		End case 
		IvcLnExtend(aRayLines{$i})
		If (aiSerialRc{aRayLines{$i}}#<>ciSRNotSerialized)
			QUERY:C277([ItemSerial:47]; [ItemSerial:47]salesLnRefid:11=aiSerialRc{aiLineAction})
			READ WRITE:C146([ItemSerial:47])
			FIRST RECORD:C50([ItemSerial:47])
			$cntSr:=Records in selection:C76([ItemSerial:47])
			For ($incSr; 1; $cntSr)
				[ItemSerial:47]price:26:=aiUnitPriceDiscounted{aRayLines{$i}}
				SAVE RECORD:C53([ItemSerial:47])
				NEXT RECORD:C51([ItemSerial:47])
			End for 
			READ ONLY:C145([ItemSerial:47])
		End if 
	End for 
	If (False:C215)  //  (pPricePt="*")
		If (aiQtyShip{aRayLines{1}}#0)
			aiUnitPrice{aRayLines{1}}:=Round:C94($price/aiQtyShip{aRayLines{1}}; <>tcDecimalUP)
		Else 
			aiUnitPrice{aRayLines{1}}:=$price
		End if 
		IvcLnExtend(aRayLines{1})
		If (aiSerialRc{aRayLines{1}}#<>ciSRNotSerialized)
			QUERY:C277([ItemSerial:47]; [ItemSerial:47]salesLnRefid:11=aiSerialRc{aiLineAction})
			READ WRITE:C146([ItemSerial:47])
			FIRST RECORD:C50([ItemSerial:47])
			$cntSr:=Records in selection:C76([ItemSerial:47])
			For ($incSr; 1; $cntSr)
				[ItemSerial:47]price:26:=aiUnitPriceDiscounted{aRayLines{1}}
				SAVE RECORD:C53([ItemSerial:47])
				NEXT RECORD:C51([ItemSerial:47])
			End for 
			READ ONLY:C145([ItemSerial:47])
		End if 
	End if 
	If (Size of array:C274(aRayLines)>1)
		//   IvcLnFillVar(aiLineAction)
	End if 
	vLineMod:=True:C214
	vR1:=0
	vR2:=0
	vUseBase:=$tempBase
	
End if 