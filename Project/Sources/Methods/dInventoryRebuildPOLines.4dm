//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/07/19, 14:27:24
// ----------------------------------------------------
// Method: dInventoryRebuildPOLines
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(vScript)
Case of 
	: (vText11="Show dInventory")
		
		
		vScript:="QUERY([dInventory];[dInventory]typeID=\"PO\";*)"
		vScript:=vScript+"QUERY([dInventory]; & ;[dInventory]docID="+String:C10([PO:39]poNum:5)+")"
		ProcessTableOpen(Table:C252(->[DInventory:36]); vScript; "PO "+String:C10([PO:39]poNum:5))
		
		
	: (vText11="Show dInventory")
		
		
		CONFIRM:C162("Rebuild POLines from [dInventory]?")
		If (OK=1)
			
			QUERY:C277([DInventory:36]; [DInventory:36]typeid:14="PO"; *)
			QUERY:C277([DInventory:36];  & ; [DInventory:36]docid:9=[PO:39]poNum:5)
			vi2:=Records in selection:C76([DInventory:36])
			FIRST RECORD:C50([DInventory:36])
			vi4:=Size of array:C274(aPoItemNum)
			vi5:=vi4
			For (vi1; 1; vi2)
				vi3:=Find in array:C230(aPoItemNum; [DInventory:36]itemNum:1)
				
				If (vi3<1)
					vi5:=vi5+1
					
					CREATE RECORD:C68([POLine:40])
					[POLine:40]poNum:1:=[PO:39]poNum:5
					[POLine:40]itemNum:2:=[DInventory:36]itemNum:1
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
					
					[POLine:40]vendorID:24:=[PO:39]vendorID:1
					[POLine:40]refVendor:23:=[PO:39]vendorCompany:39
					[POLine:40]qtyOrdered:3:=[DInventory:36]qtyOnPo:4
					[POLine:40]qtyReceived:4:=0
					[POLine:40]qtyBackLogged:5:=[POLine:40]qtyOrdered:3
					[POLine:40]description:6:=[Item:4]description:7
					[POLine:40]unitCost:7:=[DInventory:36]unitCost:7
					[POLine:40]discount:8:=0
					[POLine:40]extendedCost:9:=Round:C94([POLine:40]unitCost:7*[POLine:40]qtyOrdered:3; 2)
					[POLine:40]vaTax:10:=0
					[POLine:40]taxid:11:=""
					[POLine:40]unitofMeasure:12:=[Item:4]unitofMeasure:11
					[POLine:40]backOrderAmount:13:=[POLine:40]extendedCost:9
					[POLine:40]lineNum:14:=vi5
					[POLine:40]dateExpected:15:=[PO:39]dateOrdered:2
					[POLine:40]orderNum:16:=[PO:39]orderNum:18
					[POLine:40]siteAdder:26:=0
					[POLine:40]unitWt:29:=[Item:4]weightAverage:8
					[POLine:40]dateReceived:17:=!00-00-00!
					[POLine:40]serialNum:19:=""
					[POLine:40]altItemNum:20:=[Item:4]vendorItemNum:40
					
					[POLine:40]serialRc:18:=0
					[POLine:40]refCustomer:22:=[PO:39]customerPo:34
					
					[POLine:40]comment:27:=""
					[POLine:40]nonProdCosts:28:=0
					[POLine:40]duties:30:=0
					
					[POLine:40]qtyHold:34:=0
					[POLine:40]discountedCost:35:=0
					SAVE RECORD:C53([POLine:40])
					
				End if 
				NEXT RECORD:C51([DInventory:36])
			End for 
			ALERT:C41("POLines Added :"+String:C10(vi5-vi4))
			REDUCE SELECTION:C351([DInventory:36]; 0)
			vi6:=[PO:39]poNum:5
			CANCEL:C270
		End if 
		//vScript:="QUERY([PO];[PO]PONum="+String(vi6)+")"
		// ProcessTableOpen (Table(->[PO]);vScript;"")
		
	: (vText11="Check POs")
		
		CONFIRM:C162("Check for missing POLines by [dInventory]?")
		If (OK=1)
			vi2:=Records in selection:C76([PO:39])
			FIRST RECORD:C50([PO:39])
			CREATE EMPTY SET:C140([PO:39]; "Current")
			For (vi1; 1; vi2)
				QUERY:C277([DInventory:36]; [DInventory:36]typeid:14="PO"; *)
				QUERY:C277([DInventory:36];  & ; [DInventory:36]docid:9=[PO:39]poNum:5)
				vi5:=Records in selection:C76([DInventory:36])
				
				QUERY:C277([POLine:40]; [POLine:40]poNum:1=[PO:39]poNum:5)
				vi6:=Records in selection:C76([POLine:40])
				vi7:=vi5-vi6
				If (vi7=0)
					ConsoleMessage("PO: "+String:C10([PO:39]poNum:5)+" matched with lines: "+String:C10(vi7))
				Else 
					ADD TO SET:C119([PO:39]; "Current")
					ConsoleMessage("PO: "+String:C10([PO:39]poNum:5)+" mismatches with POlines/dInventory: "+String:C10(vi5)+"/"+String:C10(vi6))
				End if 
				NEXT RECORD:C51([DInventory:36])
			End for 
			REDUCE SELECTION:C351([DInventory:36]; 0)
		End if 
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		ALERT:C41("Completed")
End case 


