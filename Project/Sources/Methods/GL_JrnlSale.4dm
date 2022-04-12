//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/11/10, 13:18:33
// ----------------------------------------------------
// Method: GL_JrnlSale
// Description
// gkgkgk  // same
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Archive"))
	C_LONGINT:C283($w; $k; $r; $result)
	C_POINTER:C301($ptAcct)
	C_TEXT:C284($V1; $v2; $v3)
	C_LONGINT:C283($k; $w; $k; $r; $cntRay; $jrnlCnt)
	C_REAL:C285(myTotalCost)
	C_TEXT:C284($GLSource; $Source; $temName)
	C_DATE:C307($GLDate)
	C_LONGINT:C283($LineInc; $LineCnt)
	C_BOOLEAN:C305($1; $endView)
	C_TIME:C306(sumDoc)
	C_TEXT:C284($temName)
	C_TEXT:C284($myDocName)
	
	C_LONGINT:C283($OK)
	$OK:=0
	Path_Set(Storage:C1525.folder.jitAudits)
	If (Count parameters:C259=1)
		QUERY:C277([Invoice:26]; <>ptInvoiceDateFld->>=vdDateBeg; *)
		QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=vdDateEnd; *)
		QUERY:C277([Invoice:26];  & [Invoice:26]jrnlComplete:48=False:C215)
		If (Records in selection:C76([Invoice:26])>0)
			
			$myDocName:=Storage:C1525.folder.jitAudits+vSJName  //
			sumDoc:=EI_UniqueDoc($myDocName)
			$OK:=OK
		Else 
			$OK:=0
		End if 
	Else 
		QUERY:C277([Invoice:26]; [Invoice:26]jrnlComplete:48=False:C215)
		jsetDefaultFile(->[Invoice:26])
		myOK:=5000
		File_Select("Pending Invoices are in the Current Selection. Click OK to proceed.")
		$OK:=OK
		If (($OK=1) & (Records in selection:C76([Invoice:26])>0))
			$temName:="SJ"+Date_strYrMmDd(Current date:C33)
			sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitAudits+$temName+".txt")
		Else 
			$OK:=0
		End if 
	End if 
	CLEAR VARIABLE:C89(vSJName)
	If ($OK=1)
		GL_SumRayInit(0)
		
		//  create record([SalesJournal])
		$jrnlCnt:=[SalesJournal:50]idNum:11
		$GLSource:="SJ "+String:C10($jrnlCnt; "0000-0000")
		$GLDate:=Current date:C33
		SEND PACKET:C103(sumDoc; "Converted Invoices; "+String:C10(Current time:C178)+"; "+String:C10(Current date:C33)+"."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "Converting "+String:C10(Records in selection:C76([Invoice:26]))+" records selected."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "CusCode"+"\t"+"Company"+"\t"+"Dvsn"+"\t"+"Ship Date"+"\t"+"Inv #"+"\t"+"Inv Total"+"\r"+"\r")
		CREATE EMPTY SET:C140([Invoice:26]; "Linked")
		CREATE EMPTY SET:C140([Invoice:26]; "Skipped")
		CREATE EMPTY SET:C140([SalesJournal:50]; "Journals")
		CREATE SET:C116([Invoice:26]; "Original")
		myTotalCost:=0
		READ ONLY:C145([Customer:2])
		READ ONLY:C145([TaxJurisdiction:14])
		ALL RECORDS:C47([DefaultAccount:32])
		FIRST RECORD:C50([DefaultAccount:32])
		C_POINTER:C301(ptSales; ptCost; ptInv)
		ptSales:=(->[DefaultAccount:32]itemSalesAcct:24)
		ptCost:=(->[DefaultAccount:32]itemCostofGoods:25)
		ptInv:=(->[DefaultAccount:32]itemInventory:26)
		ORDER BY:C49([Invoice:26]; [Invoice:26]idNum:2)
		$k:=Records in selection:C76([Invoice:26])
		//ThermoInitExit ("Converting New Invoices";$k;True)
		$viProgressID:=Progress New
		
		READ WRITE:C146([Invoice:26])
		READ WRITE:C146([InvoiceLine:54])
		FIRST RECORD:C50([Invoice:26])
		For ($w; 1; $k)
			//Thermo_Update ($w)
			ProgressUpdate($viProgressID; $w; $k; "Converting New Invoices")
			
			If (<>ThermoAbort)
				$w:=$k
			End if 
			LOAD RECORD:C52([Invoice:26])
			Case of 
				: ([Invoice:26]jrnlComplete:48)
					SEND PACKET:C103(sumDoc; String:C10([Invoice:26]idNum:2; "0000-0000")+" Skipped: Already converted."+"\r"+"\r")
					ADD TO SET:C119([Invoice:26]; "Skipped")
				: ([Invoice:26]consignment:63="Consign@")
					// changed # "" to "consign@" for being consigned
					// : (Not(([Invoice]Consignment="") | ([Invoice]Consignment="Complete@")))
					// Modified by: Bill James (2017-12-18T00:00:00)
					SEND PACKET:C103(sumDoc; String:C10([Invoice:26]idNum:2; "0000-0000")+" Skipped: Revenue Status is "+[Invoice:26]consignment:63+"."+"\r"+"\r")
					ADD TO SET:C119([Invoice:26]; "Skipped")
					//: (not([Invoice]Consignment="Complete@"))
					// SEND PACKET(sumDoc;String([Invoice]InvoiceNum;"0000-0000")+" Revenue Status is "+[Invoice]Consignment+"."+"\r"+"\r")
					//  ADD TO SET([Invoice];"Skipped")
				: (Locked:C147([Invoice:26]))
					SEND PACKET:C103(sumDoc; String:C10([Invoice:26]idNum:2; "0000-0000")+" Skipped: Locked."+"\r"+"\r")
					ADD TO SET:C119([Invoice:26]; "Skipped")
				Else 
					QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
					GL_AcctRayInit(0)
					GL_JrnlHdr([Invoice:26]total:18; [DefaultAccount:32]acctReceivables:8)
					If ([Customer:2]customerID:1#[Invoice:26]customerID:3)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
					End if 
					
					// Modified by: Bill James (2016-10-03T00:00:00)  would leave the an empty Journal if there
					// were commission but no RepID 
					
					If ([Invoice:26]repCommission:28#0)
						If ([Invoice:26]repID:22="")
							GL_JrnlHdr(-[Invoice:26]repCommission:28; [DefaultAccount:32]commRepPay:10)  //  
							GL_JrnlHdr([Invoice:26]repCommission:28; [DefaultAccount:32]commRepExp:12)  //  
						Else 
							If ([Rep:8]RepID:1=[Invoice:26]repID:22)
								$ptAcct:=->[Rep:8]commPayGLAcct:18
							Else 
								QUERY:C277([Rep:8]; [Rep:8]RepID:1=[Invoice:26]repID:22)
								If (Records in selection:C76([Rep:8])=1)
									$ptAcct:=->[Rep:8]commPayGLAcct:18
								Else 
									SEND PACKET:C103(sumDoc; "Default account code for Rep Commission:  "+String:C10([Invoice:26]repCommission:28)+".")
									$ptAcct:=->[DefaultAccount:32]commRepPay:10
								End if 
							End if 
							GL_JrnlHdr(-[Invoice:26]repCommission:28; $ptAcct->)
							GL_JrnlHdr([Invoice:26]repCommission:28; [DefaultAccount:32]commRepExp:12)
						End if 
					End if 
					
					If ([Invoice:26]salesCommission:36#0)
						GL_JrnlHdr(-[Invoice:26]salesCommission:36; [DefaultAccount:32]commEmpPay:2)
						GL_JrnlHdr([Invoice:26]salesCommission:36; [DefaultAccount:32]commEmpExp:6)
					End if 
					GL_JrnlHdr(-[Invoice:26]shipTotal:20; [DefaultAccount:32]freightRevenue:14)
					If ([Invoice:26]salesTax:19#0)
						QUERY:C277([TaxJurisdiction:14]; [TaxJurisdiction:14]taxJurisdiction:1=[Invoice:26]taxJuris:33)
						If (Records in selection:C76([TaxJurisdiction:14])=1)
							GL_JrnlHdr(-[Invoice:26]salesTax:19; [TaxJurisdiction:14]taxPayGLAcct:4)
						Else 
							SEND PACKET:C103(sumDoc; "Default account code for Taxes Payable:  "+String:C10([Invoice:26]salesTax:19)+".")
							GL_JrnlHdr(-[Invoice:26]salesTax:19; [DefaultAccount:32]taxPayable:16)
						End if 
					End if 
					If ([Invoice:26]taxOnCost:88#0)
						QUERY:C277([TaxJurisdiction:14]; [TaxJurisdiction:14]taxJurisdiction:1=[Invoice:26]taxJuris:33)
						If (Records in selection:C76([TaxJurisdiction:14])=1)
							GL_JrnlHdr(-[Invoice:26]taxOnCost:88; [TaxJurisdiction:14]taxPayGLAcct:4)
						Else 
							SEND PACKET:C103(sumDoc; "Default account code for Tax on Costs Payable:  "+String:C10([Invoice:26]taxOnCost:88)+".")
							GL_JrnlHdr(-[Invoice:26]taxOnCost:88; [DefaultAccount:32]taxOnCost:85)
						End if 
					End if 
					// Each
					If ([Invoice:26]taxOnShipping:105#0)
						QUERY:C277([TaxJurisdiction:14]; [TaxJurisdiction:14]taxJurisdiction:1=[Invoice:26]taxJuris:33)
						If (Records in selection:C76([TaxJurisdiction:14])=1)
							GL_JrnlHdr(-[Invoice:26]taxOnShipping:105; [TaxJurisdiction:14]taxPayGLAcct:4)
						Else 
							SEND PACKET:C103(sumDoc; "Default account code for Tax on Shipping Payable:  "+String:C10([Invoice:26]taxOnShipping:105)+".")
							GL_JrnlHdr(-[Invoice:26]taxOnShipping:105; [DefaultAccount:32]taxOnShipping:72)
						End if 
					End if 
					// ### bj ### 20181031_2116
					
					
					ORDER BY:C49([InvoiceLine:54]; [InvoiceLine:54]itemNum:4)
					FIRST RECORD:C50([InvoiceLine:54])
					$LineCnt:=Records in selection:C76([InvoiceLine:54])
					For ($LineInc; 1; $LineCnt)
						GL_JrnlLine([InvoiceLine:54]itemNum:4; [InvoiceLine:54]extendedPrice:11; [InvoiceLine:54]extendedCost:13)
						[InvoiceLine:54]glCost:58:=(ptCost->)
						[InvoiceLine:54]glInventory:57:=(ptInv->)
						[InvoiceLine:54]glSales:56:=(ptSales->)
						SAVE RECORD:C53([InvoiceLine:54])
						NEXT RECORD:C51([InvoiceLine:54])
					End for 
					If ([Invoice:26]customerID:3#[Customer:2]customerID:1)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
					End if 
					$balanceTtl:=0
					$cntRay:=Size of array:C274(aGLAll)
					For ($r; 1; $cntRay)
						$balanceTtl:=$balanceTtl+LSDistAmts{$r}
					End for 
					If (($balanceTtl#0) & ([Invoice:26]exchangeRate:61#0) & ([Invoice:26]exchangeRate:61#1) & ([Invoice:26]currency:62#""))
						//TRACE
						If (Abs:C99($balanceTtl)<2)
							GL_JrnlLineAdd(->aGLAll; ->[DefaultAccount:32]currencyDsct:56; ->LSDistAmts; -$balanceTtl)
							$balanceTtl:=0
						End if 
					End if 
					C_TEXT:C284($balError)
					C_REAL:C285($balanceTtl)
					If ($balanceTtl=0)
						$balError:="Balanced"
						$theInvStr:=String:C10([Invoice:26]idNum:2; "0000-0000")
						SEND PACKET:C103(sumDoc; String:C10(Current time:C178)+"\r")
						SEND PACKET:C103(sumDoc; [Invoice:26]customerID:3+"\t"+[Customer:2]company:2+"\t"+$balError+"\t"+String:C10(Invc_PrimeDate)+"\t"+String:C10([Invoice:26]idNum:2; "0000-0000")+"\t"+String:C10([Invoice:26]total:18; <>tcFormatTt)+"\r")
						For ($r; $cntRay; 1; -1)
							If (LSDistAmts{$r}#0)
								$v1:=""
								$v2:=""
								$v3:=""
								$v1:=aGLAll{$r}
								If (LSDistAmts{$r}>0)
									$v2:=String:C10(LSDistAmts{$r}; <>tcFormatTt)
								Else 
									$v3:=String:C10(-LSDistAmts{$r}; <>tcFormatTt)
								End if 
								SEND PACKET:C103(sumDoc; "\t"+"\t"+"\t"+"\t"+"\t"+$theInvStr+"\t"+$v1+"\t"+$v2+"\t"+$v3+"\t"+"\r")
								C_TEXT:C284($division)
								$division:=GL_GetDivsnCust([Invoice:26]customerID:3)
								If ($division#"")
									$Source:=$GLSource+"["+$division+"]"
								Else 
									$Source:=$GLSource
								End if 
								GL_JrnlSummary($v1; $Source; $GLDate; Num:C11($v2); Num:C11($v3); $division)
							Else 
								DELETE FROM ARRAY:C228(aGLAll; $r; 1)
								DELETE FROM ARRAY:C228(LSDistAmts; $r; 1)
							End if 
						End for 
						SEND PACKET:C103(sumDoc; "\r")
						SEND PACKET:C103(sumDoc; String:C10([Invoice:26]idNum:2; "0000-0000")+";  Converted."+"\r"+"\r"+"\r")
						[Invoice:26]jrnlComplete:48:=True:C214
						[Invoice:26]dateLinked:31:=Current date:C33
						[Invoice:26]jrnlid:71:=$jrnlCnt
						Ledger_InvSave
						SAVE RECORD:C53([Invoice:26])
						ADD TO SET:C119([Invoice:26]; "Linked")
					Else 
						SEND PACKET:C103(sumDoc; String:C10(Current time:C178)+"\r")
						SEND PACKET:C103(sumDoc; [Invoice:26]customerID:3+"\t"+[Customer:2]company:2+"\t"+" Skipped: Out of Balance"+"\t"+String:C10(Invc_PrimeDate)+"\t"+String:C10([Invoice:26]idNum:2; "0000-0000")+"\r")
						ADD TO SET:C119([Invoice:26]; "Skipped")
					End if 
			End case 
			UNLOAD RECORD:C212([Invoice:26])
			NEXT RECORD:C51([Invoice:26])
		End for 
		SEND PACKET:C103(sumDoc; "\r"+"\r"+"Summary"+"\r")
		GL_Sum2Records(->[SalesJournal:50]; "Journals"; $jrnlCnt; False:C215)
		//Thermo_Close 
		Progress QUIT($viProgressID)
		UNLOAD RECORD:C212([DefaultAccount:32])
		UNLOAD RECORD:C212([TaxJurisdiction:14])
		READ WRITE:C146([TaxJurisdiction:14])
		UNLOAD RECORD:C212([SalesJournal:50])
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([TallyMaster:60])
		UNLOAD RECORD:C212([TallyResult:73])
		READ WRITE:C146([Customer:2])
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		myTotalCost:=0
		ARRAY TEXT:C222(LCusList; 0)
		ARRAY TEXT:C222(LCusName; 0)
		
		
		CLOSE DOCUMENT:C267(sumDoc)
		
		// ### bj ### 20181110_1639
		
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]name:1:=HFS_ShortName(document)
		[TallyResult:73]purpose:2:="Sales Journal"
		ConsoleMessage("\r"+[TallyResult:73]purpose:2+"\t"+[TallyResult:73]name:1)
		
		[TallyResult:73]dtCreated:11:=DateTime_Enter
		[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
		[TallyResult:73]textBlk1:5:=document
		[TallyResult:73]nameProfile1:26:="Document Type"
		[TallyResult:73]profile1:17:="txt"
		ConsoleMessage([TallyResult:73]nameProfile1:26+"\t"+[TallyResult:73]profile1:17)
		
		[TallyResult:73]nameProfile2:27:="Jrnl ID"
		[TallyResult:73]profile2:18:=$GLSource
		ConsoleMessage([TallyResult:73]nameProfile2:27+"\t"+[TallyResult:73]profile2:18)
		
		[TallyResult:73]nameReal1:20:="Invoice"
		[TallyResult:73]real1:13:=Records in set:C195("Original")
		ConsoleMessage([TallyResult:73]nameReal1:20+"\t"+String:C10([TallyResult:73]real1:13))
		
		[TallyResult:73]nameReal2:21:="Linked"
		[TallyResult:73]real2:14:=Records in set:C195("Linked")
		ConsoleMessage([TallyResult:73]nameReal2:21+"\t"+String:C10([TallyResult:73]real2:14))
		
		[TallyResult:73]nameReal3:22:="Skipped"
		[TallyResult:73]real3:15:=Records in set:C195("Skipped")
		ConsoleMessage([TallyResult:73]nameReal3:22+"\t"+String:C10([TallyResult:73]real3:15))
		
		[TallyResult:73]nameReal4:23:="Journals Created"
		[TallyResult:73]real4:16:=Records in set:C195("Journals")
		ConsoleMessage([TallyResult:73]nameReal4:23+"\t"+String:C10([TallyResult:73]real4:16))
		
		[TallyResult:73]textBlk2:6:=Document to text:C1236(document)
		
		SAVE RECORD:C53([TallyResult:73])
		
		CONFIRM:C162("Open Journal"; "Skip"; "Open Journal")
		
		If (OK=0)
			OPEN URL:C673(document)
		End if 
		
		C_LONGINT:C283($uniqueID)
		C_TEXT:C284($script)
		$uniqueID:=[TallyResult:73]idNum:35  // get the uniqueID
		
		booSendDoc:=False:C215
		
		USE SET:C118("Linked")
		If (Records in selection:C76([Invoice:26])>0)
			ProcessTableOpen(Table:C252(->[Invoice:26]); ""; "Linked")
		End if 
		REDUCE SELECTION:C351([Invoice:26]; 0)
		
		USE SET:C118("Skipped")
		If (Records in selection:C76([Invoice:26])>0)
			ProcessTableOpen(Table:C252(->[Invoice:26]); ""; "Skipped")
		End if 
		REDUCE SELECTION:C351([Invoice:26]; 0)
		
		USE SET:C118("Original")
		If (Records in selection:C76([Invoice:26])>0)
			ProcessTableOpen(Table:C252(->[Invoice:26]); ""; "Original")
		End if 
		REDUCE SELECTION:C351([Invoice:26]; 0)
		
		USE SET:C118("Journals")
		If (Records in selection:C76([SalesJournal:50])>0)
			ProcessTableOpen(Table:C252(->[SalesJournal:50]); ""; "Created")
		End if 
		REDUCE SELECTION:C351([Invoice:26]; 0)
		// ### bj ### 20181110_1707 
		
		
		$script:="Query([TallyResult];[TallyResult]UniqueID="+String:C10($uniqueID)+")"
		REDUCE SELECTION:C351([TallyResult:73]; 0)
		
		$vtMessage:="Open TallyResults Record."+"\r\r"+"WARNING: This may take a while"
		CONFIRM:C162($vtMessage; "Skip"; "Open TallyResults")
		
		If (OK=0)
			ProcessTableOpen(Table:C252(->[TallyResult:73]); $script; "SJ: "+$GLSource)
		End if 
		
		If (False:C215)
			jsetDefaultFile(->[PopUp:23])
			jNavResetSplash
		End if 
	End if 
	CLEAR SET:C117("Linked")
	CLEAR SET:C117("Skipped")
	CLEAR SET:C117("Original")
	CLEAR SET:C117("Journals")
End if 