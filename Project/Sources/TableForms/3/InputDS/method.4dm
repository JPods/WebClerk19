
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
		process_o.entry_o.changed:=True:C214
		
	: (Form event code:C388=On Bound Variable Change:K2:52)
		
		//If (process_o.trace)
		//TRACE
		//End if 
		//entry_o:=OBJECT Get subform container value
		entry_o:=process_o.entry_o
		SF_cur._getRelated()
		var $instanceOf : Variant
		$instanceOf:=OB Instance of:C1731(entry_o)
		
	: (Form event code:C388=On Load:K2:1)
		// 
		//var entryForm : cs.cEntry
		////entry_o:=OBJECT Get subform container value
		//entryForm:=cs.cEntry.new()
		//entryForm._getRelated()
		
		entry_o:=process_o.entry_o
		//Ent_Before(process_o.dataClassName)
		// in TableShow, but may not be entered from there
		// look for changes in id if necessary
		
		OBJECT SET SUBFORM:C1138(*; "SF_Lines"; [OrderLine:49]; "Lines")
		
		//If (process_o.dataClassNameLines#"")
		// add the line dataClassName because we lose it when making a collection
		var $ref_o : Object
		$ref_o:=New object:C1471("prebuilt"; True:C214)
		LB_Lines:=cs:C1710.listboxK.new("LB_Lines"; process_o.dataClassNameLines; $ref_o)
		LB_Lines.setSource(ds:C1482.OrderLine.query("idNumOrder = :1"; entry_o.idNum))  //.toCollection())
		LB_Lines.calcLine(LB_Lines.cur)
		//End if 
		
		
		C_REAL:C285(vrAmountOverRide)
		
		MESSAGES OFF:C175
		
		$doPreNext:=booPreNext
		booPreNext:=False:C215
		
		process_o.related:=New object:C1471
		
		process_o.related.Document:=New object:C1471(\
			"ents"; New object:C1471; \
			"cur"; New object:C1471)
		//process_o.related.Contact:=ds.Contact.query("customerID = :1"; entry_o.customerID)
		//process_o.related.OrderLine:=Null
		//process_o.related.POLine:=ds.POLine.query("orderNum = :1"; 3; entry_o.idNum)
		//process_o.related.PO:=ds.PO.query("orderNum = :1"; 3; entry_o.idNum)
		//process_o.related.Profile:=ds.Profile.query("tableNum = :1 & docAlphaID = :2"; 3; String(entry_o.idNum))
		//process_o.related.QA:=ds.QA.query("idNumTask = :1 "; entry_o.idNumTask)
		//process_o.related.Service:=ds.Service.query("orderNum = :1"; 3; entry_o.idNum)
		//process_o.related.Time:=ds.Time.query("orderNum = :1"; entry_o.idNum)
		//process_o.related.WorkOrder:=ds.WorkOrder.query("orderNum = :1"; 3; entry_o.idNum)
		//process_o.related.WODraw:=ds.WOdraw.query("orderNum = :1"; 3; entry_o.idNum)
		
		If (process_o.cur#Null:C1517)
			process_o.related.Customer:=ds:C1482.Customer.query("customerID = :1"; process_o.cur.customerID)
		End if 
		
		
		
		//var LB_Lines : Object
		//LB_Lines:=New object("ents"; New object; "cur"; New object; "sel"; New object; "pos"; -1)
		//var $o : Object
		//var $filter_c : Collection
		//$filter_c:=Split string("itemNum;itemNumAlt;qty;"+\
																																																			"qtyShipped;qtyBackLogged;qtyCancelled;complete;description;typeSale;"+\
																																																			"unitPrice;discount;extendedPrice;printNot;seq;locationBin;status;producedBy;"+\
																																																			"dateRequired;dateShipOn;dateShipped;repID;salesNameID;company;"+\
																																																			"backOrdAmount;unitCost;extendedCost;taxJuris;salesTax;commRep;"+\
																																																			"commSales;commRateSales;commRateRep;commRep;commSales;"+\
																																																			"unitofMeasure;unitWt;extendedWt;location;serialRc;serialNum;comment;"+\
																																																			"lineProfile1;lineProfile2;lineProfile3;taxCost;discountedPrice;typeItem;class;"+\
																																																			"profile1;profile2;profile3;profile4;division;vendorID;mfrID"; ";")
		
		
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
		
		
		TallyMasterPopupScirpts(process_o.dataClassName)
		//Set [Invoice]UPSBillingOption default to "Prepaid & Add"
		If (entry_o.upsBillingOption="")
			entry_o.upsBillingOption:="Prepaid & Add"
		End if 
		If (entry_o.dateReceived=!00-00-00!)
			entry_o.dateReceived:=Current date:C33
		End if 
		
		
		
		//QQSetColor(eItemOrd; ->aLsItemNum)  //###_jwm_### 20101112
		//QQSetColor(eOrdList; ->aOItemNum)  //###_jwm_### 20101112
		
		//Before_New(ptCurTable)
		
		//ILO_OrderDur
		//set wt check box to enterable only for "Prepaid & Add" bill to option
		If (entry_o.upsBillingOption="Prepaid@")
			OBJECT SET ENTERABLE:C238(_PROP_Order_shipAuto; True:C214)
		Else 
			entry_o.autoFreight:=False:C215
			OBJECT SET ENTERABLE:C238(_PROP_Order_shipAuto_; False:C215)
			OBJECT SET ENTERABLE:C238(_PROP_Order_shipMiscCosts_; Not:C34(entry_o.shipAuto))
			OBJECT SET ENTERABLE:C238(_PROP_Order_shipFreightCost_; Not:C34(entry_o.shipAuto))
		End if 
		
End case 

