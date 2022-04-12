//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-28T06:00:00Z)
// Method: CloneRecord
// Description
// Parameters
// ----------------------------------------------------
var $1; $entity; $entityNew; $status : Object
var $new_o; $entity; $entityNew; $status : Object
var $tableName : Text
$doClone:=True:C214
Case of 
	: (Count parameters:C259=1)
		$entity:=$1  //receive the entity to duplicate in $1
		If (process_o=Null:C1517)
			process_o:=New object:C1471("ents"; New object:C1471; \
				"cur"; New object:C1471; \
				"sel"; New object:C1471; \
				"pos"; -1; \
				"tableName"; ""; \
				"tableForm"; ""; \
				"form"; ""; \
				"entsOther"; New object:C1471("tableName"; New object:C1471); \
				"process"; Current process:C322)
		End if 
	: (process_o.cur#Null:C1517)
		$entity:=process_o.cur
	Else 
		$doClone:=False:C215
End case 
If ($doClone)
	
	
	//duplicate_entity method
	//duplicate_entities($1)
	//duplicate_entities(entity)
	//  https://doc.4d.com/4Dv19/4D/19.1/entitygetDataClass.301-5653052.en.html
	
	$tableName:=$entity.getDataClass().tableName
	$entityNew:=$entity.getDataClass().new()  //create a new entity in the parent dataclass
	$entityNew.fromObject($entity.toObject())  //get all attributes
	$entityNew[$entity.getDataClass().getInfo().id]:=Null:C1517  //reset the primary key
	$status:=$entityNew.save()  //save the duplicated entity
	If (Not:C34($status.successful))
		
	Else 
		process_o.cur:=$entityNew
		process_o.tableName:=$tableName
		process_o.ents:=New object:C1471
		Case of 
			: ($tableName="Service")
				Date_ServiceRec(process_o.cur)
			: ($tableName="Customer")
				Clone_Customer
			: ($tableName="Order")
				Clone_Order  //My_ChangeName
				
				If ((OptKey=1) | (<>bCloneWO))
					//Ord_CloneWO
				Else 
					
				End if 
			: (($tableName="Proposal") | ($tableName="ProposalLine"))
				CloneProposal
				If (ePropList>0)
					//  --  CHOPPED  AL_UpdateArrays(ePropList; Size of array(aPLineAction))
				End if 
			: ($tableName="PO")  //??ptCurFile=(?POLine"))
				Clone_PO
			: ($tableName="SpecialDiscount")
				CloneChildrenRecords(->[SpecialDiscount:44]idNum:4; ->[ItemDiscount:45]specialDiscountsid:1; ->[SpecialDiscount:44]typeSale:1; ->[ItemDiscount:45]typeSale:9)
				//GOTO OBJECT([SpecialDiscount]TypeSale)
				//HIGHLIGHT TEXT([SpecialDiscount]TypeSale;1;Length([SpecialDiscount]TypeSale))
				iLoRecordChange:=True:C214  // ### jwm ### 20171219_1504
				If (False:C215)
					QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4)
					ARRAY LONGINT:C221($aChildren; 0)
					SELECTION TO ARRAY:C260([ItemDiscount:45]; $aChildren)
					DUPLICATE RECORD:C225([SpecialDiscount:44])  // autoincrement
					SAVE RECORD:C53([SpecialDiscount:44])
					var $i; $k : Integer
					$k:=Size of array:C274($aChildren)
					For ($i; 1; $k)
						GOTO RECORD:C242([ItemDiscount:45]; $aChildren{$i})  // ### jwm ### 20161024_1353
						DUPLICATE RECORD:C225([ItemDiscount:45])
						[ItemDiscount:45]specialDiscountsid:1:=[SpecialDiscount:44]idNum:4
						SAVE RECORD:C53([ItemDiscount:45])
					End for 
					UNLOAD RECORD:C212([ItemDiscount:45])
				End if 
				
			: ($tableName="Item")
				Clone_Item(OptKey)
			: ($tableName="QAQuestion")
				DUPLICATE RECORD:C225(ptCurTable->)
				
				REDUCE SELECTION:C351([QAAnswer:72]; 0)
			: ($tableName="QAAnswer")
				DUPLICATE RECORD:C225(ptCurTable->)
				
			: ($tableName="Contact")
				DUPLICATE RECORD:C225(ptCurTable->)
				
			: ($tableName="zzzLead")
				DUPLICATE RECORD:C225(ptCurTable->)
				
			: ($tableName="WorkOrder")
				DUPLICATE RECORD:C225(ptCurTable->)
				[WorkOrder:66]idNum:29:=CounterNew(->[WorkOrder:66])
				srWO:=[WorkOrder:66]idNum:29
			: ($tableName="Usage")
				DUPLICATE RECORD:C225(ptCurTable->)
				[Usage:5]periodDate:2:=!00-00-00!
			: ($tableName="Rep")
				DUPLICATE RECORD:C225(ptCurTable->)
				[Rep:8]repID:1:=""
				OBJECT SET ENTERABLE:C238([Rep:8]repID:1; True:C214)
			: ($tableName="Quota")
				DUPLICATE RECORD:C225(ptCurTable->)
				[Quota:9]period:3:=!00-00-00!
				OBJECT SET ENTERABLE:C238([Quota:9]period:3; True:C214)
			: ($tableName="Carrier")
				
				// Modified by: Bill James (2015-04-13T00:00:00 Subrecord eliminated)
				
				QUERY:C277([CarrierZone:143]; [CarrierZone:143]idNumCarrier:6=[Carrier:11]idNum:44)
				ARRAY LONGINT:C221($aCarrierZones; 0)
				SELECTION TO ARRAY:C260([CarrierZone:143]; $aCarrierZones)
				QUERY:C277([CarrierWeight:144]; [CarrierWeight:144]idNumCarrier:13=[Carrier:11]idNum:44)
				ARRAY LONGINT:C221($aCarrierWeights; 0)
				SELECTION TO ARRAY:C260([CarrierWeight:144]; $aCarrierWeights)
				DUPLICATE RECORD:C225(ptCurTable->)
				
				[Carrier:11]active:6:=False:C215
				var $i; $k : Integer
				$k:=Size of array:C274($aCarrierZones)
				For ($i; 1; $k)
					GOTO RECORD:C242([CarrierZone:143]; $aCarrierZones{$i})  // ### jwm ### 20161024_1353
					DUPLICATE RECORD:C225([CarrierZone:143])
					
					[CarrierZone:143]idNumCarrier:6:=[Carrier:11]idNum:44
					[CarrierZone:143]carrierid:7:=[Carrier:11]carrierid:10  // ### jwm ### 20150421_1033
					//[CarrierZone]siteID:=[Carrier]siteID  // ### jwm ### 20150421_1259 Do not overwrite Site ID
					SAVE RECORD:C53([CarrierZone:143])
				End for 
				$k:=Size of array:C274($aCarrierWeights)
				For ($i; 1; $k)
					GOTO RECORD:C242([CarrierWeight:144]; $aCarrierWeights{$i})  // ### jwm ### 20161024_1353
					DUPLICATE RECORD:C225([CarrierWeight:144])
					
					[CarrierWeight:144]idNumCarrier:13:=[Carrier:11]idNum:44
					[CarrierWeight:144]carrierid:14:=[Carrier:11]carrierid:10  // ### jwm ### 20150421_1033
					[CarrierWeight:144]siteID:19:=[Carrier:11]siteID:36  // ### jwm ### 20150421_1033
					SAVE RECORD:C53([CarrierWeight:144])
				End for 
				SAVE RECORD:C53([Carrier:11])  // ### jwm ### 20161024_1342
				Set_Window_Title
			: ($tableName="Employee")
				DUPLICATE RECORD:C225(ptCurTable->)
				[Employee:19]nameID:1:=""
				OBJECT SET ENTERABLE:C238([Employee:19]nameID:1; True:C214)
			: ($tableName="TechNote")
				TN_Clone
			: ($tableName="TallyResult")
				DUPLICATE RECORD:C225([TallyResult:73])
				
				[TallyResult:73]dtCreated:11:=DateTime_Enter
			: ($tableName="Forum")
				DUPLICATE RECORD:C225([Forum:80])
				
				[Forum:80]dtSubmitted:6:=DateTime_Enter
			: ($tableName="UserReport")
				DUPLICATE RECORD:C225([UserReport:46])
				
				[UserReport:46]isPrimary:15:=False:C215
			: ($tableName="Invoice")
				$k:=0
				ARRAY LONGINT:C221(aInvoices; $k)
				ARRAY TEXT:C222(aInvTerms; $k)
				ARRAY REAL:C219(aAmtPaid; $k)
				ARRAY REAL:C219(aInvTotals; $k)
				ARRAY REAL:C219(aInvDiscountAmounts; $k)
				DUPLICATE RECORD:C225([Invoice:26])
				[Invoice:26]idNum:2:=CounterNew(->[Invoice:26])
				srIv:=[Invoice:26]idNum:2
				[Invoice:26]idNumOrder:1:=1
				newInv:=True:C214
				myTrap:=0
				[Invoice:26]dateDocument:35:=Current date:C33
				[Invoice:26]dateShipped:4:=Current date:C33
				[Invoice:26]packedBy:30:=Current user:C182
				[Invoice:26]balanceDue:44:=[Invoice:26]total:18
				[Invoice:26]appliedDiscount:45:=0
				[Invoice:26]appliedAmount:46:=0
				[Invoice:26]datePaid:26:=!00-00-00!
				[Invoice:26]daysPaid:27:=0
				[Invoice:26]customerPO:29:=""
				[Invoice:26]dateLinked:31:=!00-00-00!
				
				[Invoice:26]jrnlComplete:48:=False:C215
				[Invoice:26]timesPrinted:51:=0
				changeInv:=True:C214
				
				For ($i; 1; Size of array:C274(aiLineAction))
					aiLineAction{$i}:=-3  // clone line
					aiUniqueID{$i}:=-3
					
					aiQtyRemain{$i}:=aiQtyShip{$i}
					aiQtyBL{$i}:=0
					If (aiSerialRc{$i}#<>ciSRNotSerialized)
						aiSerialRc{$i}:=<>ciSRUnknown
						aiQtyShip{$i}:=0
					End if 
					IvcLnExtend($i)
				End for 
				FontSrchLabels(1)
				REDUCE SELECTION:C351([Payment:28]; 0)
				//        jClearFile (?Invoice])
				//  --  CHOPPED  AL_UpdateArrays(eIvcList; Size of array(aiLineAction))
			: (($tableName="Default") | ($tableName="Control") | ($tableName="Payment") | ($tableName="InventoryStack") | ($tableName="Ledger") | ($tableName="DefaultAccount"))
				jAlertMessage(9000)
			: ($tableName="UsageSummary")
				DUPLICATE RECORD:C225(ptCurTable->)
				
				[UsageSummary:33]periodDate:2:=!00-00-00!
			: ($tableName="UsageSummary")
				
			Else 
				DUPLICATE RECORD:C225(ptCurTable->)
				
		End case 
		//jSaveRecord
		ONE RECORD SELECT:C189(ptCurTable->)
		jNxPvButtonSet
		booSorted:=False:C215
		RelatedRelease
		//jrelateClrFiles
		//November 7, 1993, removed to update AL_Pro
		//    booDuringDo:=False
	End if 
End if 