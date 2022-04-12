//%attributes = {"publishedWeb":true}

//Procedure: GL2_QuickBooks
GL_Post2QuickBo(->[SalesJournal:50])
GL_Post2QuickBo(->[CashJournal:52])
//
READ ONLY:C145([DefaultAccount:32])
GOTO RECORD:C242([DefaultAccount:32]; 0)

C_TEXT:C284($testName)
C_TEXT:C284($mystring)
C_POINTER:C301($1)
C_LONGINT:C283($i; $k; $incRay)
C_TEXT:C284($temName; $transType)
C_TEXT:C284($myDocName)
TRACE:C157
QUERY:C277([POReceipt:95]; [POReceipt:95]jrnlComplete:8=False:C215; *)
QUERY:C277([POReceipt:95];  & [POReceipt:95]vendorInvoiceNum:4#"")
jsetDefaultFile(->[POReceipt:95])
File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
$k:=Records in selection:C76([POReceipt:95])
If (($k>0) & (myOK=1))
	
	$temName:="ExpPJ"
	$transType:="BILL"
	TRACE:C157
	$strAdder:=""
	$endFind:=0
	Repeat 
		$testName:=$temName+Date_strYrMmDd(Current date:C33)+$strAdder
		If (HFS_Exists(Storage:C1525.folder.jitAudits+$testName+".iif")=1)
			$endFind:=$endFind+1
			$strAdder:=String:C10($endFind)
		Else 
			$endFind:=0
		End if 
	Until ($endFind=0)
	$temName:=$testName+".iif"
	Path_Set(Storage:C1525.folder.jitAudits)
	$myDocName:=TC_PutFileNameWC("Name Transfer Document"; $temName)
	If ($myDocName#"")
		//If (Length(HFS_ShortName ($myDocName))>28)
		//$myDocName:=Substring($myDocName;1;28)
		// End if 
	Else 
		OK:=0
	End if 
	If (OK=1)
		$mystring:="Trans theCustomer"
		C_LONGINT:C283($docCnt)
		C_LONGINT:C283($curReceipt; $curPO)
		C_DATE:C307($curDate)
		C_TEXT:C284($curVend)
		
		C_LONGINT:C283($daysDue)
		$daysDue:=30
		$jrnlCnt:=[PurchaseJournal:51]idNum:11
		//
		C_TEXT:C284($TRNSTYPE; $NAME; $ADDR1; $ADDR2; $ADDR3; $ADDR4; $ADDR5; $MEMO; $DATE; $DUEDATE; $DOCNUM)
		C_REAL:C285($AMOUNT)
		$docCnt:=0
		sumDoc:=Create document:C266($myDocName)
		SEND PACKET:C103(sumDoc; "!TRNS"+"\t"+"TRNSTYPE"+"\t"+"ACCNT"+"\t"+"AMOUNT"+"\t"+"DATE"+"\t"+"TRNSID"+"\t"+"NAME"+"\t"+"TOPRINT"+"\t"+"ADDR1"+"\t"+"ADDR2"+"\t"+"ADDR3"+"\t"+"ADDR4"+"\t"+"ADDR5"+"\t"+"DUEDATE"+"\t"+"MEMO"+"\t"+"DOCNUM"+"\r")
		SEND PACKET:C103(sumDoc; "!SPL"+"\t"+"TRNSTYPE"+"\t"+"ACCNT"+"\t"+"AMOUNT"+"\t"+"DATE"+"\t"+"SPLID"+"\t"+"NAME"+"\t"+"TOPRINT"+"\t"+"ADDR1"+"\t"+"ADDR2"+"\t"+"ADDR3"+"\t"+"ADDR4"+"\t"+"ADDR5"+"\t"+"DUEDATE"+"\t"+"MEMO"+"\t"+"DOCNUM"+"\r")
		SEND PACKET:C103(sumDoc; "!ENDTRNS"+"\t"+"\r")
		//
		ORDER BY:C49([POReceipt:95]; [POReceipt:95]idNum:1)
		FIRST RECORD:C50([POReceipt:95])
		For ($i; 1; $k)
			LOAD RECORD:C52([POReceipt:95])
			If (Not:C34(Locked:C147([POReceipt:95])))
				[POReceipt:95]jrnlComplete:8:=True:C214
				
				If ([POReceipt:95]vendorInvoiceAmount:7#0)
					$i:=0
					
					If ([Vendor:38]vendorID:1#[POReceipt:95]vendorID:3)
						QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[POReceipt:95]vendorID:3)
					End if 
					QUERY:C277([PO:39]; [PO:39]poNum:5=[POReceipt:95]poNum:2)
					If ([Term:37]termID:1#[PO:39]terms:17)
						QUERY:C277([Term:37]; [Term:37]termID:1=[PO:39]terms:17)
						If (Records in selection:C76([Term:37])=1)
							$daysDue:=[Term:37]dueDays:3
						Else 
							$daysDue:=30
						End if 
					Else 
						$daysDue:=[Term:37]dueDays:3
					End if 
					UNLOAD RECORD:C212([Term:37])
					UNLOAD RECORD:C212([PO:39])
					//QUERY([POReceipt];[POReceipt]ReceiptID=[InvStack]ReceiptID)
					$MEMO:="POReceipt: "+String:C10([POReceipt:95]idNum:1)
					$DOCNUM:="VInv: "+[POReceipt:95]vendorInvoiceNum:4
					$curReceipt:=[POReceipt:95]idNum:1
					If ([POReceipt:95]vendorInvoiceDate:5#!00-00-00!)
						$DATE:=String:C10([POReceipt:95]vendorInvoiceDate:5)
					Else 
						$DATE:=String:C10(Current date:C33)
					End if 
					//If ([InvStack]ReceiptID=0)
					//$DOCNUM:="0"
					//Else 
					// $DOCNUM:=String([InvStack]ReceiptID)
					//End if 
					$NAME:=[Vendor:38]company:2
					If ($NAME="")
						$NAME:="Find Vendor"
					End if 
					$ADDR1:=[Vendor:38]attention:55
					pvPhone:=Format_Phone([Vendor:38]phone:10)
					$ADDR2:=pvPhone
					$ADDR3:=[Vendor:38]address1:4
					$ADDR4:=[Vendor:38]address2:5
					$ADDR5:=[Vendor:38]city:6+", "+[Vendor:38]state:7+"  "+[Vendor:38]zip:8
					
					$DUEDATE:=String:C10([POReceipt:95]vendorInvoiceDate:5+$daysDue)
					$AMOUNT:=[POReceipt:95]vendorInvoiceAmount:7  //initialize
					If ($AMOUNT<0)
						$TRNSTYPE:="BILL REFUND"
						TRACE:C157
					Else 
						$TRNSTYPE:="BILL"
					End if 
					ARRAY TEXT:C222(aGLAll; 0)
					ARRAY REAL:C219(aTmpReal1; 0)
					//$TOPRINT:="Y'
					$TransID:=String:C10([POReceipt:95]idNum:1)
					SEND PACKET:C103(sumDoc; "TRNS"+"\t"+$TRNSTYPE+"\t"+"Accounts Payable"+"\t"+String:C10(-$AMOUNT)+"\t"+$DATE+"\t"+$TransID+"\t"+$NAME+"\t"+"Y"+"\t"+$ADDR1+"\t"+$ADDR2+"\t"+$ADDR3+"\t"+$ADDR4+"\t"+$ADDR5+"\t"+$DUEDATE+"\t"+$MEMO+"\t"+$DOCNUM+"\r")
					//        
					QUERY:C277([InventoryStack:29]; [InventoryStack:29]receiptid:16=[POReceipt:95]idNum:1)
					$diffSum:=[POReceipt:95]vendorInvoiceAmount:7-Sum:C1([InventoryStack:29]extendedCost:17)
					ORDER BY:C49([InventoryStack:29]; [InventoryStack:29]receiptid:16; [InventoryStack:29]vendorID:10; [InventoryStack:29]docid:5; [InventoryStack:29]dateEntered:3)
					FIRST RECORD:C50([InventoryStack:29])
					C_LONGINT:C283($cntStacks; $incStacks)
					$cntStacks:=Records in selection:C76([InventoryStack:29])
					$sumInvStacks:=0
					For ($incStacks; 1; $cntStacks)
						$curPO:=[InventoryStack:29]docid:5
						$curDate:=[InventoryStack:29]dateEntered:3
						$curVend:=[InventoryStack:29]vendorID:10
						//          
						[InventoryStack:29]jrnlComplete:13:=True:C214
						[InventoryStack:29]jrnlCompleted:18:=Current date:C33
						[InventoryStack:29]jrnlid:25:=$jrnlCnt
						SAVE RECORD:C53([InventoryStack:29])
						
						If ($curReceipt#[InventoryStack:29]receiptid:16)
							$MEMO:="InvStackReceiptID: "+String:C10([InventoryStack:29]receiptid:16)
						End if 
						QUERY:C277([Item:4]; [Item:4]itemNum:1=[InventoryStack:29]itemNum:2)
						If (Records in selection:C76([Item:4])=1)
							$acctCode:=[Item:4]inventoryGlAccount:23
						Else 
							$acctCode:=[DefaultAccount:32]itemInventory:26
						End if 
						$w:=Find in array:C230(aGLAll; $acctCode)
						If (($w=-1) & ([InventoryStack:29]extendedCost:17#0))
							INSERT IN ARRAY:C227(aGLAll; 1; 1)
							INSERT IN ARRAY:C227(aTmpReal1; 1; 1)
							aGLAll{1}:=$acctCode
							$w:=1
						End if 
						aTmpReal1{$w}:=Round:C94(aTmpReal1{$w}+[InventoryStack:29]extendedCost:17; <>tcDecimalTt)
						$sumInvStacks:=Round:C94($sumInvStacks+[InventoryStack:29]extendedCost:17; <>tcDecimalTt)
						NEXT RECORD:C51([InventoryStack:29])
					End for 
					$diffStacks:=Round:C94([POReceipt:95]vendorInvoiceAmount:7-$sumInvStacks; 2)
					If ($diffStacks#0)
						INSERT IN ARRAY:C227(aGLAll; 1; 1)
						INSERT IN ARRAY:C227(aTmpReal1; 1; 1)
						aGLAll{1}:=[DefaultAccount:32]itemInventory:26
						aTmpReal1{1}:=$diffStacks
					End if 
					C_LONGINT:C283($sizeRay; $incRay)
					$sizeRay:=Size of array:C274(aGLAll)
					For ($incRay; 1; $sizeRay)
						$SplitID:=$transID+"_"+String:C10($incRay)
						SEND PACKET:C103(sumDoc; "SPL"+"\t"+$TRNSTYPE+"\t"+aGLAll{$incRay}+"\t"+String:C10(aTmpReal1{$incRay})+"\t"+$DATE+"\t"+$SplitID+"\t"+$NAME+"\t"+"N"+"\t"+$ADDR1+"\t"+$ADDR2+"\t"+$ADDR3+"\t"+$ADDR4+"\t"+$ADDR5+"\t"+$DATE+"\t"+$MEMO+"\t"+$DOCNUM+"\r")
					End for 
					SEND PACKET:C103(sumDoc; "ENDTRNS"+"\t"+"\r")
					[POReceipt:95]stackValues:10:=$diffStacks
				End if 
				SAVE RECORD:C53([POReceipt:95])
			End if 
			NEXT RECORD:C51([POReceipt:95])
		End for 
		CLOSE DOCUMENT:C267(sumDoc)
		App_SetSuffix("iif")
	End if 
End if 
ARRAY TEXT:C222(aGLAll; 0)
ARRAY REAL:C219(aTmpReal1; 0)