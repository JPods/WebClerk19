
Case of 
	: (Form event code:C388=On Close Box:K2:21)  // ### jwm ### 20181211_1052
		jCancelButton
	: (Form event code:C388=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
	: (Form event code:C388=On Deactivate:K2:10)
		<>vPricePoint:=entryEntity.typeSale
	: (Form event code:C388=On Outside Call:K2:11)  //: (Outside call)
		C_LONGINT:C283(<>prsTableNum)
		Case of 
			: (<>prsTableNum=-3)
				jCancelButton
				
			: (<>vlRecNum>0)
				Prs_OutsideCall
			: (<>vbDoQuit)
				jAcceptButton(True:C214; True:C214)
			Else 
				OutSide_Do
		End case 
		QQSetColor(eItemOrd; ->aLsItemNum)  //###_jwm_### 20101112
		QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112
		
	: (Form event code:C388=On Activate:K2:9)  // ### jwm ### 20170707_2103 when becomes front window
		jsetBefore(->[Order:3])
		//TRACE  // check this
		
	: (Form event code:C388=On Timer:K2:25)
		If (Macintosh option down:C545)
			OBJECT SET TITLE:C194(*; "bQQPull"; "QQPush")
		Else 
			OBJECT SET TITLE:C194(*; "bQQPull"; "QQPull")
		End if 
		
	: (Form event code:C388=On Load:K2:1)
		
		Ent_Before(process_o.tableName)
		
		
		
		
		
		C_REAL:C285(vrAmountOverRide)
		
		MESSAGES OFF:C175
		
		$doPreNext:=booPreNext
		booPreNext:=False:C215
		
		process_o.ents.Document:=Null:C1517
		process_o.ents.OrderLine:=Null:C1517
		process_o.ents.POLine:=Null:C1517
		process_o.ents.PO:=Null:C1517
		process_o.ents.Profile:=Null:C1517
		process_o.ents.QA:=Null:C1517
		process_o.ents.Service:=Null:C1517
		process_o.ents.Time:=Null:C1517
		process_o.ents.WODraw:=Null:C1517
		process_o.ents.WorkOrder:=Null:C1517
		
		If (process_o.ents.Customer=Null:C1517)
			$customer_o:=ds:C1482.Customer.query("customerID = :1"; process_o.cur.customerID)
		End if 
		If ($customer_o#Null:C1517)
			$customer_o:=ds:C1482.Customer.query("customerID = :1"; process_o.cur.customerID)
		End if 
		process_o.ents.Document:=Null:C1517
		process_o.ents.OrderLine:=Null:C1517
		process_o.ents.POLine:=Null:C1517
		process_o.ents.PO:=Null:C1517
		process_o.ents.Profile:=Null:C1517
		process_o.ents.QA:=Null:C1517
		process_o.ents.Service:=Null:C1517
		process_o.ents.Time:=Null:C1517
		process_o.ents.WODraw:=Null:C1517
		process_o.ents.WorkOrder:=Null:C1517
		
		var LB_OrderLine : Object
		LB_OrderLine:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1)
		
		LB_OrderLine.data:=ds:C1482.OrderLine.query("idNumOrder = :1"; entryEntity.idNum)
		
		// OBJECT SET SUBFORM(*; "SF_Lines"; "OrderLine"; LB_OrderLine.data)
		
		
		If (False:C215)
			
			$materials_o:=ds:C1482.WOdraw.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$orderLines_o:=ds:C1482.OrderLine.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$poLines_o:=ds:C1482.POLine.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$pos_o:=ds:C1482.PO.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$profiles_o:=ds:C1482.Profile.query("tableNum = :1 & docAlphaID = :2"; 3; String:C10(process_o.cur.orderNum))
			$qas_o:=ds:C1482.QA.query("idNumTask = :1 "; process_o.cur.idNumTask)
			$service_o:=ds:C1482.Service.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$times_o:=ds:C1482.Time.query("orderNum = :1"; process_o.cur.orderNum)
			$wos_o:=ds:C1482.WorkOrder.query("orderNum = :1"; 3; process_o.cur.orderNum)
			
			
			process_o.ents.Customer:=$customer_o
			process_o.ents.Contact:=ds:C1482.Contact.query("customerID = :1"; process_o.cur.customerID)
			
			
			$docs_o:=ds:C1482.Document.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$materials_o:=ds:C1482.WODraw[WOdraw].query("orderNum = :1"; 3; process_o.cur.orderNum)
			$orderLines_o:=ds:C1482.OrderLine.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$poLines_o:=ds:C1482.POLine.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$pos_o:=ds:C1482.PO.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$profiles_o:=ds:C1482.Profile.query("tableNum = :1 & docAlphaID = :2"; 3; String:C10(process_o.cur.orderNum))
			$qas_o:=ds:C1482.QA.query("idNumTask = :1 "; process_o.cur.idNumTask)
			$service_o:=ds:C1482.Service.query("orderNum = :1"; 3; process_o.cur.orderNum)
			$times_o:=ds:C1482.Time.query("orderNum = :1"; process_o.cur.orderNum)
			$wos_o:=ds:C1482.WorkOrder.query("orderNum = :1"; 3; process_o.cur.orderNum)
		End if 
		//NxPvOrders
		
		
		TallyMasterPopupScirpts(->[Order:3])
		//Set [Invoice]UPSBillingOption default to "Prepaid & Add"
		If ([Order:3]upsBillingOption:89="")
			[Order:3]upsBillingOption:89:="Prepaid & Add"
		End if 
		If (([Order:3]dateReceived:125=!00-00-00!) & (Is new record:C668([Order:3])))
			[Order:3]dateReceived:125:=Current date:C33
		End if 
		
		
		
		QQSetColor(eItemOrd; ->aLsItemNum)  //###_jwm_### 20101112
		QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112
		
		Before_New(ptCurTable)
		
		ILO_OrderDur
		//set wt check box to enterable only for "Prepaid & Add" bill to option
		If ([Order:3]upsBillingOption:89="Prepaid@")
			OBJECT SET ENTERABLE:C238([Order:3]autoFreight:40; True:C214)
		Else 
			[Order:3]autoFreight:40:=False:C215
			OBJECT SET ENTERABLE:C238([Order:3]autoFreight:40; False:C215)
			OBJECT SET ENTERABLE:C238([Order:3]shipMiscCosts:25; Not:C34([Order:3]autoFreight:40))
			OBJECT SET ENTERABLE:C238([Order:3]shipFreightCost:38; Not:C34([Order:3]autoFreight:40))
		End if 
		
End case 

