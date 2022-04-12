//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:31:55
// ----------------------------------------------------
// Method: Ord2InvProduct
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

If (UserInPassWordGroup("EditInvoice"))
	C_LONGINT:C283($1; $2)  //1 for add, 2 for modify
	//$2 0 for only on backorder, 1 do new invoice
	C_BOOLEAN:C305(noNavError; skipReCost)
	C_LONGINT:C283($i)
	C_REAL:C285($blq)
	$blq:=0
	//TRACE
	//BEEP  //PLAY("Sosumi")
	
	// Modified by: William James (2014-01-20T00:00:00)
	
	// If (($1=2) | ($2=1) | (<>bInvCmpOrd))  //modifying a record
	If (($1=2) | ($2=1))  //modifying a record
		$blq:=1
	Else 
		For ($i; 1; Size of array:C274(aOQtyBL))
			$blq:=$blq+Abs:C99(aOQtyBL{$i})
		End for 
	End if 
	If ($blq#0)
		If (Not:C34(booAccept))
			jAlertMessage(9200)
			ABORT:C156
		End if 
		If (newOrd)
			skipReCost:=True:C214
		Else 
			skipReCost:=False:C215
		End if 
		If (Modified record:C314([Customer:2]))
			SAVE RECORD:C53([Customer:2])
		End if 
		//myCycle:=6//Do Not CANCEL Orders
		acceptOrders  // (noNavError)
		// ### bj ### 20210427_1443
		// vbForceShip:= set to true forces shipping all BLQ
		If ($1=2)  // never called. Eliminate after harvest
			C_LONGINT:C283($curInvoiceRec)
			$curInvoiceRec:=Record number:C243([Invoice:26])
			GOTO RECORD:C242([Invoice:26]; $curInvoiceRec)
			//ONE RECORD SELECT([Invoice])   //###_jwm_###
			$WindowReference:=Open form window:C675([Invoice:26]; "Input"; Movable form dialog box:K39:8)  // ### jwm ### 20190225_1154
			MODIFY RECORD:C57([Invoice:26])
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
			OrdLnFillRays
			//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
			//  --  CHOPPED  AL_UpdateArrays(eOrdLn2POs; -2)
			aoLineAction:=Num:C11(Size of array:C274(aoLineAction)>0)  //the first line is the default highlight
			ARRAY LONGINT:C221(aRayLines; 1)
			aRayLines{1}:=aoLineAction
			// -- AL_SetSelect(eOrdList; aRayLines)  //first element in AreaList is always selected 
			doSearch:=0
			Ln_FillVar(aoLineAction; ->aOItemNum; ->aODescpt; 0; aOQtyOrder{aoLineAction}; aOQtyBL{aoLineAction}; aOUnitPrice{aoLineAction}; aODiscnt{aoLineAction}; aOExtPrice{aoLineAction}; aOPricePt{aoLineAction})
			ItemSetButtons((Size of array:C274(aoLineAction)>0); True:C214)
			doItemList:=True:C214
			ENABLE MENU ITEM:C149(4; 6)
			ENABLE MENU ITEM:C149(4; 7)
			DISABLE MENU ITEM:C150(5; 5)
		Else 
			
			
			//myCycle:=4  //needed in Order iLo Procedure
			
			var $idProcess : Integer
			var $new_o; $customer_o : Object
			var $idOrder; $idCustomer : Text
			If (process_o.Customer=Null:C1517)
				// MustFixQQQZZZ: Bill James (2021-11-28T06:00:00Z)
				// Convert to an object to pass
				//process_o.Customer:=ds.Customer.query("customerID = :1"; process_o.cur.customerID).first()
			End if 
			$tableName:="Invoice"
			$idOrder:=[Order:3]id:139
			$idCustomer:=[Customer:2]id:127
			$new_o:=New object:C1471("ents"; New object:C1471; "tableName"; $tableName; "task"; "addInvoice_Order"; \
				"tableParent"; "Order"; "Order_ent"; ds:C1482.Order.get($idOrder); "idParent"; $idOrder; \
				"idCustomer"; $idCustomer; "Customer_ent"; ds:C1482.Customer.get($idCustomer); \
				"taskEnd"; "reload_Customer"; "myCycle"; 11)
			//"Order"; process_o.cur; "Customer"; process_o.Customer; 
			
			UNLOAD RECORD:C212([Order:3])
			UNLOAD RECORD:C212([Customer:2])
			UNLOAD RECORD:C212([OrderLine:49])
			REDUCE SELECTION:C351([Invoice:26]; 0)
			REDUCE SELECTION:C351([OrderLine:49]; 0)
			
			process_o.taskEnd:="no return"
			CANCEL:C270
			
			$idProcess:=New process:C317("ProcessObject"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
			
			// Modified by: William James (2013-08-03T00:00:00)
			// Moved to after the other process was launched
			
		End if 
	Else 
		ALERT:C41("No items to ship. Hold Alt/Opt key to by pass.")
	End if 
End if 
vbForceShip:=False:C215