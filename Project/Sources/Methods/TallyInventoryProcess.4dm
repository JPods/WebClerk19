//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-22T00:00:00, 11:50:25
// ----------------------------------------------------
// Method: TallyInventoryProcess
// Description
// Modified: 08/22/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($CntLock; $i2; $k2)
C_LONGINT:C283($jrnlCnt)
C_BOOLEAN:C305($ItemLocked; $doMessage)
C_TEXT:C284($GLSource; $Source)
C_REAL:C285($itemSplit; $dQty; $valueChg; $vr2)
C_REAL:C285($vr2; $vr3)
$CntLock:=0
MESSAGES OFF:C175
GL_SumRayInit(0)

$GLSource:="SJ "+String:C10($jrnlCnt; "0000-0000")+"_T"
CREATE EMPTY SET:C140([SalesJournal:50]; "NoInsight")
vText1:=""
READ WRITE:C146([DInventory:36])
READ WRITE:C146([Item:4])
READ WRITE:C146([InventoryStack:29])
QUERY:C277([DInventory:36]; [DInventory:36]dtItemCard:16=0)
ORDER BY:C49([DInventory:36]; [DInventory:36]itemNum:1)
$k2:=Records in selection:C76([DInventory:36])
If ($k2>0)
	$jrnlCnt:=CounterNew(->[SalesJournal:50])
	FIRST RECORD:C50([DInventory:36])
	$i2:=0
	While ($k2>$i2)
		LOAD RECORD:C52([DInventory:36])
		$partNum:=[DInventory:36]itemNum:1
		
		$NoPart:=False:C215
		$ItemLocked:=False:C215
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
		If (Records in selection:C76([Item:4])=0)
			$NoPart:=True:C214
		End if 
		LOAD RECORD:C52([Item:4])
		While (($partNum=[DInventory:36]itemNum:1) & ($k2>$i2))
			Case of   //September 6, 1995
				: ([DInventory:36]dtItemCard:16#0)  //processed by someone else after search complete   
					//drop without doubling the change        
				: ($NoPart)
					LOAD RECORD:C52([DInventory:36])
					If (Not:C34(Locked:C147([DInventory:36])))
						[DInventory:36]note:18:="No Item"
						[DInventory:36]dtItemCard:16:=DateTime_DTTo
						SAVE RECORD:C53([DInventory:36])
					End if 
				: (Not:C34(Locked:C147([Item:4])))
					LOAD RECORD:C52([DInventory:36])
					If ((Not:C34(Locked:C147([DInventory:36]))) & ([DInventory:36]dtItemCard:16=0))
						$dInvtLocked:=False:C215
						If ([Item:4]notTracked:56)
							[DInventory:36]dtItemCard:16:=DateTime_DTTo
							If (([DInventory:36]qtyOnHand:2>0) | (([DInventory:36]typeID:14="PO") & ([DInventory:36]qtyOnHand:2#0)))
								createInShip  //(->[dInventory]ItemNum;[dInventory]QtyOnHand;->[dInventory]Reason;[dInventory]JobID;[dInventory]DocID;->[dInventory]custVendID;[dInventory]UnitCost;[dInventory]LineNum;[dInventory]ReceiptID;[dInventory]typeID;[dInventory]NonProdCost;[dInventory]Duties;[dInventory]VaTax)//;$nonProd;$vaTax)
							End if 
							[DInventory:36]qtyOHAfterApplied:31:=[Item:4]qtyOnHand:14
						Else 
							$NewQty:=[Item:4]qtyOnHand:14+[DInventory:36]qtyOnHand:2
							[DInventory:36]qtyOHAfterApplied:31:=$NewQty
							$dQty:=Abs:C99([DInventory:36]qtyOnHand:2+Num:C11([DInventory:36]qtyOnHand:2=0))  //dangerous            
							Case of   //all cases of inventory change need to match between this procedure and TallyInventory
									// ### jwm ### 20131004_1417 Work Order Transfers handled below line 250
									// : ([dInventory]typeID="WT@")
									// ItemSiteTally 
								: ([DInventory:36]typeID:14="Ch")
									$dQty:=[Item:4]qtyOnHand:14  //no real change in qty
									Case of 
										: (([DInventory:36]qtyOnAdj:6=0) | ([Item:4]qtyOnHand:14<=0))  //just a non-prod or there is no inventory
											$vr2:=Abs:C99(([DInventory:36]nonProdCost:25+[DInventory:36]duties:26+[DInventory:36]vaTax:27)+([DInventory:36]qtyOnAdj:6*[DInventory:36]unitCost:7))
											$vr3:=0
											If ([DInventory:36]division:29#"")
												$Source:=$GLSource+"["+[DInventory:36]division:29+"]"
											End if 
											If ([DInventory:36]nonProdCost:25+[DInventory:36]duties:26>0)
												GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
												GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
											Else 
												GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
												GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
											End if 
											
										: ([DInventory:36]qtyOnAdj:6<=[Item:4]qtyOnHand:14)  //&([Item]QtyOnHand>0))   
											$dQty:=$dQty+Num:C11($dQty=0)
											$dUnitCost:=Round:C94((([DInventory:36]qtyOnAdj:6*[DInventory:36]unitCost:7)+([Item:4]costAverage:13*[Item:4]qtyOnHand:14)+[DInventory:36]nonProdCost:25+[DInventory:36]duties:26+[DInventory:36]vaTax:27)/$dQty; <>tcDecimalUC)
											[Item:4]costAverage:13:=$dUnitCost
											
										: ([DInventory:36]qtyOnAdj:6>[Item:4]qtyOnHand:14)  //&([Item]QtyOnHand>0))
											C_REAL:C285($totalValue)
											//$dQty:=[dInventory]QtyOnAdj-[Item]QtyOnHand
											$itemSplit:=[Item:4]qtyOnHand:14/[DInventory:36]qtyOnAdj:6
											$totalValue:=(([DInventory:36]qtyOnAdj:6*[DInventory:36]unitCost:7)+[DInventory:36]nonProdCost:25+[DInventory:36]duties:26+[DInventory:36]vaTax:27)
											$valueChg:=Round:C94($totalValue*$itemSplit; <>tcDecimalTt)
											$vr2:=Round:C94($totalValue-$valueChg; <>tcDecimalTt)
											$vr3:=0
											[Item:4]costAverage:13:=Round:C94($valueChg+([Item:4]costAverage:13*[Item:4]qtyOnHand:14)/[Item:4]qtyOnHand:14; <>tcDecimalUC)
											If ([DInventory:36]division:29#"")
												$Source:=$GLSource+"["+[DInventory:36]division:29+"]"
											End if 
											If ($vr2>0)
												GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
												GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
											Else 
												$vr2:=-$vr2
												GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
												GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
											End if 
									End case 
								: (([DInventory:36]qtyOnHand:2>0) & ([DInventory:36]unitCost:7>=0))
									If ((<>vbLstCost) & ([DInventory:36]typeID:14="PO"))
										[Item:4]costLastInShip:47:=[DInventory:36]unitCost:7
									End if 
									[Item:4]dateLastCost:54:=Current date:C33
									If (([Item:4]costAverage:13#[DInventory:36]unitCost:7) & (<>booDoCost))
										If ([Item:4]qtyOnHand:14>=0)
											If ($NewQty#0)
												[Item:4]costAverage:13:=Round:C94((([Item:4]costAverage:13*[Item:4]qtyOnHand:14)+([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7)+[DInventory:36]nonProdCost:25+[DInventory:36]duties:26)/$NewQty; <>tcDecimalUC)
											End if 
										Else 
											//TRACE
											If ([DInventory:36]qtyOnHand:2>0)
												If ([DInventory:36]qtyOnHand:2+[Item:4]qtyOnHand:14>0)  //neg nums, reverse normal logic
													$vr2:=Abs:C99((([DInventory:36]unitCost:7-[Item:4]costAverage:13)*[Item:4]qtyOnHand:14)+[DInventory:36]nonProdCost:25+[DInventory:36]duties:26)
												Else 
													$vr2:=Abs:C99((([DInventory:36]unitCost:7-[Item:4]costAverage:13)*[DInventory:36]qtyOnHand:2)+[DInventory:36]nonProdCost:25+[DInventory:36]duties:26)
												End if 
												$vr3:=0
												If ([DInventory:36]division:29#"")
													$Source:=$GLSource+"["+[DInventory:36]division:29+"]"
												End if 
												If ([DInventory:36]unitCost:7>[Item:4]costAverage:13)
													GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
													GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
												Else 
													GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
													GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
												End if 
												vText1:=vText1+$partNum+"\t"+String:C10($vr2; <>tcFormatTt)+"\t"+String:C10([DInventory:36]idNumDoc:9)+"\t"+[DInventory:36]typeID:14+"\r"
												$dQty:=[DInventory:36]qtyOnHand:2+Num:C11([DInventory:36]qtyOnHand:2=0)  //dangerous, not a real quantity
												[Item:4]costAverage:13:=Round:C94((([DInventory:36]unitCost:7*[DInventory:36]qtyOnHand:2)+[DInventory:36]nonProdCost:25+[DInventory:36]duties:26)/$dQty; <>tcDecimalUC)
											End if 
										End if 
									End if 
								: (([DInventory:36]typeID:14="PO") & ([DInventory:36]qtyOnHand:2<0) & ([DInventory:36]unitCost:7#[Item:4]costAverage:13))
									TRACE:C157
									$vr2:=Abs:C99(([DInventory:36]unitCost:7-[Item:4]costAverage:13)*[DInventory:36]qtyOnHand:2)
									$vr3:=0
									$currentInventoryValue:=Round:C94([Item:4]costAverage:13*[Item:4]qtyOnHand:14; <>tcDecimalUC)
									$valueNegItems:=Round:C94([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7; <>tcDecimalUC)
									$qtyRemain:=[Item:4]qtyOnHand:14+[DInventory:36]qtyOnHand:2
									If ($qtyRemain>0)
										[Item:4]costAverage:13:=Round:C94(($currentInventoryValue+$valueNegItems)/$qtyRemain; <>tcDecimalUC)
									End if 
									If ([DInventory:36]division:29#"")
										$Source:=$GLSource+"["+[DInventory:36]division:29+"]"
									End if 
									If ([DInventory:36]unitCost:7<[Item:4]costAverage:13)
										GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
										GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
									Else 
										GL_JrnlSummary([Item:4]costGLAccount:22; $Source; Current date:C33; $vr2; $vr3; [DInventory:36]division:29)
										GL_JrnlSummary([Item:4]inventoryGlAccount:23; $Source; Current date:C33; $vr3; $vr2; [DInventory:36]division:29)
									End if 
									vText1:=vText1+$partNum+"\t"+String:C10($vr2; <>tcFormatTt)+"\t"+String:C10([DInventory:36]idNumDoc:9)+"\t"+[DInventory:36]typeID:14+"\r"
							End case 
							[Item:4]qtyOnHand:14:=Round:C94($NewQty; <>tciItQtyPre)  //Voided Invoice=1
							If ([DInventory:36]takeAction:19#4)  //no order, invoiced directly
								[Item:4]qtyOnSalesOrder:16:=[Item:4]qtyOnSalesOrder:16+[DInventory:36]qtyOnSO:3
							End if 
							[Item:4]qtyOnPo:20:=[Item:4]qtyOnPo:20+[DInventory:36]qtyOnPo:4
							
							If ([DInventory:36]typeID:14[[1]]="i")
								[Item:4]qtySold:25:=[Item:4]qtySold:25-[DInventory:36]qtyOnHand:2  //-qty on hand, really adding
								[Item:4]sales:49:=[Item:4]sales:49-Round:C94([DInventory:36]qtyOnHand:2*[DInventory:36]unitPrice:21; <>tcDecimalTt)
								[Item:4]costofSales:50:=[Item:4]costofSales:50-Round:C94([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7; <>tcDecimalTt)
							End if 
							//
							[DInventory:36]dtItemCard:16:=DateTime_DTTo
							$costOfTax:=0  //to be used with incoming taxes.
							If (([DInventory:36]qtyOnHand:2>0) | (([DInventory:36]typeID:14="PO") & ([DInventory:36]qtyOnHand:2#0)))
								//TRACE
								createInShip  //(->[dInventory]ItemNum;[dInventory]QtyOnHand;->[dInventory]Reason;[dInventory]JobID;[dInventory]DocID;->[dInventory]custVendID;[dInventory]UnitCost;[dInventory]LineNum;[dInventory]ReceiptID;[dInventory]typeID;[dInventory]NonProdCost;[dInventory]Duties;[dInventory]VaTax)//;$nonProd;$vaTax)
							End if 
						End if 
						If ([Item:4]pacing:57)
							[DInventory:36]pacing:23:=[Item:4]pacing:57
						End if 
						[DInventory:36]unitCostAfterChange:35:=[Item:4]costAverage:13
						SAVE RECORD:C53([DInventory:36])
					End if 
				Else 
					$ItemLocked:=True:C214
			End case 
			NEXT RECORD:C51([DInventory:36])
			$i2:=$i2+1
		End while 
		If (Modified record:C314([Item:4]))
			//TRACE
			[Item:4]qtyAvailable:73:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16-[Item:4]qtyAllocated:72
			[Item:4]qtyAvailable:73:=[Item:4]qtyAvailable:73*Num:C11([Item:4]qtyAvailable:73>0)
			SAVE RECORD:C53([Item:4])
		Else 
			If ($ItemLocked)
				$CntLock:=$CntLock+1
			End if 
		End if 
		UNLOAD RECORD:C212([Item:4])
	End while 
	UNLOAD RECORD:C212([DInventory:36])
	MESSAGES ON:C181
	//
	GL_Sum2Records(->[SalesJournal:50]; "NoInsight"; $jrnlCnt; True:C214)
	//
	GL_SumRayInit(0)
	CLEAR SET:C117("NoInsight")
	
	
	
	
	If (Size of array:C274(<>asiteIDs)>1)
		
		C_LONGINT:C283($time)
		$time:=Milliseconds:C459
		//  inclusive of line 90 and 91. 
		If (False:C215)  // this was very slow
			QUERY:C277([DInventory:36]; [DInventory:36]dtSiteID:34=0; *)
			QUERY:C277([DInventory:36];  & ; [DInventory:36]siteID:20#"")
		End if 
		
		
		
		QUERY:C277([DInventory:36]; [DInventory:36]dtSiteID:34=0)
		QUERY SELECTION:C341([DInventory:36]; [DInventory:36]siteID:20#"")
		
		
		// Modified by: William James (2014-03-27T00:00:00 Subrecord eliminated)
		// very long index search
		
		$time:=Milliseconds:C459-$time
		
		$k2:=Records in selection:C76([DInventory:36])
		If ($k2>0)
			ORDER BY:C49([DInventory:36]; [DInventory:36]itemNum:1)
			FIRST RECORD:C50([DInventory:36])
			For ($i; 1; $k2)
				ItemSiteTally
				NEXT RECORD:C51([DInventory:36])
			End for 
			FLUSH CACHE:C297
		End if 
		
	End if 
	
	
	
End if 

READ ONLY:C145([DInventory:36])
