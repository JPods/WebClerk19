//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 11:32:10
// ----------------------------------------------------
// Method: OrdLineCalc
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(<>logLineDetails)



C_LONGINT:C283($i; $w; $k; $wOrig)
C_REAL:C285($dOnOrd; $dOnHand)
$dOnHand:=0  //### jwm ### 20130410_1703 changes to order lines should never effect inventory 

$k:=Size of array:C274(aoLinesDelete)
For ($i; 1; $k)
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoLinesDelete{$i})
	If (Records in selection:C76([OrderLine:49])=1)
		// ### bj ### 20181220_1806
		// if this is important, save the current record into an object
		// LogReportDetail (->[OrderLine];"OrderLine Delete, Item: "+[OrderLine]ItemNum)
		$dOnOrd:=[OrderLine:49]qtyBackLogged:8*Num:C11([OrderLine:49]qtyBackLogged:8>0)
		Invt_dRecCreate("SO"; [Order:3]orderNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "ord void ln"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; $dOnHand; -$dOnOrd; [OrderLine:49]unitCost:12; ""; [Order:3]siteid:106; DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP))
		$script:="[SyncRecord]TextSample:="+Txt_Quoted("Deleted Line from Order: ")+"+string([OrderLine]ordernum)"
		//RP_CreateSyncRecord (->[OrderLine];$script)  //just builds the Sync Record
		DELETE RECORD:C58([OrderLine:49])
	End if 
End for 

$k:=Size of array:C274(AOUNIQUEID)
For ($i; 1; $k)
	If ((AOUNIQUEID{$i}#-3) & (aoLineAction{$i}#10))  // new line and no change
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=AOUNIQUEID{$i})
	End if 
	aOSeq{$i}:=$i  // make sure the current sequence is saved in the line record
	If (aoLineAction{$i}=10)
		aoLineAction{$i}:=-3000
	End if 
	Case of 
		: (aoLineAction{$i}=10)  // no change to the line 
			// should never be called. Had been previously set in LT_FillArrayLoadItems
			
			//  TRACE  // this should never be called unless the order was not recalculated
			// check web behavior  
			// qqqq
		: (AOUNIQUEID{$i}=-3)  // (Records in selection([OrderLine])=0)
			CREATE RECORD:C68([OrderLine:49])
			OrdLn_RecordFill($i)
			//$dOnHand:=-aOQtyShip{$i}//takes a way from on hand
			//### jwm ### 20130410_1704 $dOnHand set to 0 above changes to Order lines should never effect inventory
			$dOnOrd:=aOQtyOrder{$i}  //*Num(aOQtyOrder{$i}>0)
			//increases on Order   unless negative  
			//Invt_dRecCreate ("SO";[Order]OrderNum;0;[Order]customerID;[Order]projectNum;"oi new line";1;[OrderLine]LineNum;[OrderLine]ItemNum;$dOnHand;$dOnOrd;[OrderLine]UnitCost;"";<>tcsiteID;DiscountApply ([OrderLine]UnitPrice;[OrderLine]Discount;<>tcDecimalUP))
			//### jwm ### 20130621_1327 changed <>tcsiteID to [Order]siteID
			Invt_dRecCreate("SO"; [Order:3]orderNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "oi new line"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; $dOnHand; $dOnOrd; [OrderLine:49]unitCost:12; ""; [Order:3]siteid:106; DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP))
			aoLineAction{$i}:=3  //selected record number if Relate File
			If ((<>linkProposal) & ([Order:3]proposalNum:79>0))
				//TRACE
				READ WRITE:C146([ProposalLine:43])
				QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Order:3]proposalNum:79; *)
				QUERY:C277([ProposalLine:43];  & [ProposalLine:43]lineNum:43=[OrderLine:49]lineNum:3)
				If (Records in selection:C76([ProposalLine:43])=1)
					[ProposalLine:43]qtyOpen:51:=[ProposalLine:43]qtyOpen:51-$dOnOrd
					SAVE RECORD:C53([ProposalLine:43])
					If (([Proposal:42]proposalNum:5=[Order:3]proposalNum:79) & (Size of array:C274(aPQtyOpen)>0))
						$w:=Find in array:C230(aPLineNum; aOLineNum{$i})
						If ($w>0)
							aPQtyOpen{$w}:=[ProposalLine:43]qtyOpen:51
						End if 
					End if 
				End if 
				READ ONLY:C145([ProposalLine:43])
			End if 
		: (aoLineAction{$i}=-3000)  //During of Order sets to - if it was changed.
			$dOrderQty:=aOQtyBL{$i}-[OrderLine:49]qtyBackLogged:8
			If ($dOrderQty#0)
				//Invt_dRecCreate ("SO";[Order]OrderNum;0;[Order]customerID;[Order]projectNum;"ord changed";1;[OrderLine]UniqueID;[OrderLine]ItemNum;0;$dOrderQty;[orderLine]UnitCost;"";<>tcsiteID;DiscountApply ([orderLine]UnitPrice;[orderLine]Discount;<>tcDecimalUP))
				//### jwm ### 20130410_1627 changed from <>tcsiteID to [Order]siteID
				Invt_dRecCreate("SO"; [Order:3]orderNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "ord changed"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; $dOnHand; $dOrderQty; [OrderLine:49]unitCost:12; ""; [Order:3]siteid:106; DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP))
			End if 
			OrdLn_RecordFill($i)  // save orderline after accounting for changes
		: (aoLineAction{$i}=-2000)  //  ????? what is this
			If (([OrderLine:49]qtyOrdered:6#aOQtyOrder{$i}) | ([OrderLine:49]qtyShipped:7#aOQtyShip{$i}))  // coming from packing window
				$dOrderQty:=aOQtyBL{$i}-[OrderLine:49]qtyBackLogged:8
				
				If (vPackingProcess="PK")
					//Invt_dRecCreate ("PK";[Order]OrderNum;0;[Order]customerID;[Order]projectNum;"packed";1;[OrderLine]UniqueID;[OrderLine]ItemNum;$dOnHand;$dOrderQty;aOUnitCost{$w};"";<>tcsiteID;DiscountApply ([orderLine]UnitPrice;[orderLine]Discount;<>tcDecimalUP))
					//### jwm ### 20130410_1630 changed <>tcsiteID to vsiteID (chack to make sure coming from packing window)
					Invt_dRecCreate("PK"; [Order:3]orderNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "packed"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; $dOnHand; $dOrderQty; aOUnitCost{$w}; ""; vsiteID; DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP))
				Else 
					//Invt_dRecCreate ("SO";[Order]OrderNum;0;[Order]customerID;[Order]projectNum;"oi ext qty";1;[OrderLine]UniqueID;[OrderLine]ItemNum;$dOnHand;$dOrderQty;aOUnitCost{$w};"";<>tcsiteID;DiscountApply ([orderLine]UnitPrice;[orderLine]Discount;<>tcDecimalUP))
					//### jwm ### 20130410_1629 changed from <>tcsiteID to [Order]siteID
					Invt_dRecCreate("SO"; [Order:3]orderNum:2; 0; [Order:3]customerID:1; [Order:3]projectNum:50; "oi ext qty"; 1; [OrderLine:49]idNum:50; [OrderLine:49]itemNum:4; $dOnHand; $dOrderQty; aOUnitCost{$w}; ""; [Order:3]siteid:106; DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP))
				End if 
				
				OrdLn_RecordFill($i)
			End if 
			//        
			
	End case 
End for 





