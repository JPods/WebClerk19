//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:12:48
// ----------------------------------------------------
// Method: PKShredPackage
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Size of array:C274(aLiItemNum)>0)
	ALERT:C41("Clear Box Packing before Shreading another Box.")
Else 
	$viShipSel:=Size of array:C274(aShipSel)
	If ($viShipSel>0)
		
		
		
		For ($viIndexSel; 1; $viShipSel)
			
			Case of 
				: (aPKInvoiceNum{aShipSel{$viIndexSel}}>1)
					ALERT:C41("Void Invoice then repack: "+String:C10(aPKInvoiceNum{aShipSel{$viIndexSel}}))
				: (aPKUniqueIDSuperior{aShipSel{$viIndexSel}}>0)
					ALERT:C41("Shred higher package: "+String:C10(aPKUniqueIDSuperior{aShipSel{$viIndexSel}}))
				Else 
					If (aPKContainerType{aShipSel{$viIndexSel}}=1)
						QUERY:C277([LoadItem:87]; [LoadItem:87]idNumLoadTag:8=aPKUniqueID{aShipSel{$viIndexSel}})
						LT_FillArrayLoadItems(Records in selection:C76([LoadItem:87]))
						$viLoadItems:=Records in selection:C76([LoadItem:87])
						//TRACE
						For ($viIndexItem; 1; $viLoadItems)
							GOTO RECORD:C242([LoadItem:87]; aLiRecordNum{$viIndexItem})
							QUERY:C277([Order:3]; [Order:3]idNum:2=aLiDocID{$viIndexItem})
							QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
							$cntOrdLines:=Records in selection:C76([OrderLine:49])
							OrdLnFillRays
							$viUniqueID:=Find in array:C230(aoUniqueID; aLiLineID{$viIndexItem})
							If ($viUniqueID>0)
								aOQtyShip{$viUniqueID}:=aOQtyShip{$viUniqueID}-aLiQty{$viIndexItem}
								aOQtyBL{$viUniqueID}:=aOQtyBL{$viUniqueID}+aLiQty{$viIndexItem}
								aOLnCmplt{$viUniqueID}:=Num:C11(aOQtyBL{$viUniqueID}=0)*"x"
								aoLineAction{$viUniqueID}:=-2000
								VPACKINGPROCESS:="PK"
								booAccept:=True:C214
								vMod:=True:C214
								OrdLnExtend($viUniqueID)
								acceptOrders
							End if 
							DELETE RECORD:C58([LoadItem:87])
						End for 
						
					Else   //above package level
						QUERY:C277([LoadTag:88]; [LoadTag:88]ideSuperior:27=aPKUniqueID{aShipSel{$viIndexSel}})
						$k:=Records in selection:C76([LoadTag:88])
						FIRST RECORD:C50([LoadTag:88])
						For ($i; 1; $k)
							[LoadTag:88]ideSuperior:27:=0
							SAVE RECORD:C53([LoadTag:88])
							NEXT RECORD:C51([LoadTag:88])
						End for 
					End if 
					//
					QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1=aPKUniqueID{aShipSel{$viIndexSel}})  //clear owner line
					//TRACE
					
					DELETE RECORD:C58([LoadTag:88])
					
			End case 
		End for 
		
		QUERY:C277([LoadTag:88]; [LoadTag:88]documentID:17=[Order:3]idNum:2)  //reset order related
		PKArrayManage(Records in selection:C76([LoadTag:88]))
		If (eShipList>0)
			//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
		End if 
		TRACE:C157
		
		//CLEAR ITEM COUNT AND WEIGHT AFTER SHREDDING PACKAGE ###jwm###
		LT_FillArrayLoadItems(0)  //###_jwm_### Clear Load Items Array
		<>vrWeightTare:=0
		<>vrWeightProduct:=0
		iLoReal3:=0
		iLoReal4:=0
		iLoReal5:=0
		
		PKSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101014
	End if 
End if 