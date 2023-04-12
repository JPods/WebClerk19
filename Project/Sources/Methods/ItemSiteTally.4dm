//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/12/13, 16:02:46
// ----------------------------------------------------
// Method: ItemSiteTally
// Description
// 
//
// Parameters
// ----------------------------------------------------
//  ### jwm ### 20140114_0825 changed QonWO To Negative number
//  ### jwm ### 20140114_0931 save bucket qty for audit trail
//  ### jwm ### 20140129_1009 this case copied from TallyInventoryProcess
//  processed by someone else after search complete 
//  ### jwm ### 20140212_1035 leave Errors as pending so they will tally when resolved  

READ WRITE:C146([ItemSiteBucket:136])  //  ### jwm ### 20140122_2333

C_LONGINT:C283($error)
$error:=1
LOAD RECORD:C52([DInventory:36])  //  ### jwm ### 20140122_2328
If (Size of array:C274(<>asiteIDs)>1)
	QUERY:C277([ItemSiteBucket:136]; [ItemSiteBucket:136]siteID:4=[DInventory:36]siteID:20; *)
	QUERY:C277([ItemSiteBucket:136];  & ; [ItemSiteBucket:136]itemNum:2=[DInventory:36]itemNum:1)
	FIRST RECORD:C50([ItemSiteBucket:136])  //  ### jwm ### 20140122_2330 make sure record is loaded
	
	// Modified by: William James (2014-02-12T00:00:00 Subrecord eliminated)
	// Should [dInventory]DTsiteID be set to some number like 10 to reduce a performance issue 
	
	$error:=Find in array:C230(<>asiteIDs; [DInventory:36]siteID:20)
	Case of 
			//  ### jwm ### 20140129_1009 this case copied from TallyInventoryProcess
		: ([DInventory:36]dtSiteID:34#0)  //processed by someone else after search completed   
			$error:=-4
			//drop without doubling the change    
		: (Locked:C147([DInventory:36]))
			$error:=-3
		: (Locked:C147([ItemSiteBucket:136]))  //  ### jwm ### 20140122_2359 moved here from end of case
			$error:=-2
		: ($error=1)
			[DInventory:36]review:28:="Review_LabelissiteID"
			[DInventory:36]dtSiteID:34:=0
			SAVE RECORD:C53([DInventory:36])
			$error:=-4
		: ($error<=1)
			//  There is no currently approved siteID
			[DInventory:36]review:28:="Review_NositeID"
			[DInventory:36]dtSiteID:34:=0
			SAVE RECORD:C53([DInventory:36])
		: (Records in selection:C76([ItemSiteBucket:136])=0)  // $error already has a postive value >1
			CreateItemSiteRecord([DInventory:36]siteID:20; [DInventory:36]itemNum:1)
		: (Records in selection:C76([ItemSiteBucket:136])>1)
			[DInventory:36]review:28:="Review_MultisiteID"
			[DInventory:36]dtSiteID:34:=0
			SAVE RECORD:C53([DInventory:36])
			$error:=-1
	End case 
	If ($error>1)  // no defects //  ### jwm ### 20140122_1927 changed from >= to > 
		[DInventory:36]dtSiteID:34:=DateTime_DTTo
		Case of   //all cases of inventory change need to match between this procedure and TallyInventory
			: ([DInventory:36]reason:13="WO Ship")
				//[ItemSiteBucket]Qty:=[ItemSiteBucket]Qty-[dInventory]QtyOnWO
				[ItemSiteBucket:136]qtyOnHand:5:=[ItemSiteBucket:136]qtyOnHand:5+[DInventory:36]qtyOnWO:5  //  ### jwm ### 20140114_0825 changed QonWO To Negative number
			: ([DInventory:36]reason:13="WO Receive")
				[ItemSiteBucket:136]qtyOnHand:5:=[ItemSiteBucket:136]qtyOnHand:5+[DInventory:36]qtyOnWO:5
			: ([DInventory:36]qtyOnHand:2#0)
				[ItemSiteBucket:136]qtyOnHand:5:=[ItemSiteBucket:136]qtyOnHand:5+[DInventory:36]qtyOnHand:2
		End case 
		
		//  ### jwm ### 20140123_0956 Debug [dInventory]QtyWOAfter
		// Execute_TallyMaster ("[dInventory]QtyWOAfter";"Debug")
		// go back to open tally master record read only execute text TAlly master script
		// create a separate record for each instance to avoid locked records.
		
		READ ONLY:C145([TallyMaster:60])
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="[dInventory]QtyWOAfter"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="Debug")
		If (Records in selection:C76([TallyMaster:60])=1)
			ExecuteText(0; [TallyMaster:60]script:9)  //no confirm
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
		End if 
		READ WRITE:C146([TallyMaster:60])
		
		[DInventory:36]qtyWOAfter:36:=[ItemSiteBucket:136]qtyOnHand:5  //  ### jwm ### 20140114_0931 save bucket qty for audit trail
		SAVE RECORD:C53([ItemSiteBucket:136])
		SAVE RECORD:C53([DInventory:36])
	End if 
	UNLOAD RECORD:C212([ItemSiteBucket:136])  //  ### jwm ### 20140122_2133
End if 
UNLOAD RECORD:C212([DInventory:36])  //  ### jwm ### 20140122_2133