//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/08/10, 14:33:46
// ----------------------------------------------------
// Method: WccDeleteRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)
//


vResponse:="Table is not available."
$doPage:=WC_DoPage("Comment.html"; "")
$tableName:=WCapi_GetParameter("TableName"; "")
$theRecordNum:=Num:C11(WCapi_GetParameter("RecordNum"; ""))
C_LONGINT:C283($tableNum; $theRecordNum)
If ($tableName#"")
	$tableNum:=STR_GetTableNumber($tableName)
	If ($tableNum>0)
		ptCurTable:=Table:C252($tableNum)
		error:=0
		If (vWccSecurity<5000)
			vResponse:="You do not have authority to delete."
		Else 
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			
			$doPage:=WC_DoPage("Comment.html"; $jitPageOne)
			
			ptCurTable:=Table:C252($tableNum)
			GOTO RECORD:C242(ptCurTable->; $theRecordNum)
			
			
			myDocName:=Storage:C1525.folder.jitF+"DeleteRecord.out"
			If (HFS_Exists(myDocName)=1)
				$myOK:=HFS_Delete(myDocName)
			End if 
			C_TIME:C306($myDoc)
			$myDoc:=Create document:C266(myDocName)
			If (OK=1)
				CLOSE DOCUMENT:C267($myDoc)
				SET CHANNEL:C77(10; document)
				SEND RECORD:C78(ptCurTable->)
				
				SET CHANNEL:C77(11)
				CREATE RECORD:C68([HistoricalRecord:114])
				
				[HistoricalRecord:114]action:5:="WebClerkDelete"
				[HistoricalRecord:114]dtAction:3:=DateTime_Enter
				[HistoricalRecord:114]tableNum:2:=Table:C252(ptCurTable)
				DOCUMENT TO BLOB:C525(myDocName; [HistoricalRecord:114]recordBlob:6)
				SAVE RECORD:C53([HistoricalRecord:114])
				$myOK:=HFS_Delete(myDocName)
				
				//Records_Out (ptCurTable;Storage.folder.jitExportsF+"WC"+String($tableNum;"00")+"Recs_"+Date_strYrMmDd +".out";0)
				
				vResponse:="Record Deleted."
				Case of 
					: (ptCurTable=(->[Order:3]))  //Orders
						If ([Order:3]dateDocument:4=Current date:C33)
							READ WRITE:C146([OrderLine:49])
							QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
							DELETE SELECTION:C66([OrderLine:49])
							READ ONLY:C145([OrderLine:49])
							DELETE RECORD:C58(ptCurTable->)
						Else 
							vResponse:="Orders entered before today must be delete by an Administrator"
						End if 
					: (ptCurTable=(->[Invoice:26]))  //Invoices
						READ WRITE:C146([InvoiceLine:54])
						QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
						DELETE SELECTION:C66([InvoiceLine:54])
						READ ONLY:C145([InvoiceLine:54])
						DELETE RECORD:C58(ptCurTable->)
						//voidInvoice 
					: (ptCurTable=(->[Customer:2]))
						
						DeleteCustomer
						
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
						QUERY:C277([RepContact:10]; [RepContact:10]repID:1=[Rep:8]RepID:1)
						QUERY:C277([Quota:9]; [Quota:9]repID:1=[Rep:8]RepID:1)
						QUERY:C277([Territory:25]; [Territory:25]repID:2=[Rep:8]RepID:1)
						DELETE SELECTION:C66([RepContact:10])
						DELETE SELECTION:C66([Quota:9])
						DELETE SELECTION:C66([Territory:25])
						DELETE RECORD:C58([Rep:8])
					: (ptCurTable=(->[Proposal:42]))
						READ WRITE:C146([ProposalLine:43])
						QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5)
						DELETE SELECTION:C66([ProposalLine:43])
						READ ONLY:C145([ProposalLine:43])
						DELETE RECORD:C58([Proposal:42])
					: (ptCurTable=(->[PO:39]))
						READ WRITE:C146([POLine:40])
						QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
						DELETE SELECTION:C66([POLine:40])
						READ ONLY:C145([POLine:40])
						DELETE RECORD:C58([PO:39])
					: (ptCurTable=(->[InventoryStack:29]))
						voidCurAdj
					: (ptCurTable=(->[TechNote:58]))
						TN_Void
					: (ptCurTable=(->[Payment:28]))
						DELETE RECORD:C58([Payment:28])
					: (ptCurTable=(->[CronJob:82]))
						DELETE RECORD:C58([CronJob:82])
					Else 
						DELETE RECORD:C58(ptCurTable->)
				End case 
			End if 
		End if 
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
//
