C_LONGINT:C283(bInvoice)
C_BOOLEAN:C305($Confirm)
C_LONGINT:C283($CurRec; $lines2Convert)
BEEP:C151  //PLAY("Sosumi")
If (booAccept=False:C215)
	jAlertMessage(9200)
Else 
	
	//CONFIRM("Convert "+String($lines2Convert)+" lines to an Order.")
	
	//If (OK=1)
	If ((CmdKey=0) & ([Proposal:42]salesNameID:9#"CloneAllowed"))
		CONFIRM:C162("Set Status to Won/Complete?")
		If (OK=1)
			[Proposal:42]status:2:="Won"
			[Proposal:42]complete:56:=True:C214
		End if 
	End if 
	If (Modified record:C314([Customer:2]))
		SAVE RECORD:C53([Customer:2])
	End if 
	acceptPropsl
	myOK:=1
	booDuringDo:=False:C215
	If (True:C214)  //(OptKey=0) //Disabled adding proposal lines to an existing order    
		REDUCE SELECTION:C351([Order:3]; 0)
		myCycle:=4  //needed in Order iLo Procedure
		// Modified by: williamjames (130317)
		//FORM SET INPUT([Order];"Input")
		
		var $idParent; $idCustomer : Text
		$idCustomer:=[Customer:2]id:127
		$idProposal:=[Proposal:42]id:89
		var $idProcess : Integer
		var $new_o : Object
		//If (process_o.Customer=Null)
		//process_o.Customer:=ds.Customer.query("customerID = :1"; process_o.cur.customerID).first()
		//End if 
		// MustFixQQQZZZ: Bill James (2021-12-12T06:00:00Z)
		// parents
		$tableName:="Order"
		$new_o:=New object:C1471("tableName"; $tableName; "task"; "addOrder_Proposal"; "tableParent"; "Proposal"; \
			"idParent"; $idProposal; "idCustomer"; $idCustomer; "taskEnd"; "recall_Customer"; "myCycle"; 4)
		
		
		UNLOAD RECORD:C212([Order:3])
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([OrderLine:49])
		REDUCE SELECTION:C351([Order:3]; 0)
		REDUCE SELECTION:C351([ProposalLine:43]; 0)
		
		
		process_o.taskEnd:="no return"
		CANCEL:C270
		
		$idProcess:=New process:C317("ProcessObject"; <>tcPrsMemory; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
		
		
		myCycle:=0
		//vHere:=vHere-1
		//jCancelButton (False)
	Else 
		//This won't work, it might create duplicate Line Numbers
		//See: createOrderProp
		C_LONGINT:C283($srchOrd)
		$srchOrd:=Num:C11(Request:C163("Transfer to existing order number?"))
		If (OK=1)
			QUERY:C277([Order:3]; [Order:3]idNum:2=$srchOrd)
			If (Records in selection:C76([Order:3])=1)
				If (Not:C34(Locked:C147([Order:3])))
					myCycle:=4  //needed in Order iLo Procedure
					//FORM SET INPUT([Order];"iOrders_9")
					$vhref:=Open form window:C675([Order:3]; "Input"; Plain form window:K39:10)  // ### jwm ### 20190626_1406
					MODIFY RECORD:C57([Order:3])
					myCycle:=0
					//vHere:=vHere-1
					//jCancelButton (False)
				Else 
					jAlertMessage(10004)
				End if 
			Else 
				jAlertMessage(10003)
			End if 
		End if 
	End if 
End if 
