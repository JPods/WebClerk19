//%attributes = {"publishedWeb":true}
//Procedure: GL2_ConnectedPJ
//Monday, July 27, 1998 / 7:40:14 PM

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/11/18, 10:26:46
// ----------------------------------------------------
// Method: GL2_ConnectedPJ
// Description
// 
//
// Parameters
// ----------------------------------------------------



READ ONLY:C145([DefaultAccount:32])
READ ONLY:C145([Term:37])
READ ONLY:C145([Item:4])
GOTO RECORD:C242([DefaultAccount:32]; 0)

//CLOSE DOCUMENT(sumDoc)//used during debugging

C_POINTER:C301($1)
C_LONGINT:C283($incRay; $lockRecs)
C_TEXT:C284($temName; $transType)
C_TEXT:C284($myDocName)
READ WRITE:C146([InventoryStack:29])
jsetDefaultFile(->[InventoryStack:29])
QUERY:C277([InventoryStack:29]; [InventoryStack:29]jrnlComplete:13=False:C215)
C_LONGINT:C283($OK)
myOK:=5000
File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
$OK:=myOK
C_LONGINT:C283($soa; $index)
$soa:=Records in selection:C76([InventoryStack:29])
If (($soa>0) & ($OK=1))
	ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]docid:5; [InventoryStack:29]idReceipt:16; [InventoryStack:29]dateVendorInvc:27)
	SELECTION TO ARRAY:C260([InventoryStack:29]; $RecNum; [InventoryStack:29]docid:5; $DocID; [InventoryStack:29]idReceipt:16; $ReceiptID; [InventoryStack:29]dateVendorInvc:27; $DateVenInvc)
	SELECTION TO ARRAY:C260([InventoryStack:29]vendorID:10; $VendorID; [InventoryStack:29]extendedCost:17; $ExtendCost; [InventoryStack:29]itemNum:2; $ItemNum)
	ARRAY TEXT:C222($aDivision; $soa)
	ARRAY LONGINT:C221($Sort; $soa)
	For ($index; 1; $soa)
		$aDivision{$index}:=GL_GetDivsnPO($DocID{$index})
		//preserve orginal sort as a sub sort after division
		//$Sort{$index}:=(100000000*$aDivision{$index})+$index
		
	End for 
	SORT ARRAY:C229($aDivision; $RecNum; $DocID; $ReceiptID; $DateVenInvc; $VendorID; $ExtendCost; $ItemNum)
	
	C_LONGINT:C283($docCnt)
	C_TEXT:C284($curDivision; $DivOut)
	C_LONGINT:C283($curReceipt; $curPO)
	C_DATE:C307($curDate)
	C_TEXT:C284($curVend)
	C_REAL:C285($AMOUNT)
	C_TEXT:C284($AcctOut)
	C_TEXT:C284($TERMS)
	C_TEXT:C284($HOLD)
	C_TEXT:C284($VENDDOCID)
	C_TEXT:C284($docNameOnly)
	
	$docNameOnly:="Exp_PJ_"+Date_strYrMmDd(Current date:C33)+"["+String:C10($aDivision{1})+"].txt"
	$myDocName:=Storage:C1525.folder.jitAudits+$docNameOnly
	sumDoc:=EI_UniqueDoc($myDocName)
	$lockRecs:=0
	$index:=1
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=$VendorID{$index})
	QUERY:C277([PO:39]; [PO:39]idNum:5=$DocID{$index})
	QUERY:C277([Term:37]; [Term:37]termID:1=[PO:39]terms:17)
	//
	$jrnlCnt:=[PurchaseJournal:51]idNum:11
	$TAXAmt:="0"
	$FRGHTAmt:="0"
	$MISCAmt:="0"
	GOTO RECORD:C242([DefaultAccount:32]; 0)
	C_BOOLEAN:C305($notDone)
	
	ARRAY TEXT:C222($aUsedVendInvcs; 0)
	ARRAY LONGINT:C221($aUsedVendInvcsCount; 0)
	TRACE:C157
	Repeat 
		GL_AcctRayInit(0)
		$curPO:=$DocID{$index}
		$curReceipt:=$ReceiptID{$index}
		$curDate:=$DateVenInvc{$index}
		$curVend:=$VendorID{$index}
		$curDivision:=$aDivision{$index}
		$MEMO:=String:C10($ReceiptID{$index})
		$DATE:=String:C10($DateVenInvc{$index}; 1)
		
		$DOCNUM:=Substring:C12(String:C10($DocID{$index}); 1; 9)
		QUERY:C277([PO:39]; [PO:39]idNum:5=$DocID{$index})
		If (Records in selection:C76([PO:39])=1)
			$INVOICE:=Substring:C12([PO:39]vendorInvoice:29; 1; 9)
			$TERMS:=Substring:C12([PO:39]terms:17; 1; 5)
			If ([PO:39]holdPayment:68)
				$HOLD:="1"
			Else 
				$HOLD:="0"
			End if 
			$VENDDOCID:=[PO:39]vendorDocid:56
		Else 
			$INVOICE:=Substring:C12(String:C10($ReceiptID{$index}); 1; 9)
			$TERMS:="???"
			$HOLD:="0"
			$VENDDOCID:=""
		End if 
		//assure the uniqueness of the vendor invoice number    
		$VendIncvStr:=$curVend+"%%"+$INVOICE
		$fia:=Find in array:C230($aUsedVendInvcs; $VendIncvStr)
		If ($fia>0)
			$aUsedVendInvcsCount{$fia}:=$aUsedVendInvcsCount{$fia}+1
			$INVOICE:=Substring:C12($INVOICE+"~"+String:C10($aUsedVendInvcsCount{$fia}); 1; 9)
		Else 
			INSERT IN ARRAY:C227($aUsedVendInvcs; 1)
			$aUsedVendInvcs{1}:=$VendIncvStr
			INSERT IN ARRAY:C227($aUsedVendInvcsCount; 1)
			$aUsedVendInvcsCount{1}:=1
		End if 
		If ([Term:37]termID:1#[PO:39]terms:17)
			QUERY:C277([Term:37]; [Term:37]termID:1=[PO:39]terms:17)
		End if 
		$DUEDATE:=String:C10($DateVenInvc{$index}+[Term:37]dueDays:3)
		$AMOUNT:=0  //initialize  
		$DiscAmt:=0
		$DistribAmt:=0
		$notDone:=True:C214
		While ($notDone)
			If ($index<=$soa)
				If (($curPO=$DocID{$index}) & ($curDate=$DateVenInvc{$index}) & ($curDivision=$aDivision{$index}))
					//
					GOTO RECORD:C242([InventoryStack:29]; $RecNum{$index})
					LOAD RECORD:C52([InventoryStack:29])
					If (Locked:C147([InventoryStack:29]))
						$lockRecs:=$lockRecs+1
					Else 
						$DistribAmt:=Round:C94($ExtendCost{$index}; <>tcDecimalTt)
						If ($ExtendCost{$index}#0)  //
							If ($ItemNum{$index}#[Item:4]itemNum:1)
								QUERY:C277([Item:4]; [Item:4]itemNum:1=$ItemNum{$index})
							End if 
							If (Records in selection:C76([Item:4])=1)
								ptInv:=->[Item:4]inventoryGlAccount:23
							Else 
								ptInv:=->[DefaultAccount:32]itemInventory:26
							End if 
							GL_JrnlLineAdd(->aGLAll; ->[DefaultAccount:32]purchaseAcct:27; ->LSDistAmts; -$DistribAmt)  //credit
							GL_JrnlLineAdd(->aGLAll; ptInv; ->LSDistAmts; $DistribAmt)  //debit
						End if 
						//
						$AMOUNT:=$AMOUNT+$DistribAmt
						[InventoryStack:29]jrnlComplete:13:=True:C214
						[InventoryStack:29]jrnlCompleted:18:=Current date:C33
						[InventoryStack:29]jrnlid:25:=$jrnlCnt
						SAVE RECORD:C53([InventoryStack:29])
					End if 
					$index:=$index+1
				Else 
					$notDone:=False:C215
				End if 
			Else 
				$notDone:=False:C215
			End if 
		End while 
		If ($AMOUNT#0)
			$cntGL:=Size of array:C274(aGLAll)
			If ($cntGL>0)
				C_LONGINT:C283($incGL; $cntGL)
				For ($incGL; 1; $cntGL)
					If (LSDistAmts{$incGL}#0)
						SEND PACKET:C103(sumDoc; $curVend+"\t"+$TERMS+"\t"+$INVOICE+"\t"+$DATE+"\t"+$DOCNUM+"\t"+""+"\t"+String:C10($AMOUNT))
						$AcctOut:=GL_MapInsightAc($curDivision; aGLAll{$incGL})
						If (LSDistAmts{$incGL}>0)
							SEND PACKET:C103(sumDoc; "\t"+$AcctOut+"\t"+String:C10(LSDistAmts{$incGL})+"\t")
						Else 
							SEND PACKET:C103(sumDoc; "\t"+$AcctOut+"\t"+"\t"+String:C10(-LSDistAmts{$incGL}))
						End if 
						SEND PACKET:C103(sumDoc; "\t"+$HOLD+"\t"+HFS_ShortName($myDocName))
						If ([PO:39]vendorDocid:56#"")
							SEND PACKET:C103(sumDoc; "-Memo:"+$VENDDOCID+"\r")
						Else 
							SEND PACKET:C103(sumDoc; "\r")
						End if 
					End if 
				End for 
			End if 
		End if 
		If ($index<=$soa)
			If ($curDivision#$aDivision{$index})
				CLOSE DOCUMENT:C267(sumDoc)
				
				CREATE RECORD:C68([TallyResult:73])
				
				[TallyResult:73]name:1:=HFS_ShortName($myDocName)
				[TallyResult:73]purpose:2:="Purchase Journal"
				[TallyResult:73]dtCreated:11:=DateTime_DTTo
				[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
				[TallyResult:73]textBlk1:5:=$myDocName
				[TallyResult:73]nameProfile1:26:="Document Type"
				[TallyResult:73]profile1:17:="Exp_PJ_"+Date_strYrMmDd(Current date:C33)+"["+String:C10($aDivision{$index})+"]"
				
				
				[TallyResult:73]textBlk2:6:=Document to text:C1236(document)
				SAVE RECORD:C53([TallyResult:73])
				
				
				$myDocName:=Storage:C1525.folder.jitAudits+[TallyResult:73]profile1:17+".txt"
				sumDoc:=EI_UniqueDoc($myDocName)
				
				ProcessTableOpen(Table:C252(->[TallyResult:73]); ""; [TallyResult:73]profile1:17)
				REDUCE SELECTION:C351([TallyResult:73]; 0)
				
			End if 
		End if 
	Until ($index>$soa)
	CLOSE DOCUMENT:C267(sumDoc)
	//Deactivated 050203
	tkSpreadSheet:=1
	spWind:=0
	
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]name:1:=HFS_ShortName($myDocName)
	[TallyResult:73]purpose:2:="Purchase Journal"
	[TallyResult:73]dtCreated:11:=DateTime_DTTo
	[TallyResult:73]dtReport:12:=[TallyResult:73]dtCreated:11
	[TallyResult:73]textBlk1:5:=$myDocName
	[TallyResult:73]nameProfile1:26:="Document Type"
	
	[TallyResult:73]textBlk2:6:=Document to text:C1236(document)
	SAVE RECORD:C53([TallyResult:73])
	
	ProcessTableOpen(Table:C252(->[TallyResult:73]); ""; "BillMaterials")
	REDUCE SELECTION:C351([TallyResult:73]; 0)
	
	OPEN URL:C673(document)
	
	If ($lockRecs>0)
		ALERT:C41("There were "+String:C10($lockRecs)+" locked records.")
	End if 
	GL_AcctRayInit(0)
	// End if 
End if 
UNLOAD RECORD:C212([Item:4])
UNLOAD RECORD:C212([DefaultAccount:32])
UNLOAD RECORD:C212([Term:37])
READ WRITE:C146([Item:4])
READ WRITE:C146([DefaultAccount:32])
READ WRITE:C146([Term:37])