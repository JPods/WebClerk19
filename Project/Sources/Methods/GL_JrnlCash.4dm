//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 05:52:23
// ----------------------------------------------------
// Method: GL_JrnlCash
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160823_1307 added payments UniqueID to messages

If (UserInPassWordGroup("Archive"))
	C_LONGINT:C283($w; $k; $findRay; $result; $jrnlCnt)
	C_POINTER:C301($ptDebAcct; $ptCrdAcct)
	C_TEXT:C284($GLSource; $Source)
	C_DATE:C307($GLDate)
	C_BOOLEAN:C305($1; $endView)
	C_TEXT:C284($temName)
	C_TEXT:C284($myDocName)
	Path_Set(Storage:C1525.folder.jitAudits)
	C_LONGINT:C283($OK)
	$OK:=0
	If (Count parameters:C259=1)
		QUERY:C277([Payment:28]; [Payment:28]dateDocument:10>=vdDateBeg; *)
		QUERY:C277([Payment:28];  & [Payment:28]dateDocument:10<=vdDateEnd; *)
		QUERY:C277([Payment:28];  & [Payment:28]status:46#"Hold@"; *)
		QUERY:C277([Payment:28];  & [Payment:28]jrnlComplete:16=False:C215)
		If (Records in selection:C76([Payment:28])>0)
			$myDocName:=Storage:C1525.folder.jitAudits+vCJName
			sumDoc:=EI_UniqueDoc($myDocName)
			$OK:=OK
		Else 
			$OK:=0
		End if 
	Else 
		QUERY:C277([Payment:28]; [Payment:28]jrnlComplete:16=False:C215)
		jsetDefaultFile(->[Payment:28])
		myOK:=5000
		File_Select("Payments are in the Current Selection. Click OK to proceed.")
		$OK:=OK
		If (($OK=1) & (Records in selection:C76([Payment:28])>0))
			$temName:="CJ"+Date_strYrMmDd(Current date:C33)+".txt"
			sumDoc:=EI_UniqueDoc(Storage:C1525.folder.jitAudits+$temName)
		Else 
			$OK:=0
		End if 
	End if 
	CLEAR VARIABLE:C89(vCJName)
	//
	TRACE:C157
	If ($OK=1)
		If ((Size of array:C274(<>aPayTypes)#Size of array:C274(<>aPayDebitAccount)) | (Size of array:C274(<>aPayTypes)#Size of array:C274(<>aPayCreditAccount)) | (Size of array:C274(<>aPayDebitAccount)#Size of array:C274(<>aPayCreditAccount)))
			TRACE:C157
			jSetPayTypes
		End if 
		
		SEND PACKET:C103(sumDoc; "Converted Payments; "+String:C10(Current time:C178)+"; "+String:C10(Current date:C33)+"."+"\r"+"\r")
		SEND PACKET:C103(sumDoc; "Converting "+String:C10(Records in selection:C76([Invoice:26]))+" records selected."+"\r"+"\r")
		CREATE EMPTY SET:C140([Payment:28]; "Linked")
		CREATE EMPTY SET:C140([Payment:28]; "Skipped")
		CREATE SET:C116([Payment:28]; "Original")
		CREATE EMPTY SET:C140([CashJournal:52]; "Journals")
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		$jrnlCnt:=CounterNew(->[zDialingInfo:81])  // this is an ID for [CashJournal]linkID. It is not the UniqueID. That is set automatically
		$GLSource:="CJ "+String:C10($jrnlCnt; "0000-0000")
		$GLDate:=Current date:C33
		myTotalCost:=0
		READ ONLY:C145([Default:15])
		READ ONLY:C145([DefaultAccount:32])
		ALL RECORDS:C47([Default:15])
		FIRST RECORD:C50([Default:15])
		ALL RECORDS:C47([DefaultAccount:32])
		FIRST RECORD:C50([DefaultAccount:32])
		
		ORDER BY:C49([Payment:28]; [Payment:28]idNumInvoice:3)
		$k:=Records in selection:C76([Payment:28])
		//ThermoInitExit ("Converting Payments";$k;True)
		$viProgressID:=Progress New
		READ WRITE:C146([Payment:28])
		
		FIRST RECORD:C50([Payment:28])
		SEND PACKET:C103(sumDoc; String:C10(Current time:C178)+"\r")
		SEND PACKET:C103(sumDoc; "Customer Acct"+"\t"+"Customer"+"\t"+"Invoice"+"\t"+"Date Received"+"\t"+"Payment Type"+"\t"+"Payment"+"\r")
		For ($w; 1; $k)
			//Thermo_Update ($w)
			ProgressUpdate($viProgressID; $w; $k; "Converting Payments")
			If (<>ThermoAbort)
				$w:=$k
			End if 
			$forceBal:=False:C215
			LOAD RECORD:C52([Payment:28])
			// ### jwm ### 20160823_1307 added payments UniqueID to messages
			Case of 
				: ([Payment:28]jrnlComplete:16)
					SEND PACKET:C103(sumDoc; "Customer Acct"+"\t"+"Amount"+"\t"+"Payments UniqueID"+"\t"+"Date Received"+"\t"+"Error"+"\r")
					SEND PACKET:C103(sumDoc; [Payment:28]customerID:4+"\t"+String:C10([Payment:28]amount:1; <>tcFormatTt)+"\t"+String:C10([Payment:28]idNum:8)+"\t"+String:C10([Payment:28]dateDocument:10)+"\t"+" skipped, already converted."+"\r"+"\r")
					ADD TO SET:C119([Payment:28]; "Skipped")
				: (Locked:C147([Payment:28]))
					SEND PACKET:C103(sumDoc; "Customer Acct"+"\t"+"Amount"+"\t"+"Payments UniqueID"+"\t"+"Date Received"+"\t"+"Error"+"\r")
					SEND PACKET:C103(sumDoc; [Payment:28]customerID:4+"\t"+String:C10([Payment:28]amount:1; <>tcFormatTt)+"\t"+String:C10([Payment:28]idNum:8)+"\t"+String:C10([Payment:28]dateDocument:10)+"\t"+" was locked and skipped."+"\r"+"\r")
					ADD TO SET:C119([Payment:28]; "Skipped")
				: ([Payment:28]status:46="Hold@")
					SEND PACKET:C103(sumDoc; "Customer Acct"+"\t"+"Amount"+"\t"+"Payments UniqueID"+"\t"+"Date Received"+"\t"+"Error"+"\r")
					SEND PACKET:C103(sumDoc; [Payment:28]customerID:4+"\t"+String:C10([Payment:28]amount:1; <>tcFormatTt)+"\t"+String:C10([Payment:28]idNum:8)+"\t"+String:C10([Payment:28]dateDocument:10)+"\t"+"skipped, status = Hold."+"\r"+"\r")
					ADD TO SET:C119([Payment:28]; "Skipped")
				: ([Payment:28]amount:1=0)
					SEND PACKET:C103(sumDoc; "Customer Acct"+"\t"+"Amount"+"\t"+"Payments UniqueID"+"\t"+"Date Received"+"\t"+"Error"+"\r")
					SEND PACKET:C103(sumDoc; [Payment:28]customerID:4+"\t"+String:C10([Payment:28]amount:1; <>tcFormatTt)+"\t"+String:C10([Payment:28]idNum:8)+"\t"+String:C10([Payment:28]dateDocument:10)+"\t"+";  Not Linked; No Receivable; Marked Complete."+"\r"+"\r"+"\r")
					[Payment:28]jrnlComplete:16:=True:C214
					[Payment:28]dateLinked:18:=Current date:C33
					SAVE RECORD:C53([Payment:28])
					ADD TO SET:C119([Payment:28]; "Skipped")
				Else 
					$findRay:=Find in array:C230(<>aPayTypes; [Payment:28]typePayment:6)
					$fixSign:=1
					Case of 
						: ($findRay>0)
							$ptDebAcct:=-><>aPayDebitAccount{$findRay}
							$ptCrdAcct:=-><>aPayCreditAccount{$findRay}
						: ([Payment:28]typePayment:6="AR Credit")
							If ([Payment:28]amount:1>0)
								$ptDebAcct:=->[DefaultAccount:32]discountGiven:22
								$ptCrdAcct:=->[DefaultAccount:32]acctReceivables:8
							Else 
								$fixSign:=-1
								$ptCrdAcct:=->[DefaultAccount:32]discountGiven:22
								$ptDebAcct:=->[DefaultAccount:32]acctReceivables:8
							End if 
						: ([Payment:28]typePayment:6="Currency")
							If ([Payment:28]amount:1>0)
								$ptDebAcct:=->[DefaultAccount:32]currencyDsct:56
								$ptCrdAcct:=->[DefaultAccount:32]cash:4
							Else 
								$fixSign:=-1
								$ptDebAcct:=->[DefaultAccount:32]cash:4
								$ptCrdAcct:=->[DefaultAccount:32]currencyDsct:56
							End if 
						: ([Payment:28]typePayment:6="Late")
							If ([Payment:28]amount:1>0)
								$ptDebAcct:=->[DefaultAccount:32]lateChargeAcct:46
								$ptCrdAcct:=->[DefaultAccount:32]acctReceivables:8
							Else 
								$fixSign:=-1
								$ptCrdAcct:=->[DefaultAccount:32]lateChargeAcct:46
								$ptDebAcct:=->[DefaultAccount:32]acctReceivables:8
							End if 
						Else 
							$ptDebAcct:=->[DefaultAccount:32]cash:4
							$ptCrdAcct:=->[DefaultAccount:32]payCrdAcctCash:47  //generally AR account
					End case 
					If ([Payment:28]customerID:4#[Customer:2]customerID:1)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
					End if 
					$cntRay:=Size of array:C274(aGLAll)
					$balanceTtl:=0
					For ($r; 1; $cntRay)
						$balanceTtl:=$balanceTtl+LSDistAmts{$r}
					End for 
					//If (($balanceTtl#0)&([Payment]ExchangeRate#0)&([Payments
					//]ExchangeRate#1)&([Payment]Currency#""))
					//TRACE
					//If ($balanceTtl<2)
					//GL_JrnlLineAdd (aGLAll;[DefaultAcct]CurrencyDsct;LSDistAmts
					//;-$balanceTtl)
					//$forceBal:=True
					//$forceTotal:=-$balanceTtl
					//$balanceTtl:=0
					//End if 
					//End if 
					C_TEXT:C284($balError)
					C_REAL:C285($balanceTtl)
					If ($balanceTtl=0)
						$balError:="Balanced"
					Else 
						$balError:="Error"
					End if 
					C_TEXT:C284($payID)
					$payID:=String:C10([Payment:28]idNum:8)
					SEND PACKET:C103(sumDoc; [Payment:28]customerID:4+"\t"+[Customer:2]company:2+"\t"+String:C10([Payment:28]idNumInvoice:3)+"\t"+String:C10([Payment:28]dateDocument:10)+"\t"+[Payment:28]typePayment:6+"\t"+String:C10([Payment:28]amount:1; <>tcFormatTt)+"\r")
					SEND PACKET:C103(sumDoc; "\t"+"\t"+"\t"+$balError+"\t"+"G/L Acct"+"\t"+"Debit"+"\t"+"Credit"+"\r")
					SEND PACKET:C103(sumDoc; "\t"+"\t"+"\t"+$payID+"\t"+$ptDebAcct->+"\t"+String:C10([Payment:28]amount:1*$fixSign; <>tcFormatTt)+"\t"+"\r")
					SEND PACKET:C103(sumDoc; "\t"+"\t"+"\t"+$payID+"\t"+$ptCrdAcct->+"\t"+"\t"+String:C10([Payment:28]amount:1*$fixSign; <>tcFormatTt)+"\r")
					//If ($forceBal)
					//If ($forceTotal>0)
					//SEND PACKET(sumDoc;"\t"+"\t"+"\t"+$payID+"\t"+[DefaultAcct
					//]CurrencyDsct+"\t"+String($forceTotal;<>tcFormatTt)+"\t"+"\r")
					//Else 
					//SEND PACKET(sumDoc;"\t"+"\t"+"\t"+$payID+"\t"+$ptCrdAcct
					//+"\t"+"\t"+String(Abs($forceTotal);<>tcFormatTt)+"\r")
					//End if 
					//End if 
					C_TEXT:C284($division)
					$division:=GL_GetDivsnCust([Payment:28]customerID:4)
					If ($division#"")
						$Source:=$GLSource+"["+$division+"]"
					Else 
						$Source:=$GLSource
					End if 
					GL_JrnlSummary($ptDebAcct->; $Source; $GLDate; [Payment:28]amount:1*$fixSign; 0; $division)
					GL_JrnlSummary($ptCrdAcct->; $Source; $GLDate; 0; [Payment:28]amount:1*$fixSign; $division)
					
			End case 
			[Payment:28]jrnlComplete:16:=True:C214
			[Payment:28]dateLinked:18:=Current date:C33
			[Payment:28]jrnlid:25:=$jrnlCnt
			Ledger_PaySave
			// ### bj ### 20181110_2141
			SAVE RECORD:C53([Payment:28])
			SEND PACKET:C103(sumDoc; "\r")
			ADD TO SET:C119([Payment:28]; "Linked")
			NEXT RECORD:C51([Payment:28])
		End for 
		GL_Sum2Records(->[CashJournal:52]; "Journals"; $jrnlCnt; False:C215)
		//Thermo_Close 
		Progress QUIT($viProgressID)
		jSetPayTypes
		UNLOAD RECORD:C212([Default:15])
		UNLOAD RECORD:C212([DefaultAccount:32])
		UNLOAD RECORD:C212([CashJournal:52])
		ARRAY TEXT:C222(<>aPayDebitAccount; 0)
		ARRAY TEXT:C222(<>aPayCreditAccount; 0)
		GL_AcctRayInit(0)
		GL_SumRayInit(0)
		myTotalCost:=0
		ARRAY TEXT:C222(LCusList; 0)
		ARRAY TEXT:C222(LCusName; 0)
		//  arrayPartClr //July 12, 1995
		CLOSE DOCUMENT:C267(sumDoc)
		
		//spWind:=0
		//spWind:=Open external window(4;40;636;440;8;"";"_4D Calc")//to know if the modu
		// SP OPEN DOCUMENT (spWind;document)
		CREATE RECORD:C68([TallyResult:73])
		
		[TallyResult:73]name:1:=HFS_ShortName(document)
		[TallyResult:73]purpose:2:="Cash Journal"
		ConsoleLog("\r"+[TallyResult:73]purpose:2+"\t"+[TallyResult:73]name:1)
		
		[TallyResult:73]dtCreated:11:=DateTime_DTTo
		[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
		[TallyResult:73]textBlk1:5:=document
		[TallyResult:73]nameProfile1:26:="Document Type"
		[TallyResult:73]profile1:17:="txt"
		ConsoleLog([TallyResult:73]nameProfile1:26+"\t"+[TallyResult:73]profile1:17)
		
		[TallyResult:73]nameProfile2:27:="Jrnl ID"
		[TallyResult:73]profile2:18:=$GLSource
		ConsoleLog([TallyResult:73]nameProfile2:27+"\t"+[TallyResult:73]profile2:18)
		
		// ### jwm ### 20190109_1655 [TallyResult]NameReal1:="Original Count"
		[TallyResult:73]nameReal1:20:="Payment"
		[TallyResult:73]real1:13:=Records in set:C195("Original")
		ConsoleLog([TallyResult:73]nameReal1:20+"\t"+String:C10([TallyResult:73]real1:13))
		
		[TallyResult:73]nameReal2:21:="Linked"
		[TallyResult:73]real2:14:=Records in set:C195("Linked")
		ConsoleLog([TallyResult:73]nameReal2:21+"\t"+String:C10([TallyResult:73]real2:14))
		
		[TallyResult:73]nameReal3:22:="Skipped"
		[TallyResult:73]real3:15:=Records in set:C195("Skipped")
		ConsoleLog([TallyResult:73]nameReal3:22+"\t"+String:C10([TallyResult:73]real3:15))
		
		[TallyResult:73]nameReal4:23:="Journals Created"
		[TallyResult:73]real4:16:=Records in set:C195("Journals")
		ConsoleLog([TallyResult:73]nameReal4:23+"\t"+String:C10([TallyResult:73]real4:16))
		
		[TallyResult:73]textBlk2:6:=Document to text:C1236(document)
		
		SAVE RECORD:C53([TallyResult:73])
		
		
		CONFIRM:C162("Open Journal"; "Skip"; "Open Journal")
		
		If (OK=0)
			
			OPEN URL:C673(document)
		End if 
		
		C_LONGINT:C283($uniqueID)
		C_TEXT:C284($script)
		$uniqueID:=[TallyResult:73]idNum:35  // get the uniqueID
		
		USE SET:C118("Linked")
		If (Records in selection:C76([Payment:28])>0)
			ProcessTableOpen(Table:C252(->[Payment:28]); ""; "Linked")
		End if 
		REDUCE SELECTION:C351([Payment:28]; 0)
		
		USE SET:C118("Skipped")
		If (Records in selection:C76([Payment:28])>0)
			ProcessTableOpen(Table:C252(->[Payment:28]); ""; "Skipped")
		End if 
		REDUCE SELECTION:C351([Payment:28]; 0)
		
		USE SET:C118("Original")
		If (Records in selection:C76([Payment:28])>0)
			ProcessTableOpen(Table:C252(->[Payment:28]); ""; "Original")
		End if 
		REDUCE SELECTION:C351([Payment:28]; 0)
		
		USE SET:C118("Journals")
		If (Records in selection:C76([CashJournal:52])>0)
			ProcessTableOpen(Table:C252(->[CashJournal:52]); ""; "Created")
		End if 
		
		$script:="Query([TallyResult];[TallyResult]UniqueID="+String:C10($uniqueID)+")"
		REDUCE SELECTION:C351([TallyResult:73]; 0)
		
		$vtMessage:="Open TallyResults Record."+"\r\r"+"WARNING: This may take a while"
		CONFIRM:C162($vtMessage; "Skip"; "Open TallyResults")
		
		If (OK=0)
			ProcessTableOpen(Table:C252(->[TallyResult:73]); "$script"; "CJ: "+$GLSource)
		End if 
		
		CLEAR SET:C117("Linked")
		CLEAR SET:C117("Skipped")
		CLEAR SET:C117("Original")
		CLEAR SET:C117("Journals")
	End if 
	
	READ WRITE:C146([Default:15])
	READ WRITE:C146([DefaultAccount:32])
End if 