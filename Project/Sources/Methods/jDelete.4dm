//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-05-25T00:00:00, 20:54:57
// ----------------------------------------------------
// Method: jDelete
// Description
// Modified: 05/25/13
// 
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150415_1059 Carriers & related records

If (UserInPassWordGroup("UnlockRecord"))
	C_TEXT:C284($x)
	C_LONGINT:C283($i; InRelatedRec)
	C_BOOLEAN:C305($booConfirm; $doThis)
	MESSAGES OFF:C175
	If (Not:C34(jRestrictedFile))
		$doThis:=False:C215
		If (vHere>1)
			CREATE SET:C116(ptCurTable->; "Current")
			ONE RECORD SELECT:C189(ptCurTable->)
			CREATE SET:C116(ptCurTable->; "Diff")
			DIFFERENCE:C122("Current"; "Diff"; "Current")
			$doThis:=True:C214
		Else 
			If (Records in set:C195("UserSet")=0)
				ALERT:C41("There must be records HIGHLIGHTED to identify the ones to be DELETED/VOIDED.")
				$doThis:=False:C215
			Else 
				CREATE SET:C116(ptCurTable->; "Current")
				COPY SET:C600("UserSet"; "ServerSet")
				DIFFERENCE:C122("Current"; "ServerSet"; "Current")
				CLEAR SET:C117("ServerSet")
				USE SET:C118("UserSet")  //select the highlighted records
				$doThis:=True:C214
				CREATE EMPTY SET:C140(ptCurTable->; "Skipped")
			End if 
			
		End if 
		If ($doThis)
			READ WRITE:C146(ptCurTable->)
			ARRAY LONGINT:C221($aRecNum; 0)
			SELECTION TO ARRAY:C260(ptCurTable->; $aRecNum)
			BEEP:C151
			BEEP:C151
			If (allowAlerts_boo)
				CONFIRM:C162("You are about to permanently "+"\r"+"remove "+String:C10(Size of array:C274($aRecNum))+" "+Table name:C256(ptCurTable)+" records!?!?!")
			Else 
				OK:=1
			End if 
			$doThis:=(OK=1)
			If ($doThis)
				BEEP:C151
				BEEP:C151
				If (allowAlerts_boo)
					CONFIRM:C162("Do you SERIOUSLY want to DELETE Records.  There is no UnDo!!")
				Else 
					OK:=1
				End if 
				$doThis:=(OK=1)
				If ($doThis)
					$k:=Size of array:C274($aRecNum)
					For ($i; 1; $k)
						GOTO RECORD:C242(ptCurTable->; $aRecNum{$i})
						Case of 
							: (ptCurTable=(->[Order:3]))  //Orders
								voidCurOrder
								//voidOrder 
							: (ptCurTable=(->[Invoice:26]))  //Invoices
								voidCurInvoice
								//voidInvoice 
							: (ptCurTable=(->[Customer:2]))
								DeleteCustomer
							: (ptCurTable=(->[Carrier:11]))  // ### jwm ### 20150415_1059 Carriers & related records
								QUERY:C277([CarrierWeight:144]; [CarrierWeight:144]idNumCarrier:13=[Carrier:11]idNum:44)
								QUERY:C277([CarrierZone:143]; [CarrierZone:143]idNumCarrier:6=[Carrier:11]idNum:44)
								DELETE SELECTION:C66([CarrierWeight:144])
								DELETE SELECTION:C66([CarrierZone:143])
								DELETE RECORD:C58([Carrier:11])
							: (ptCurTable=(->[Contact:13]))
								QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=13; *)  //customer file number
								QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=String:C10([Contact:13]idNum:28))
								DELETE SELECTION:C66([CallReport:34])
								QUERY:C277([QA:70]; [QA:70]tableNum:11=13; *)  //customer file number
								QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Contact:13]idNum:28))
								DELETE SELECTION:C66([QA:70])
								DELETE RECORD:C58([Contact:13])
							: (ptCurTable=(->[Item:4]))
								QUERY:C277([BOM:21]; [BOM:21]childItem:2=[Item:4]itemNum:1)
								QUERY:C277([ItemSpec:31]; [ItemSpec:31]itemNum:1=[Item:4]specid:62)
								QUERY:C277([ItemXRef:22]; [ItemXRef:22]itemNumMaster:1=[Item:4]itemNum:1)
								QUERY:C277([DInventory:36]; [DInventory:36]itemNum:1=[Item:4]itemNum:1)
								QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=[Item:4]itemNum:1)
								DELETE SELECTION:C66([ItemSerial:47])
								DELETE SELECTION:C66([DInventory:36])
								DELETE SELECTION:C66([ItemSpec:31])
								DELETE SELECTION:C66([ItemXRef:22])
								DELETE SELECTION:C66([BOM:21])
								DELETE RECORD:C58([Item:4])
							: (ptCurTable=(->[Rep:8]))
								QUERY:C277([RepContact:10]; [RepContact:10]repID:1=[Rep:8]repID:1)
								QUERY:C277([Quota:9]; [Quota:9]repID:1=[Rep:8]repID:1)
								QUERY:C277([Territory:25]; [Territory:25]repID:2=[Rep:8]repID:1)
								DELETE SELECTION:C66([RepContact:10])
								DELETE SELECTION:C66([Quota:9])
								DELETE SELECTION:C66([Territory:25])
								DELETE RECORD:C58([Rep:8])
							: (ptCurTable=(->[Proposal:42]))
								READ WRITE:C146([ProposalLine:43])
								QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
								DELETE SELECTION:C66([ProposalLine:43])
								READ ONLY:C145([ProposalLine:43])
								DELETE RECORD:C58([Proposal:42])
							: (ptCurTable=(->[PO:39]))
								voidCurPO
								//              booPreNext:=True  //why was this here causes the 4D screen to appea
								//                                             December 27, 1993
							: (ptCurTable=(->[InventoryStack:29]))
								voidCurAdj
							: (ptCurTable=(->[POReceipt:95]))
								READ WRITE:C146([InventoryStack:29])
								QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=[POReceipt:95]idNum:1)
								DELETE SELECTION:C66([InventoryStack:29])
								READ ONLY:C145([InventoryStack:29])
								DELETE RECORD:C58([POReceipt:95])
							: (ptCurTable=(->[TechNote:58]))
								TN_Void
							: (ptCurTable=(->[Payment:28]))
								READ WRITE:C146([Ledger:30])
								QUERY:C277([Ledger:30]; [Ledger:30]docRefid:4=[Payment:28]idNum:8; *)
								QUERY:C277([Ledger:30];  & [Ledger:30]tableNum:3=Table:C252(->[Payment:28]))
								// zzzqqq jDateTimeStamp(->[Ledger:30]comment:7)
								[Ledger:30]comment:7:="Payment deleted: "+String:C10([Ledger:30]unAppliedValue:6)
								[Ledger:30]unAppliedValue:6:=0
								SAVE RECORD:C53([Ledger:30])
								UNLOAD RECORD:C212([Ledger:30])
								DELETE RECORD:C58([Payment:28])
							: (ptCurTable=(->[CronJob:82]))
								DELETE RECORD:C58([CronJob:82])
							: (ptCurTable=(->[LoadTag:88]))  //Orders
								//PUSH RECORD([LoadTag])  //do this for pallets at some time.
								QUERY:C277([LoadItem:87]; [LoadItem:87]loadTagid:8=[LoadTag:88]idNum:1)
								DELETE SELECTION:C66([LoadItem:87])
								DELETE RECORD:C58([LoadTag:88])
							Else 
								DELETE RECORD:C58(ptCurTable->)
						End case 
						If ((Record number:C243(ptCurTable->)>-1) & (vHere<2))
							ADD TO SET:C119(ptCurTable->; "Skipped")
						End if 
					End for 
				End if 
			End if 
			Case of 
				: (Records in set:C195("Skipped")>0)
					ALERT:C41("These records VOIDED or not deleted.")
					USE SET:C118("Skipped")
				: (Records in set:C195("Current")>0)
					USE SET:C118("Current")
			End case   //restore the unselected records  
			CLEAR SET:C117("Skipped")  //don't let the set hang around unnecessarily       
			CLEAR SET:C117("Current")  //don't let the set hang around unnecessarily           
			If ((vHere>1) | (Records in selection:C76(ptCurTable->)=0))
				$booConfirm:=<>booConfirm
				<>booConfirm:=False:C215
				jCancelButton
				<>booConfirm:=$booConfirm
			End if 
			ReadOnlyFiles
		End if 
	End if 
	TallyInventory
	MESSAGES ON:C181
End if 