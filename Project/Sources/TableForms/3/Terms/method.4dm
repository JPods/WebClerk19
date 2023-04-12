
Case of 
	: (Form event code:C388=On Close Box:K2:21)  // ### jwm ### 20181211_1052
		process_o.entitySave()
		
	: (Form event code:C388=On Unload:K2:2)
		
		
	: (Form event code:C388=On Deactivate:K2:10)
		
	: (Form event code:C388=On Outside Call:K2:11)  //: (Outside call)
		//QQQ
		OutSide_Do
		
		
	: (Form event code:C388=On Activate:K2:9)  // ### jwm ### 20170707_2103 when becomes front window
		
		//TRACE  // check this
		
	: (Form event code:C388=On Timer:K2:25)
		process_o.entryMilli:=Milliseconds:C459+(2*60*1000)
		SET TIMER:C645(process_o.entryMilli)
		
		
	: (Form event code:C388=On Data Change:K2:15)
		process_o.entitySave()
		
	: (Form event code:C388=On Load:K2:1)
		
		Ent_Before(process_o.dataClassName)
		
		
		
		
		
		C_REAL:C285(vrAmountOverRide)
		
		MESSAGES OFF:C175
		
		$doPreNext:=booPreNext
		booPreNext:=False:C215
		If (process_o.primary=Null:C1517)
			process_o.related:=New object:C1471
		End if 
		process_o.related.Document:=New object:C1471(\
			"ents"; New object:C1471; \
			"cur"; New object:C1471)
		process_o.related.Contact:=ds:C1482.Contact.query("customerID = :1"; entry_o.customerID)
		process_o.related.OrderLine:=Null:C1517
		process_o.related.POLine:=ds:C1482.POLine.query("orderNum = :1"; 3; entry_o.idNum)
		process_o.related.PO:=ds:C1482.PO.query("orderNum = :1"; 3; entry_o.idNum)
		process_o.related.Profile:=ds:C1482.Profile.query("tableNum = :1 & docAlphaID = :2"; 3; String:C10(entry_o.idNum))
		process_o.related.QA:=ds:C1482.QA.query("idNumTask = :1 "; entry_o.idNumTask)
		process_o.related.Service:=ds:C1482.Service.query("orderNum = :1"; 3; entry_o.idNum)
		process_o.related.Time:=ds:C1482.Time.query("orderNum = :1"; entry_o.idNum)
		process_o.related.WorkOrder:=ds:C1482.WorkOrder.query("orderNum = :1"; 3; entry_o.idNum)
		process_o.related.WODraw:=ds:C1482.WOdraw.query("orderNum = :1"; 3; entry_o.idNum)
		
		If (process_o.related.Customer=Null:C1517)
			process_o.related.Customer:=ds:C1482.Customer.query("customerID = :1"; entry_o.customerID)
		End if 
		
		
		var LB_OrderLine : Object
		LB_OrderLine:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1)
		
		LB_Lines.ents:=ds:C1482.OrderLine.query("idNumOrder = :1"; entry_o.idNum)
		
		// OBJECT SET SUBFORM(*; "SF_Lines"; "OrderLine"; LB_OrderLine.data)
		
		
		If (False:C215)
			
			$materials_o:=ds:C1482.WOdraw.query("orderNum = :1"; 3; process_o.cur.idNum)
			$orderLines_o:=ds:C1482.OrderLine.query("orderNum = :1"; 3; process_o.cur.idNum)
			$poLines_o:=ds:C1482.POLine.query("orderNum = :1"; 3; process_o.cur.idNum)
			$pos_o:=ds:C1482.PO.query("orderNum = :1"; 3; process_o.cur.idNum)
			$profiles_o:=ds:C1482.Profile.query("tableNum = :1 & docAlphaID = :2"; 3; String:C10(process_o.cur.idNum))
			$qas_o:=ds:C1482.QA.query("idNumTask = :1 "; process_o.cur.idNumTask)
			$service_o:=ds:C1482.Service.query("orderNum = :1"; 3; process_o.cur.idNum)
			$times_o:=ds:C1482.Time.query("orderNum = :1"; process_o.cur.idNum)
			$wos_o:=ds:C1482.WorkOrder.query("orderNum = :1"; 3; process_o.cur.idNum)
			
			
			process_o.ents.Customer:=$customer_o
			process_o.ents.Contact:=ds:C1482.Contact.query("customerID = :1"; process_o.cur.customerID)
			
			
			$docs_o:=ds:C1482.Document.query("orderNum = :1"; 3; process_o.cur.idNum)
			$materials_o:=ds:C1482.WODraw[WOdraw].query("orderNum = :1"; 3; process_o.cur.idNum)
			$orderLines_o:=ds:C1482.OrderLine.query("orderNum = :1"; 3; process_o.cur.idNum)
			$poLines_o:=ds:C1482.POLine.query("orderNum = :1"; 3; process_o.cur.idNum)
			$pos_o:=ds:C1482.PO.query("orderNum = :1"; 3; process_o.cur.idNum)
			$profiles_o:=ds:C1482.Profile.query("tableNum = :1 & docAlphaID = :2"; 3; String:C10(process_o.cur.idNum))
			$qas_o:=ds:C1482.QA.query("idNumTask = :1 "; process_o.cur.idNumTask)
			$service_o:=ds:C1482.Service.query("orderNum = :1"; 3; process_o.cur.idNum)
			$times_o:=ds:C1482.Time.query("orderNum = :1"; process_o.cur.idNum)
			$wos_o:=ds:C1482.WorkOrder.query("orderNum = :1"; 3; process_o.cur.idNum)
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
			OBJECT SET ENTERABLE:C238([Order:3]shipAuto:40; True:C214)
		Else 
			[Order:3]shipAuto:40:=False:C215
			OBJECT SET ENTERABLE:C238([Order:3]shipAuto:40; False:C215)
			OBJECT SET ENTERABLE:C238([Order:3]shipMiscCosts:25; Not:C34([Order:3]shipAuto:40))
			OBJECT SET ENTERABLE:C238([Order:3]shipFreightCost:38; Not:C34([Order:3]shipAuto:40))
		End if 
		
End case 

