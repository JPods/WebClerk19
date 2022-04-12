//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-05T00:00:00, 09:57:43
// ----------------------------------------------------
// Method: iLoOrders_pQtyOrd
// Description
// Modified: 01/05/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $start)
C_REAL:C285($origQty)
//TRACE
If (Size of array:C274(aRayLines)>0)
	vLineMod:=True:C214
	For ($i; 1; Size of array:C274(aRayLines))
		$selectedElement:=aRayLines{$i}
		If (aoLineAction{$selectedElement}#-3)  // set line to recalc
			aoLineAction{$selectedElement}:=-3000  // set line to recalc
		End if 
		
		//: ((<>vbDoSrlNums)&(aOSerialRc{$selectedElement}#<>ciSRNotSerialized))//&
		//(aCase ofRayLines{$i}>0)  
		//If (<>tcbDoSrlOrd)
		//
		//Else 
		//QtyOrd_SerialCh (pQtyOrd;aOQtyOrder{$selectedElement})
		//End if     
		Case of 
			: (([Order:3]typeSale:22="Matrix@") & (<>tcbManyType))
				//### jwm ### 20120118_0944 start
				//moved test for Item Number from OrdSetPrice to here
				aOQtyOrder{$selectedElement}:=pQtyOrd
				If (pPartNum#[Item:4]itemNum:1)
					READ ONLY:C145([Item:4])
					QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
				End if 
				//### jwm ### 20120118_0944 end
				// Modified by: William James (2013-11-18T00:00:00)
				If (Records in selection:C76([Item:4])=1)  // do not change the price if no item card is found
					OrdSetPrice(->pUnitPrice; ->pDiscnt; aOQtyOrder{$selectedElement}; ->pComm)
					aOUnitPrice{$selectedElement}:=pUnitPrice
					
					//### jwm ### 20120118_0944 start
					UNLOAD RECORD:C212([Item:4])
					READ WRITE:C146([Item:4])
				End if 
				//### jwm ### 20120118_0944 end
			: (((pQtyOrd<aOQtyShip{$selectedElement}) & (aOQtyShip{$selectedElement}>0)) | ((pQtyOrd>aOQtyShip{$selectedElement}) & (aOQtyShip{$selectedElement}<0)))
				aOQtyOrder{$selectedElement}:=aOQtyShip{$selectedElement}
				If ($selectedElement=Size of array:C274(aRayLines))
					pQtyOrd:=aOQtyShip{$selectedElement}
				End if 
				BEEP:C151
			: ((aOPQDIR{$selectedElement}>-1) & (aOPricePt{$selectedElement}#"*"))
				aOQtyOrder{$selectedElement}:=pQtyOrd
				If (<>vbItemBundle)
					
					aOQtyOrder{$selectedElement}:=Item_BundleCheck(aOItemNum{$selectedElement}; aOQtyOrder{$selectedElement})
					If ($currentQty#aOQtyOrder{$selectedElement})
						//  ?????  Set the appropriate array so a dInventory record is created
					End if 
				End if 
				QtyOrd_PriceQty($selectedElement; ->aOPQDIR; ->aOQtyOpen; ->aOItemNum; ->aOUnitPrice; ->aODiscnt; ->aOSalesRate; ->aORepRate)
				
				
				
			Else 
				If (aOLnCmplt{$selectedElement}="")
					aOQtyOrder{$selectedElement}:=pQtyOrd
					Case of 
						: ((pQtyOrd<aOQtyOrder{$selectedElement}) & (aOQtyOrder{$selectedElement}>0))
							//  aOLnCmplt{$selectedElement}:=""
							
						: ((pQtyOrd>aOQtyOrder{$selectedElement}) & (aOQtyOrder{$selectedElement}<0))
							//  aOLnCmplt{$selectedElement}:=""
					End case 
				Else 
					Case of 
						: ((pQtyOrd>aOQtyOrder{$selectedElement}) & (pQtyOrd>aOQtyShip{$selectedElement}))  // positive number
							aOLnCmplt{$selectedElement}:=""
							aOQtyOrder{$selectedElement}:=pQtyOrd
							aOQtyCanceled{$selectedElement}:=0
							aOQtyBL{$selectedElement}:=aOQtyOrder{$selectedElement}-aOQtyShip{$selectedElement}
						: ((pQtyOrd<aOQtyOrder{$selectedElement}) & (pQtyOrd<aOQtyShip{$selectedElement}))  // negative values
							aOLnCmplt{$selectedElement}:=""
							aOQtyOrder{$selectedElement}:=pQtyOrd
							aOQtyCanceled{$selectedElement}:=0
							aOQtyBL{$selectedElement}:=aOQtyOrder{$selectedElement}-aOQtyShip{$selectedElement}
							
						: (True:C214)  // drop out. but keep the following as a reference
							
							
						: ((pQtyOrd>aOQtyOrder{$selectedElement}) & (aOQtyOrder{$selectedElement}>0))
							aOLnCmplt{$selectedElement}:=""
							aOQtyOrder{$selectedElement}:=pQtyOrd
							aOQtyCanceled{$selectedElement}:=0
							aOQtyBL{$selectedElement}:=aOQtyOrder{$selectedElement}-aOQtyShip{$selectedElement}
						: ((pQtyOrd<aOQtyOrder{$selectedElement}) & (aOQtyOrder{$selectedElement}<0))
							aOLnCmplt{$selectedElement}:=""
							aOQtyOrder{$selectedElement}:=pQtyOrd
							aOQtyCanceled{$selectedElement}:=0
							aOQtyBL{$selectedElement}:=aOQtyOrder{$selectedElement}-aOQtyShip{$selectedElement}
					End case 
				End if 
				If (<>vbItemBundle)
					C_REAL:C285($currentQty)
					$currentQty:=aOQtyOrder{$selectedElement}
					aOQtyOrder{$selectedElement}:=Item_BundleCheck(aOItemNum{$selectedElement}; aOQtyOrder{$selectedElement})
					If ($currentQty#aOQtyOrder{$selectedElement})
						//  ?????  Set the appropriate array so a dInventory record is created
					End if 
				End if 
		End case 
		OrdLnExtend($selectedElement)
	End for 
	vbRefreshLines:=True:C214
End if 