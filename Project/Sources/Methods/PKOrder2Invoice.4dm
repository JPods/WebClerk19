//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PKOrder2Invoice
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//KeyModifierCurrent 
//TRACE
C_LONGINT:C283($0)
C_LONGINT:C283($1; $k)
C_LONGINT:C283($incRec; $i; $k; $cntRec; $cntPacks; $incPacks)
If (Count parameters:C259=1)
	$k:=$1
Else 
	$k:=Size of array:C274(aShipSel)
End if 
Case of 
	: (Records in selection:C76([Order:3])#1)
		ALERT:C41("An Order must be loaded")
	: ($k=0)
		ALERT:C41("No packages selected")
	Else 
		C_LONGINT:C283($incLoadItem; $cntLoadItem; $myOK)
		$myOK:=1
		For ($i; 1; $k)
			If (aPKInvoiceNum{aShipSel{$i}}>0)
				$myOK:=0
				$i:=$k
			End if 
		End for 
		If ($myOK=1)
			ok:=1
			$cntOrdLines:=Size of array:C274(aOBackLog)
			For ($incOrdLines; 1; $cntOrdLines)
				If (aOBackLog{$incOrdLines}>0)
					$incOrdLines:=$cntOrdLines
					If (allowAlerts_boo)
						CONFIRM:C162("Order NOT Complete, Continue??")
						If (OK=1)
							CONFIRM:C162("Are You Sure! This Order is NOT Complete, Continue??")
						End if 
					End if 
				Else 
					OK:=1
				End if 
			End for 
			If (OK=1)
				C_LONGINT:C283($dtNow)
				$dtNow:=DateTime_DTTo
				//CONFIRM("Invoice "+String($k)+" packages.")
				//If (OK=1)
				//TRACE
				CREATE EMPTY SET:C140([LoadItem:87]; "Current")
				For ($i; 1; $k)
					// Modified by: Bill James (2017-06-02T00:00:00)
					// QUERY([LoadItem];[LoadItem]LoadTagID=aPKUniqueID{aShipSel{$i}};*)  //get each Load Item
					// QUERY([LoadItem]; & [LoadItem]InvoiceNum=0)
					QUERY:C277([LoadItem:87]; [LoadItem:87]idNumLoadTag:8=aPKUniqueID{aShipSel{$i}})  //get each Load Item
					SetAddTo(->[LoadItem:87]; "Current")
				End for 
				USE SET:C118("Current")
				//CLEAR SET("Current")
				ARRAY LONGINT:C221(aPKLoadItemID; 0)
				ARRAY LONGINT:C221(aPKLoadItemRecNum; 0)
				ARRAY LONGINT:C221(aPKOrderLineID; 0)
				SELECTION TO ARRAY:C260([LoadItem:87]; aPKLoadItemRecNum; [LoadItem:87]idNum:16; aPKLoadItemID; [LoadItem:87]lineid:5; aPKOrderLineID)
				SORT ARRAY:C229(aPKOrderLineID; aPKLoadItemID; aPKLoadItemRecNum)
				//
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
				QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
				
				
				$cntOrdLines:=Records in selection:C76([OrderLine:49])
				OrdLnFillRays
				//
				vbForceShip:=False:C215  //  must be set to true to fill Invoice
				
				//  qqq do not think this is needed for true
				
				vPackingProcess:="PK"  //  Need to set that the changes are caused by the Packing Window
				// Modified by: William James (2014-04-23T00:00:00 Subrecord eliminated)
				
				vHere:=1  // 
				CREATE RECORD:C68([Invoice:26])
				createInvoice(vbForceShip)
				//  
				
				// Modified by: William James (2014-04-24T00:00:00 InvoiceLineArrays do not reflect packing Qtys)
				
				[Invoice:26]siteID:86:=vsiteID
				
				booaccept:=True:C214
				acceptInvoice
				C_LONGINT:C283($thisInvoice)
				$thisInvoice:=[Invoice:26]idNum:2
				//End for 
				//
				$k:=Size of array:C274(aShipSel)
				For ($i; 1; $k)  //record changed in PKInvoiceLines
					//QUERY([LoadTag];[LoadTag]UniqueID=aPKUniqueID{aShipSel{$i}})
					aPKStatus{aShipSel{$i}}:="Shipped"
					aPKInvoiceNum{aShipSel{$i}}:=[Invoice:26]idNum:2
				End for 
				If (eShipList>0)
					//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
					viVert:=aShipSel{1}
					// -- AL_SetSelect(eShipList; aShipSel)
					// -- AL_SetScroll(eShipList; viVert; viHorz)
				End if 
				//          
				READ WRITE:C146([LoadItem:87])
				USE SET:C118("Current")
				CLEAR SET:C117("Current")
				C_LONGINT:C283($cntLoadItems; $incLoadItems)
				$cntLoadItems:=Records in selection:C76([LoadItem:87])  //Size of array(aPKLoadItemRecNum)
				FIRST RECORD:C50([LoadItem:87])
				For ($incLoadItems; 1; $cntLoadItems)
					//GOTO RECORD([LoadItem];aPKLoadItemRecNum{$incLoadItems})
					[LoadItem:87]invoiceNum:14:=[Invoice:26]idNum:2
					[LoadItem:87]customerID:18:=[Invoice:26]customerID:3
					[LoadItem:87]customerPO:17:=[Invoice:26]customerPO:29
					[LoadItem:87]dtShipOn:19:=$dtNow
					
					SAVE RECORD:C53([LoadItem:87])
					NEXT RECORD:C51([LoadItem:87])
				End for 
				LT_FillArrayLoadItems(0)
				//READ ONLY([LoadItem])
				//  
				UNLOAD RECORD:C212([Invoice:26])
				UNLOAD RECORD:C212([Order:3])
				UNLOAD RECORD:C212([LoadTag:88])
			End if 
			//fill invoice array
			// TRACE
			If (eInvoiceList>0)  // in the Packing window
				QUERY:C277([Invoice:26]; [Invoice:26]idNumOrder:1=srSO)
				PKInvoiceFillArrays(Records in selection:C76([Invoice:26]); 0; 0; eInvoiceList)  //eInvoiceList)  
				C_LONGINT:C283($foundInvoice)
				$foundInvoice:=Find in array:C230(aInvoices; $thisInvoice)
				If ($foundInvoice>0)
					ARRAY LONGINT:C221(aInvoiceRecSel; 1)
					aInvoiceRecSel{1}:=$foundInvoice
					//  --  CHOPPED  AL_UpdateArrays(eInvoiceList; -2)  //Size of array(aInvoices))
					viVert:=$foundInvoice
					// -- AL_SetSelect(eInvoiceList; aInvoiceRecSel)
					// -- AL_SetScroll(eInvoiceList; viVert; viHorz)
				End if 
			End if 
		End if 
End case 
// Clear the variables for forcing Orders to behave based on Packing
vbForceShip:=False:C215

vPackingProcess:=""
$0:=[Invoice:26]idNum:2
