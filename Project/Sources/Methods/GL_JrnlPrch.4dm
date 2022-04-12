//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 05:53:23
// ----------------------------------------------------
// Method: GL_JrnlPrch
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20150430_1611 added ".txt" file extension

If (UserInPassWordGroup("Archive"))
	C_TEXT:C284($V1; $v2; $v3; $Company)
	C_LONGINT:C283($r; $cntRay; $jrnlCnt; $result; $w; $k; $r)
	C_TEXT:C284($GLSource; $Source)
	C_DATE:C307($GLDate)
	C_BOOLEAN:C305($1; $endView)
	C_TEXT:C284($temName)
	C_TEXT:C284($myDocName)
	C_LONGINT:C283($OK)
	$OK:=0
	//
	Path_Set(Storage:C1525.folder.jitAudits)
	If (Count parameters:C259=1)
		QUERY:C277([InventoryStack:29]; [InventoryStack:29]dateEntered:3>=vdDateBeg; *)
		QUERY:C277([InventoryStack:29];  & [InventoryStack:29]dateEntered:3<=vdDateEnd; *)
		QUERY:C277([InventoryStack:29];  & [InventoryStack:29]jrnlComplete:13=False:C215)
		If (Records in selection:C76([InventoryStack:29])>0)  // ### jwm ### 20190110_0928
			$myDocName:=Storage:C1525.folder.jitAudits+vPJName
			sumDoc:=EI_UniqueDoc($myDocName)
			$OK:=OK
		Else 
			$OK:=0
		End if 
	Else 
		QUERY:C277([InventoryStack:29]; [InventoryStack:29]jrnlComplete:13=False:C215)
		jsetDefaultFile(->[InventoryStack:29])
		myOK:=5000
		File_Select("Pending Receipts are in the Current Selection. Click OK to proceed.")
		$OK:=OK
		If (($OK=1) & (Records in selection:C76([InventoryStack:29])>0))
			$temName:="PJ"+Date_strYrMmDd(Current date:C33)+".txt"  // ### jwm ### 20150430_1611
			sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitAudits+$temName)
		Else 
			$OK:=0
		End if 
	End if 
	CLEAR VARIABLE:C89(vPJName)
	//
	If ($OK=1)
		SEND PACKET:C103(sumDoc; "Converted Stacks; "+String:C10(Current time:C178)+"; "+String:C10(Current date:C33)+"."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "Converting "+String:C10(Records in selection:C76([InventoryStack:29]))+" records selected."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "VendorCode"+"\t"+"Vendor"+"\t"+"Dvsn"+"\t"+"Ship Date"+"\t"+"Stack #"+"\t"+"Stack Total"+"\r"+"\r")
		CREATE EMPTY SET:C140([InventoryStack:29]; "Linked")
		CREATE EMPTY SET:C140([InventoryStack:29]; "Skipped")
		CREATE EMPTY SET:C140([PurchaseJournal:51]; "Journals")
		CREATE SET:C116([InventoryStack:29]; "Original")
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		$jrnlCnt:=[PurchaseJournal:51]idNum:11  // CounterNew(->[PurchaseJournal])
		$GLSource:="PJ "+String:C10($jrnlCnt; "0000-0000")
		$GLDate:=Current date:C33
		myTotalCost:=0
		ALL RECORDS:C47([DefaultAccount:32])
		FIRST RECORD:C50([DefaultAccount:32])
		ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]itemNum:2)
		// lnkInvPartRay 
		$k:=Records in selection:C76([InventoryStack:29])
		//ThermoInitExit ("Converting Inships";$k;True)
		$viProgressID:=Progress New
		
		READ ONLY:C145([Vendor:38])
		READ WRITE:C146([InventoryStack:29])
		FIRST RECORD:C50([InventoryStack:29])
		For ($w; 1; $k)
			//Thermo_Update ($w)
			ProgressUpdate($viProgressID; $w; $k; "Converting Inships")
			If (<>ThermoAbort)
				$w:=$k
			End if 
			LOAD RECORD:C52([InventoryStack:29])
			Case of 
				: ([InventoryStack:29]jrnlComplete:13)
					SEND PACKET:C103(sumDoc; String:C10([InventoryStack:29]idNum:1)+" SKIPPED: Already Journaled."+"\r"+"\r")
					ADD TO SET:C119([InventoryStack:29]; "Skipped")
				: (Locked:C147([InventoryStack:29]))
					SEND PACKET:C103(sumDoc; String:C10([InventoryStack:29]idNum:1)+" SKIPPED: Locked Record."+"\r"+"\r")
					ADD TO SET:C119([InventoryStack:29]; "Skipped")
				: ([InventoryStack:29]extendedCost:17=0)
					SEND PACKET:C103(sumDoc; String:C10([InventoryStack:29]idNum:1)+" SKIPPED: Extended Cost = 0 \r Not converted; No Payable; Marked Complete."+"\r"+"\r")
					[InventoryStack:29]jrnlComplete:13:=True:C214
					[InventoryStack:29]jrnlCompleted:18:=Current date:C33
					SAVE RECORD:C53([InventoryStack:29])
					ADD TO SET:C119([InventoryStack:29]; "Skipped")
				Else 
					GL_AcctRayInit(0)
					If ([InventoryStack:29]itemNum:2#[Item:4]itemNum:1)
						QUERY:C277([Item:4]; [Item:4]itemNum:1=[InventoryStack:29]itemNum:2)
					End if 
					If (Records in selection:C76([Item:4])=1)
						ptInv:=->[Item:4]inventoryGlAccount:23
					Else 
						ptInv:=->[DefaultAccount:32]itemInventory:26
					End if 
					GL_JrnlLineAdd(->aGLAll; ptInv; ->LSDistAmts; [InventoryStack:29]extendedCost:17)
					GL_JrnlLineAdd(->aGLAll; ->[DefaultAccount:32]purchaseAcct:27; ->LSDistAmts; -[InventoryStack:29]extendedCost:17)
					Case of 
						: ([InventoryStack:29]vendorID:10="Manual")
							$Company:="Manual"
						: ([InventoryStack:29]vendorID:10#[Vendor:38]vendorID:1)
							QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[InventoryStack:29]vendorID:10)
							$Company:=[Vendor:38]company:2
					End case 
					//                $cntRay:=Size of array(aGLAll)
					$balanceTtl:=0
					For ($r; 1; $cntRay)
						$balanceTtl:=$balanceTtl+LSDistAmts{$r}
					End for 
					C_TEXT:C284($balError)
					C_REAL:C285($balanceTtl)
					If ($balanceTtl=0)
						$balError:="Balanced"
					Else 
						$balError:="Error"
					End if 
					//  
					C_TEXT:C284($payID)
					$payID:=String:C10([InventoryStack:29]idNum:1)
					SEND PACKET:C103(sumDoc; String:C10(Current time:C178)+"\r")  //
					SEND PACKET:C103(sumDoc; [InventoryStack:29]vendorID:10+"\t"+$Company+"\t"+$balError+"\t"+String:C10([InventoryStack:29]dateEntered:3)+"\t"+String:C10([InventoryStack:29]docid:5)+"\t"+String:C10([InventoryStack:29]extendedCost:17; <>tcFormatTt)+"\r")
					$cntRay:=2  //Size of array(aGLAll)
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
							SEND PACKET:C103(sumDoc; "\t"+"\t"+"\t"+"\t"+$payID+"\t"+$v1+"\t"+$v2+"\t"+$v3+"\t"+String:C10([InventoryStack:29]receiptid:16)+"\t"+String:C10([InventoryStack:29]docid:5)+"\t"+[InventoryStack:29]vendorID:10+"\t"+[InventoryStack:29]itemNum:2+"\r")
							C_TEXT:C284($division)
							$division:=GL_GetDivsnPO([InventoryStack:29]docid:5)
							If ($division#"")
								$Source:=$GLSource+"["+String:C10($division)+"]"
							Else 
								$Source:=$GLSource
							End if 
							GL_JrnlSummary(aGLAll{$r}; $Source; $GLDate; Num:C11($v2); Num:C11($v3); $division)
						Else 
							DELETE FROM ARRAY:C228(aGLAll; $r; 1)
							DELETE FROM ARRAY:C228(LSDistAmts; $r; 1)
						End if 
					End for 
					SEND PACKET:C103(sumDoc; "\r"+"\r")
					[InventoryStack:29]jrnlComplete:13:=True:C214
					[InventoryStack:29]jrnlCompleted:18:=Current date:C33
					[InventoryStack:29]jrnlid:25:=$jrnlCnt
					// ### bj ### 20181110_2142
					SAVE RECORD:C53([InventoryStack:29])
					ADD TO SET:C119([InventoryStack:29]; "Linked")
			End case 
			UNLOAD RECORD:C212([InventoryStack:29])
			NEXT RECORD:C51([InventoryStack:29])
		End for 
		GL_Sum2Records(->[PurchaseJournal:51]; "Journals"; $jrnlCnt; False:C215)
		//Thermo_Close 
		Progress QUIT($viProgressID)
		
		UNLOAD RECORD:C212([Vendor:38])
		READ WRITE:C146([Vendor:38])
		UNLOAD RECORD:C212([DefaultAccount:32])
		UNLOAD RECORD:C212([PurchaseJournal:51])
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		myTotalCost:=0
		ARRAY TEXT:C222(LCusList; 0)
		ARRAY TEXT:C222(LCusName; 0)
		//  arrayPartClr //July 12, 1995
		CLOSE DOCUMENT:C267(sumDoc)
		
		
		
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]name:1:=HFS_ShortName(document)
		[TallyResult:73]purpose:2:="Purchase Journal"
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
		
		// ### bj ### 20181119_2355
		[TallyResult:73]nameReal1:20:="InventoryStack"
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
		
		// ### bj ### 20181229_0646
		
		C_LONGINT:C283($uniqueID)
		C_TEXT:C284($script)
		$uniqueID:=[TallyResult:73]idNum:35  // get the uniqueID
		
		booSendDoc:=False:C215
		
		USE SET:C118("Linked")
		If (Records in selection:C76([InventoryStack:29])>0)
			ProcessTableOpen(Table:C252(->[InventoryStack:29]); ""; "Linked")
		End if 
		REDUCE SELECTION:C351([InventoryStack:29]; 0)
		
		USE SET:C118("Skipped")
		If (Records in selection:C76([InventoryStack:29])>0)
			ProcessTableOpen(Table:C252(->[InventoryStack:29]); ""; "Skipped")
		End if 
		REDUCE SELECTION:C351([InventoryStack:29]; 0)
		
		USE SET:C118("Original")
		If (Records in selection:C76([InventoryStack:29])>0)
			ProcessTableOpen(Table:C252(->[InventoryStack:29]); ""; "Original")
		End if 
		REDUCE SELECTION:C351([InventoryStack:29]; 0)
		
		USE SET:C118("Journals")
		If (Records in selection:C76([PurchaseJournal:51])>0)
			ProcessTableOpen(Table:C252(->[PurchaseJournal:51]); ""; "Created")
		End if 
		
		$script:="Query([TallyResult];[TallyResult]UniqueID="+String:C10($uniqueID)+")"
		REDUCE SELECTION:C351([TallyResult:73]; 0)
		
		$vtMessage:="Open TallyResults Record."+"\r\r"+"WARNING: This may take a while"
		CONFIRM:C162($vtMessage; "Skip"; "Open TallyResults")
		
		If (OK=0)
			ProcessTableOpen(Table:C252(->[TallyResult:73]); $script; "PJ: "+$GLSource)
		End if 
		
		CLEAR SET:C117("Linked")
		CLEAR SET:C117("Skipped")
		CLEAR SET:C117("Original")
		CLEAR SET:C117("Journals")
	End if 
End if 