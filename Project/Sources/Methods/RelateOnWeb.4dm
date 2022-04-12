//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: RelateOnWeb
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1; $cntRecs)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)
C_BOOLEAN:C305($doItemTasks; $doDetails)
$doItemTasks:=False:C215
$cntRecs:=Records in selection:C76($2->)
$doDetails:=($cntRecs=1)
//TRACE
Case of 
	: (False:C215)  //(vRelateLevel=5)
		C_TEXT:C284($scriptName)
		$scriptName:=WCapi_GetParameter("jitRelateScript"; "")
		If ($scriptName="")
			Execute_TallyMaster(Table name:C256($2); "RelateWebClerk")
		Else 
			Execute_TallyMaster($scriptName; "RelateWebClerk")
		End if 
	: ($2=(->[ItemXRef:22]))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]itemNumXRef:2)
		$doItemTasks:=True:C214
	: ($2=(->[WebTempRec:101]))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[WebTempRec:101]itemNum:3)
		$doItemTasks:=True:C214
	: ($2=(->[Item:4]))
		$doItemTasks:=True:C214
	: (($2=(->[Proposal:42])) & ($doDetails))
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Proposal:42]customerID:1)
		QUERY:C277([Service:6]; [Service:6]proposalNum:27=[Proposal:42]proposalNum:5; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel)
		QUERY:C277([QA:70]; [QA:70]tableNum:11=(Table:C252(->[Proposal:42])); *)
		QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Proposal:42]proposalNum:5); *)
		If ([Proposal:42]idNumTask:70#0)
			QUERY:C277([QA:70];  | [QA:70]idNumTask:12=[Proposal:42]idNumTask:70; *)
		End if 
		QUERY:C277([QA:70])
		QUERY:C277([ProposalLine:43]; [ProposalLine:43]proposalNum:1=[Proposal:42]proposalNum:5)
		QUERY:C277([Document:100]; [Document:100]event:9=String:C10([Proposal:42]idNumTask:70))
		P_PpHeadVars
		
	: (($2=(->[Order:3])) & ($doDetails))
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
		QUERY:C277([Service:6]; [Service:6]orderNum:22=[Order:3]orderNum:2; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel)
		QUERY:C277([QA:70]; [QA:70]tableNum:11=(Table:C252(->[Order:3])); *)
		QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Order:3]orderNum:2); *)
		If ([Order:3]idNumTask:85#0)
			QUERY:C277([QA:70];  | [QA:70]idNumTask:12=[Order:3]idNumTask:85; *)
		End if 
		QUERY:C277([QA:70])
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		QUERY:C277([POLine:40]; [POLine:40]orderNum:16=[Order:3]orderNum:2)
		QUERY:C277([Document:100]; [Document:100]event:9=String:C10([Order:3]idNumTask:85))
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]idNumTask:22=[Order:3]idNumTask:85)
		QUERY:C277([LoadTag:88]; [LoadTag:88]orderNum:29=[Order:3]orderNum:2)
		P_OrdHeadVars
	: (($2=(->[WorkOrder:66])) & ($doDetails))
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
		QUERY:C277([Order:3]; [Order:3]orderNum:2=[WorkOrder:66]idNumTask:22)
		QUERY:C277([Service:6]; [Service:6]orderNum:22=[Order:3]orderNum:2; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel)
		QUERY:C277([QA:70]; [QA:70]tableNum:11=(Table:C252(->[Order:3])); *)
		QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Order:3]orderNum:2); *)
		If ([Order:3]idNumTask:85#0)
			QUERY:C277([QA:70];  | [QA:70]idNumTask:12=[Order:3]idNumTask:85; *)
		End if 
		QUERY:C277([QA:70])
		QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
		QUERY:C277([POLine:40]; [POLine:40]orderNum:16=[Order:3]orderNum:2)
		QUERY:C277([Document:100]; [Document:100]event:9=String:C10([Order:3]idNumTask:85))
		P_OrdHeadVars
	: (($2=(->[Invoice:26])) & ($doDetails))
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
		QUERY:C277([Service:6]; [Service:6]invoiceNum:23=[Invoice:26]invoiceNum:2; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19>0; *)
		QUERY:C277([Service:6];  & [Service:6]publish:19<=viEndUserSecurityLevel)
		QUERY:C277([QA:70]; [QA:70]tableNum:11=(Table:C252(->[Invoice:26])); *)
		QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Invoice:26]invoiceNum:2); *)
		If ([Invoice:26]idNumTask:78#0)
			QUERY:C277([QA:70];  | [QA:70]idNumTask:12=[Invoice:26]idNumTask:78; *)
		End if 
		QUERY:C277([QA:70])
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
		QUERY:C277([Document:100]; [Document:100]event:9=String:C10([Order:3]idNumTask:85))
		QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
		P_IvcHeadVars
	: (($2=(->[PO:39])) & ($doDetails))
		QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
		QUERY:C277([QA:70]; [QA:70]tableNum:11=(Table:C252(->[PO:39])); *)
		QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([PO:39]poNum:5); *)
		If ([PO:39]idNumTask:69#0)
			QUERY:C277([QA:70];  | [QA:70]idNumTask:12=[PO:39]idNumTask:69; *)
		End if 
		QUERY:C277([QA:70])
		QUERY:C277([POLine:40]; [POLine:40]poNum:1=[PO:39]poNum:5)
		QUERY:C277([Document:100]; [Document:100]event:9=String:C10([PO:39]idNumTask:69))
		QUERY:C277([LoadTag:88]; [LoadTag:88]poNum:18=[PO:39]poNum:5)
		P_IvcHeadVars
	: ($2=(->[POLine:40]))
		If ([POLine:40]poNum:1#[PO:39]poNum:5)
			QUERY:C277([PO:39]; [PO:39]poNum:5=[POLine:40]poNum:1)
		End if 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[POLine:40]itemNum:2)
		$doItemTasks:=True:C214
		
	: ($2=(->[ProposalLine:43]))
		If ([ProposalLine:43]proposalNum:1#[Proposal:42]proposalNum:5)
			QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=[ProposalLine:43]proposalNum:1)
		End if 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[ProposalLine:43]itemNum:2)
		$doItemTasks:=True:C214
	: ($2=(->[OrderLine:49]))
		If ([OrderLine:49]orderNum:1#[Order:3]orderNum:2)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[OrderLine:49]orderNum:1)
		End if 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
		$doItemTasks:=True:C214
		
	: ($2=(->[InvoiceLine:54]))
		If ([InvoiceLine:54]invoiceNum:1#[Invoice:26]invoiceNum:2)
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[InvoiceLine:54]invoiceNum:1)
		End if 
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
		$doItemTasks:=True:C214
	: ($2=(->[TallyResult:73]))  //high risk
		REDUCE SELECTION:C351([Customer:2]; 0)
		REDUCE SELECTION:C351([Item:4]; 0)
		If (([TallyResult:73]tableNum:3=2) & ([TallyResult:73]customerID:30#""))
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[TallyResult:73]customerID:30)
		End if 
		If ([TallyResult:73]itemNum:34#"")
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[TallyResult:73]itemNum:34)
		End if 
	: ($2=(->[MfrCustomerXRef:110]))
		Case of 
			: (vRelateLevel=1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[MfrCustomerXRef:110]customerID:2; *)
				QUERY:C277([Customer:2];  & [Customer:2]zip:8=[MfrCustomerXRef:110]zipCustomer:8)
			: (vRelateLevel>1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[MfrCustomerXRef:110]customerID:2)
		End case 
	: ($2=(->[Ledger:30]))
		$tableName:=Table name:C256([Ledger:30]tableNum:3)
		vLedgerLink:="/Status_Ledgers?TableName="+$tableName+"&documentID="+String:C10([Ledger:30]docRefid:4)
	: ($2=(->[Customer:2]))
		If (vRelateLevel>0)
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
			QUERY:C277([Document:100]; [Document:100]customerID:7=[Customer:2]customerID:1; *)
			QUERY:C277([Document:100];  & [Document:100]tableNum:6=2)
			QUERY:C277([QA:70]; [QA:70]tableNum:11=2; *)
			QUERY:C277([QA:70];  & [QA:70]customerID:1=[Customer:2]customerID:1)
			QUERY:C277([Ledger:30]; [Ledger:30]customerID:1=[Customer:2]customerID:1)
			If (vRelateLevel>1)
				QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]customerID:2=[Customer:2]customerID:1)
				ORDER BY:C49([MfrCustomerXRef:110]; [MfrCustomerXRef:110]manufacturerName:5)
				If (vRelateLevel>2)
					QUERY:C277([ItemCarried:113]; [ItemCarried:113]customerID:6=[OrderLine:49]customerID:2)
					ORDER BY:C49([ItemCarried:113]; [ItemCarried:113]manufacturerName:9)
				End if 
			End if 
		End if 
End case 
If ($doItemTasks)
	// TRACE
	// ### jwm ### 20171103_1333 the method KeywordCombine is entirely commented out
	//vItemKeys:=KeywordCombine (->[Item]KeySub;"=";"; ";8)
	ItemKeyPathVariables  //set price points
	
	If ((<>vlWcGetSpec=1) | ($3))
		Item_GetSpec
		Http_ItemPriceBreaks
		QUERY:C277([BOM:21]; [BOM:21]itemNum:1=[Item:4]itemNum:1)
		C_TEXT:C284(vBOM)
		vBOM:=""
		$k:=Records in selection:C76([BOM:21])
		If ($k>0)
			
			vBOM:="<Table class="+Txt_Quoted("BOMTable")+"><TR class="+Txt_Quoted("BOMTableTitle")+"><TD>Quantity</TD><TD>[BOM]ItemNum</TD>"+"<TD>[BOM]Description</TD></TR>"+"\r"
			FIRST RECORD:C50([BOM:21])
			For ($i; 1; $k)
				vBOM:=vBOM+"<TR><TD>"+String:C10([BOM:21]qtyInAssembly:3)+"</TD><TD>"+[BOM:21]itemNum:1+"</TD><TD>"+[BOM:21]description:6+"</TD></TR>"+"\r"
			End for 
			vBOM:=vBOM+"</Table>"
		End if 
	End if 
	If (([Item:4]reservation:74) & (<>vlPublishReservations<=viEndUserSecurityLevel))
		Http_ItemReservationEach($1)
	End if 
	
	
	
	//WDJ_Why was this here  071112
	//If ($2=(->[WebTempRec]))
	//[WebTempRec]UnitPrice:=pBasePrice
	//[WebTempRec]DiscountedPrice:=pUnitPrice
	//[WebTempRec]ExtendedPrice:=Round(pUnitPrice*pQtyOrdered;<>tcDecimalTt)
	//SAVE RECORD([WebTempRec])
	//End if 
End if 
