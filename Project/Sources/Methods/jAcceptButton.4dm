//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/25/10, 12:24:40
// ----------------------------------------------------
// Method: jAcceptButton
// Description
//
//
// Parameters
// ----------------------------------------------------

CANCEL:C270

var $acitonRec; $processNum; $w : Integer
var $confirm; $save; $unLoad : Boolean
var viMakeSyncMap; viRecursive : Integer
var $action : Text
// NEVER_FROM_CLASSIC Bill James (2022-01-28T06:00:00Z)
If (False:C215)
	If (process_o.saveOK#Null:C1517)
		$action:=process_o.saveOK
	Else 
		$action:="viewOnly"
	End if 
	If ($action="viewOnly")
		//CANCEL
	Else 
		If (Locked:C147(ptCurTable->))
			ALERT:C41("Record is locked and cannot be saved.")
		Else 
			
			//My_Special8   // DEBUG
			
			booAccept:=True:C214  // ### jwm ### 20190711_1408 start with accept = true, no errors found
			
			If (RecordAcceptTest(booAccept; ptCurTable))  //jStartup0
				
				
				$confirm:=True:C214
				Case of 
					: (Count parameters:C259=1)
						$unLoad:=$1
					: (Count parameters:C259=2)
						$unLoad:=$1  //true unloads records
						$confirm:=$2  //false does not save
					Else 
						If (vHere>2)
							$unLoad:=False:C215  //true unloads records
						Else 
							$unLoad:=True:C214  //true unloads records
						End if 
						$confirm:=False:C215  //false does not save
				End case 
				$save:=jConfirmSave(True:C214; $confirm)
				var vIsNewRecord : Boolean
				vIsNewRecord:=False:C215
				If ($save)
					
					// viMakeSyncMap:=Find in array(<>aptSyncTables; ptCurTable)
					$acitonRec:=0
					Case of 
						: (myCycle=3)
							//in the add record loop
						: ((myCycle=7) | (myCycle=6))
							myCycle:=6
						: (myCycle=8)
							myCycle:=6
							If (Record number:C243(ptCurTable->)=-3)
								ONE RECORD SELECT:C189(ptCurTable->)
								jNxPvButtonSet
							End if 
						: (Is new record:C668(ptCurTable->))  //&(vHere>2))
							$acitonRec:=-3
							vIsNewRecord:=True:C214
							//CREATE SET(ptCurFile->;"SaveTemp")//4D does a one record select to save
							//        $CurRec:=Records in set("SaveTemp")+1
					End case 
					
					
					
					$keyTagsAtEnd_b:=True:C214
					If (False:C215)  // always do at the end to assure any overrides or field changes
						If (process_o.cur#Null:C1517)
							If (process_o.cur.id#Null:C1517)
								$keyTagsAtEnd_b:=False:C215
								var $obClass; $obField : Object
								var $ptObGeneral : Pointer
								$tableName:=Table name:C256(ptCurTable)
								
								// MustFixQQQZZZ: Bill James (2021-11-30T06:00:00Z)
								// if bouncing between tables. Fix this in 19
								//$tableName:=process_o.dataClassName
								$obClass:=ds:C1482[$tableName]
								$viFieldNum:=$obClass["obGeneral"].fieldNumber
								$ptObGeneral:=Field:C253(Table:C252(ptCurTable); $viFieldNum)
								$keyTagsAtEnd_b:=False:C215
								If ($ptObGeneral->=Null:C1517)
									$ptObGeneral->:=New object:C1471
								End if 
								$ptObGeneral->keyTags:=KeyTagsFromAlphaFields(process_o.cur)
								// several tables have a keyTags text field for faster queries
								$ptKeyTags:=STR_GetFieldPointer($tableName; "keyTags")
								If ($ptKeyTags#Null:C1517)
									$ptKeyTags->:=$ptObGeneral->keyTags
								End if 
							End if 
						End if 
					End if 
					//end if
					Case of   //Must not reset to 0 is Accept button is selected.  6 allows the flow to continue
						: (ptCurTable=(->[Order:3]))  //Orders
							acceptOrders
							OrderPostProduction
						: (ptCurTable=(->[Invoice:26]))  //Invoices
							acceptInvoice
						: (ptCurTable=(->[Payment:28]))  //Invoices
							If (Length:C16([Payment:28]creditCardNum:13)>1)
								If (Position:C15("x"; [Payment:28]creditCardNum:13)=0)  // do not allow x displayed cards to be encrypted
									// If ([Payment]CreditCardNum[[2]]#"x")
									$savedResult:=CC_ReturnXedOutCardNum([Payment:28]creditCardNum:13)
									$encryptResult:=CC_EncodeDecode(1; [Payment:28]creditCardNum:13; ->[Payment:28]creditCardBlob:53)  //save card encrypted
									[Payment:28]creditCardNum:13:=$savedResult
								End if 
							End if 
							If (([Payment:28]idCustomer:62="00000@") & ([Customer:2]id:127#"00000@"))
								[Payment:28]idCustomer:62:=[Customer:2]id:127
							End if 
							If (([Payment:28]idOrder:63="00000@") & ([Order:3]id:139#"00000@"))
								[Payment:28]idOrder:63:=[Order:3]id:139
							End if 
							If (([Payment:28]idInvoice:64="00000@") & ([Invoice:26]id:103#"00000@"))
								[Payment:28]idInvoice:64:=[Invoice:26]id:103
							End if 
							
							SAVE RECORD:C53([Payment:28])
							Ledger_PaySave
						: (ptCurTable=(->[Item:4]))  //Items
							acceptItem  // acceptFilePt saves the record
							acceptFilePt($unLoad; ->[Item:4]; ->[Usage:5]; ->[BOM:21]; ->[InventoryStack:29]; ->[ItemSpec:31]; ->[ItemXRef:22])  //[OpStep]  [ItemSerial]
							
						: (ptCurTable=(->[Service:6]))
							
							
							acceptFilePt($unLoad; ->[Service:6]; ->[Customer:2]; ->[OrderLine:49]; ->[Order:3]; ->[Invoice:26]; ->[Proposal:42]; ->[InvoiceLine:54])
							newService:=False:C215
						: (ptCurTable=(->[Customer:2]))
							//TRACE
							If (Is new record:C668([Customer:2]))
								TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Customer:2]adSource:62; 0; 1)
							End if 
							
							
							// ### jwm ### 20171207_1106 updated [Contact]DateRetired
							If ([Customer:2]dateRetired:111#Old:C35([Customer:2]dateRetired:111))
								AcceptContactsRetired
							End if 
							
							acceptFilePt($unLoad; ->[Customer:2]; ->[Contact:13]; ->[Service:6]; ->[Reference:7]; ->[Call:34])
							acceptFilePt($unLoad; ->[OrderLine:49]; ->[Order:3]; ->[Invoice:26]; ->[Proposal:42]; ->[InvoiceLine:54])
							
							If ([Customer:2]mfrLocationid:67<-1999999)
								$processNum:=New process:C317("setChMfgs"; <>tcPrsMemory; "ChoiceArray")
							End if 
						: (ptCurTable=(->[Proposal:42]))
							acceptPropsl  //transactions are in accept Procedure
						: ((ptCurTable=(->[PO:39])) | (ptCurTable=(->[POLine:40])))
							acceptPO  //transactions are in accept Procedure
						: (ptCurTable=(->[InventoryStack:29]))
							SAVE RECORD:C53([InventoryStack:29])
							READ ONLY:C145([InventoryStack:29])
						: (ptCurTable=(->[Report:46]))
							URpt_Accept
						: (ptCurTable=(->[Call:34]))
							If ((Record number:C243([Customer:2])>-1) & (Modified record:C314([Customer:2])))
								SAVE RECORD:C53([Customer:2])
							End if 
							If ((Record number:C243([Contact:13])>-1) & (Modified record:C314([Contact:13])))
								SAVE RECORD:C53([Contact:13])
							End if 
							SAVE RECORD:C53(ptCurTable->)
						: (ptCurTable=(->[Contact:13]))
							
							SAVE RECORD:C53(ptCurTable->)
							
						: (ptCurTable=(->[Default:15]))
							SAVE RECORD:C53(ptCurTable->)
							Storage_Default
						: (ptCurTable=(->[PopUp:23]))
							//TRACE
							If (transactionActive)
								VALIDATE TRANSACTION:C240
								transactionActive:=False:C215
							End if 
							SAVE RECORD:C53([PopUp:23])
							
							$processNum:=New process:C317("jsetChPopups"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[ItemCatalog:44]))
							
							SAVE RECORD:C53([ItemCatalog:44])
							Disc_ArraysDo(-5)
							$processNum:=New process:C317("setTypeSalePopu"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[Comment:27]))
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("setChOrdCom"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[Process:16]))
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("jsetChProcesses"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[Employee:19]))
							Default_Employee
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("setChEmploy"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[Script:12]))
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("jsetChScript"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[Carrier:11]))
							If ([Carrier:11]idNum:44=0)
								
								QUERY:C277([zzzTemplateline:132]; [zzzTemplateline:132]templateid:2=[Carrier:11]carrierid:10; *)
								QUERY:C277([zzzTemplateline:132];  & [zzzTemplateline:132]templateid:2=[Carrier:11]carrierid:10; *)
							End if 
							SAVE RECORD:C53([Carrier:11])
							$processNum:=New process:C317("setChShip"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[AdSource:35]))
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("setChAds"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[TaxJurisdiction:14]))
							[TaxJurisdiction:14]dateTimeSync:6:=DateTime_DTTo
							SAVE RECORD:C53([TaxJurisdiction:14])
							$processNum:=New process:C317("setChTax"; <>tcPrsMemory; "ChoiceArray")
							
						: (ptCurTable=(->[TechNote:58]))
							// [TechNote]BodyText:=TNCaptureWebArea
							// included in the following
							TNSaveForWeb
							SAVE RECORD:C53([TechNote:58])
						: (ptCurTable=(->[Discussion:139]))
							[Discussion:139]body:6:=TNCaptureWebArea
							SAVE RECORD:C53([Discussion:139])
						: (ptCurTable=(->[Message:137]))
							If (False:C215)  // set to true if we are allowing emails to be edited
								WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "getContent"; tinyMCE_Content_t)
								[Message:137]body:12:=tinyMCE_Content_t
							End if 
							SAVE RECORD:C53([Message:137])
						: (ptCurTable=(->[Letter:20]))
							WA EXECUTE JAVASCRIPT FUNCTION:C1043(WebTech; "getContent"; tinyMCE_Content_t)
							[Letter:20]body:2:=tinyMCE_Content_t
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("Prs_RayRebuild"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[Rep:8]))
							[Rep:8]dateTimeSync:16:=DateTime_DTTo
							SAVE RECORD:C53([Rep:8])
							$processNum:=New process:C317("setChReps"; <>tcPrsMemory; "ChoiceArray")
							//
						: (ptCurTable=(->[ItemSpec:31]))
							
							SAVE RECORD:C53([ItemSpec:31])
						: (ptCurTable=(->[ItemSerial:47]))
							If ((vMod) | (Modified record:C314([ItemSerial:47])))
								vMod:=False:C215
								$doLock:=False:C215
								If (Not:C34(Modified record:C314([ItemSerial:47])))
									READ WRITE:C146([ItemSerial:47])
									LOAD RECORD:C52([ItemSerial:47])
									[ItemSerial:47]comments:23:=vText1
									$doLock:=True:C214
								End if 
								SAVE RECORD:C53([ItemSerial:47])
								If ($doLock)
									READ ONLY:C145([ItemSerial:47])
								End if 
							End if 
							
						: (ptCurTable=(->[Term:37]))
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("setChTerms"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[DefaultAccount:32]))
							SAVE RECORD:C53([DefaultAccount:32])
							jSetPayTypes
						: (ptCurTable=(->[Currency:61]))
							SAVE RECORD:C53([Currency:61])
							$processNum:=New process:C317("setCurrencyRay"; <>tcPrsMemory; "ChoiceArray")
							//
						: (ptCurTable=(->[RemoteUser:57]))
							SAVE RECORD:C53([RemoteUser:57])
							
						: (ptCurTable=(->[zzzDialingInfo:81]))
							Dial_AcceptDI
						: (ptCurTable=(->[CronJob:82]))
							[CronJob:82]dtNextEvent:20:=CronDTNext([CronJob:82]cronString:28)
							SAVE RECORD:C53(ptCurTable->)
							CronJobStartup
						: ((ptCurTable=(->[QAQuestion:71])) | (ptCurTable=(->[QAQuestion:71])) | (ptCurTable=(->[TallyMaster:60])) | (ptCurTable=(->[zzzWOTemplate:69])))
							SAVE RECORD:C53(ptCurTable->)
							$processNum:=New process:C317("Prs_RayRebuild"; <>tcPrsMemory; "ChoiceArray")
						: (ptCurTable=(->[BOM:21]))  //Items
							//[Item]DTSync:=DateTime_DTTo
							AcceptBOM
						: (ptCurTable=(->[WebClerk:78]))
							SAVE RECORD:C53(ptCurTable->)
						: (ptCurTable=(->[WorkOrder:66]))
							If ([WorkOrder:66]dtCreated:44=0)
								[WorkOrder:66]dtCreated:44:=DateTime_DTTo
							End if 
							// ### bj ### 20201127_2113
							[WorkOrder:66]dtAction:5:=DateTime_DTTo([WorkOrder:66]actionDate:105; [WorkOrder:66]actionTime:111)
							SAVE RECORD:C53(ptCurTable->)
						Else 
							SAVE RECORD:C53(ptCurTable->)
					End case 
					
					If ($keyTagsAtEnd_b)
						var $ptID; $ptObGeneral; $ptkeyTags : Pointer
						var $tableName : Text
						$tableName:=Table name:C256(ptCurTable)
						$ptID:=STR_Get_idPointer($tableName)
						//$ptObGeneral:=STR_GetFieldPointer($tableName; "obGeneral")
						//$ptkeyTags:=STR_GetFieldPointer($tableName; "keyTags")
						//If ($ptObGeneral->=Null)
						//$ptObGeneral->:=New object("keyTags"; ""; "keyText"; "")
						//End if
						
						var $id_t : Text
						$id_t:=$ptID->
						
						UNLOAD RECORD:C212(ptCurTable->)
						$obRec:=ds:C1482[$tableName].query("id = :1"; $id_t).first()
						If ($obRec.obGeneral=Null:C1517)
							$obRec.obGeneral:=Init_obGeneral
						End if 
						$obRec.obGeneral.keyTags:=KeyTagsFromAlphaFields($obRec)
						//$ptObGeneral->keyTags:=KeyTagsFromAlphaFields($obRec)
						If ($obRec.keyTags#Null:C1517)
							$obRec.keyTags:=$obRec.obGeneral.keyTags
						End if 
						$obRec.save()
						process_o.cur:=$obRec
						
					End if 
					
					// Modified by: William James (2014-02-12T00:00:00 Subrecord eliminated)
					//If (In transaction // ### jwm ### 20150911_1704 check added to procedure.
					TransactionValidate
					//Else
					//VALIDATE TRANSACTION
					//End if
					
					<>aLastRecNum{Table:C252(ptCurTable)}:=Record number:C243(ptCurTable->)
					AcceptPostAction(ptCurTable)
					
					RP_SaveRecordtoSyncRecord(ptCurTable)
					// <>aLastRecNum{Table(ptCurTable)}:=Record number(ptCurTable->)
					KeyModifierCurrent
					If ((<>doFlushBuffers) | (cmdKey=1))
						//   TRACE
						FLUSH CACHE:C297
					End if 
					If (ptCurTable#(->[TallyMaster:60]))
						QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="OnSave_"+(Table name:C256(ptCurTable)); *)
						QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="ilo_SaveRec")
						If (Records in selection:C76([TallyMaster:60])=1)
							ExecuteText(0; [TallyMaster:60]script:9)  //no confirm
							REDUCE SELECTION:C351([TallyMaster:60]; 0)
						End if 
					End if 
					If (vIsNewRecord)  //((Not(booSorted)|((booSorted)&(vHere>2)))
						booSorted:=False:C215
						myCycle:=0  //if it is new cancel out of current layout
					End if 
					If (ptCurTable#(->[Base:1]))
						Set_Window_Title(ptCurTable)
					End if 
					//KeyWordsMake(ptCurTable)
					jAcceptCancel
					viNavAccept:=1  //layout accepted
					blockServiceRelate:=False:C215
					vIsNewRecord:=False:C215
					// create a timeout mechanism for perishable things
					//If ((<>tcbDoStat)&(vHere=0))
					//TimeStatus
					//End if
					//If (Records in table([TempRec])>0)  //June 7, 1999
					//ALL RECORDS([TempRec])
					//TempFileClear (Records in selection([TempRec]))
					//End if
				End if 
			End if 
		End if 
	End if 
End if 