//%attributes = {"publishedWeb":true}
////Procedure: GL2_InsightIsAp
//ALERT("Vendors must be listed in Insight for the import to work.")
//READ ONLY([DefaultAccount])
//READ ONLY([Term])
//GOTO RECORD([DefaultAccount]; 0)
//C_TEXT($mystring)

////CLOSE DOCUMENT(sumDoc)

//C_POINTER($1)
//C_LONGINT($i; $k; $incRay; $lockRecs)
//C_TEXT($temName; $transType)
//C_TEXT($myDocName)
//QUERY([InventoryStack]; [InventoryStack]jrnlComplete=False)
//READ WRITE([InventoryStack])
//READ ONLY([Item])
//jsetDefaultFile(->[InventoryStack])
//myOK:=5000
//File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
//$k:=Records in selection([InventoryStack])
//If (($k>0) & (myOK=1))
//$temName:="Exp Inships AP"+Date_strYrMmDd(Current date)
//$myDocName:=TC_PutFileNameWC("Name Transfer Document"; $temName)
//If (OK=1)
//$lockRecs:=0
//ORDER BY([InventoryStack]; [InventoryStack]docid; [InventoryStack]receiptid; [InventoryStack]dateVendorInvc)
//FIRST RECORD([InventoryStack])
//$i:=0
//$mystring:="Trans theCustomer"
//C_LONGINT($docCnt)
//C_LONGINT($curReceipt; $curPO)
//C_DATE($curDate)
//C_TEXT($curVend)
//C_REAL($AMOUNT)
//QUERY([Vendor]; [Vendor]vendorID=[InventoryStack]vendorID)
//QUERY([PO]; [PO]poNum=[InventoryStack]docid)
//QUERY([Term]; [Term]termID=[PO]terms)
////
//$jrnlCnt:=[PurchaseJournal]idNum
//sumDoc:=Create document($myDocName)
//$i:=0
//$TAXAmt:="0"
//$FRGHTAmt:="0"
//$FRGHTAmt:="0"
//$MISCAmt:="0"
//GOTO RECORD([DefaultAccount]; 0)
//Repeat 
//GL_AcctRayInit(0)
//$curPO:=[InventoryStack]docid
//C_TEXT($division)
//$division:=GL_GetDivsnPO([InventoryStack]docid)
//$curReceipt:=[InventoryStack]receiptid
//$curDate:=[InventoryStack]dateVendorInvc
//$curVend:=[InventoryStack]vendorID
//$MEMO:=String([InventoryStack]receiptid)
//$DATE:=String([InventoryStack]dateVendorInvc)

//$DOCNUM:=String([InventoryStack]docid)
//QUERY([PO]; [PO]poNum=[InventoryStack]docid)
//If (Records in selection([PO])=1)
//$INVOICE:=[PO]vendorInvoice
//Else 
//$INVOICE:=String([InventoryStack]receiptid)
//End if 
//If ([Term]termID#[PO]terms)
//QUERY([Term]; [Term]termID=[PO]terms)
//End if 
//$DUEDATE:=String([InventoryStack]dateVendorInvc+[Term]dueDays)
//$AMOUNT:=0  //initialize  
//$DiscAmt:=0
//$DistribAmt:=0
//While (($curPO=[InventoryStack]docid) & ($curDate=[InventoryStack]dateVendorInvc) & ($i<=$k))
//$i:=$i+1
//LOAD RECORD([InventoryStack])
//If (Locked([InventoryStack]))
//$lockRecs:=$lockRecs+1
//Else 
////
//$DistribAmt:=Round([InventoryStack]extendedCost; <>tcDecimalTt)
//If ([InventoryStack]extendedCost#0)  //
//If ([InventoryStack]itemNum#[Item]itemNum)
//QUERY([Item]; [Item]itemNum=[InventoryStack]itemNum)
//End if 
//If (Records in selection([Item])=1)
//ptInv:=->[Item]inventoryGlAccount
//Else 
//ptInv:=->[DefaultAccount]itemInventory
//End if 
//GL_JrnlLineAdd(->aGLAll; ->[DefaultAccount]purchaseAcct; ->LSDistAmts; -$DistribAmt)  //credit
//GL_JrnlLineAdd(->aGLAll; ptInv; ->LSDistAmts; $DistribAmt)  //debit
//End if 
////
//$AMOUNT:=$AMOUNT+$DistribAmt
//[InventoryStack]jrnlComplete:=True
//[InventoryStack]jrnlCompleted:=Current date
//[InventoryStack]jrnlid:=$jrnlCnt
//SAVE RECORD([InventoryStack])
//End if 
//NEXT RECORD([InventoryStack])
//End while 
//If ($AMOUNT#0)
//SEND PACKET(sumDoc; $curVend+"\t"+""+"\t"+String($division)+"\t"+$DATE+"\t"+$INVOICE+"\t"+$DOCNUM+"\t"+$DUEDATE+"\t"+String($AMOUNT)+"\t"+String($DiscAmt)+"\t"+$TAXAmt+"\t"+$FRGHTAmt+"\t"+$FRGHTAmt+"\t"+$MISCAmt)
//$cntGL:=Size of array(aGLAll)
//If ($cntGL>0)
//SEND PACKET(sumDoc; String($cntGL))
//C_LONGINT($incGL; $cntGL)
//For ($incGL; 1; $cntGL)
//SEND PACKET(sumDoc; "\t"+aGLAll{$incGL}+"\t"+String(LSDistAmts{$incGL}))
//End for 
//End if 
//SEND PACKET(sumDoc; "\r")
//End if 
//Until ($i>$k)
//CLOSE DOCUMENT(sumDoc)
//If ($lockRecs>0)
//ALERT("There were "+String($lockRecs)+" locked records.")
//End if 
//GL_AcctRayInit(0)
//End if 
//End if 
//UNLOAD RECORD([Item])
//UNLOAD RECORD([DefaultAccount])
//UNLOAD RECORD([Term])
//READ WRITE([Item])
//READ WRITE([DefaultAccount])
//READ WRITE([Term])