//%attributes = {"publishedWeb":true}
////Procedure: GL2_InsightPJ
////Monday, July 27, 1998 / 7:40:14 PM

//// ----------------------------------------------------
//// User name (OS): Bill James
//// Date and time: 11/11/18, 10:06:56
//// ----------------------------------------------------
//// Method: GL2_InsightPJ
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------


//READ ONLY([DefaultAccount])
//READ ONLY([Term])
//READ ONLY([Item])
//GOTO RECORD([DefaultAccount]; 0)

////CLOSE DOCUMENT(sumDoc)//used during debugging

//C_POINTER($1)
//C_LONGINT($incRay; $lockRecs)
//C_TEXT($temName; $transType)
//C_TEXT($myDocName)
//READ WRITE([InventoryStack])
//jsetDefaultFile(->[InventoryStack])
//QUERY([InventoryStack]; [InventoryStack]jrnlComplete=False)
//C_LONGINT($OK)
//myOK:=5000
//File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
//$OK:=myOK
//C_LONGINT($soa; $index)
//$soa:=Records in selection([InventoryStack])
//If (($soa>0) & ($OK=1))
//ORDER BY([InventoryStack]; [InventoryStack]docid; [InventoryStack]receiptid; [InventoryStack]dateVendorInvc)
//SELECTION TO ARRAY([InventoryStack]; $RecNum; [InventoryStack]docid; $DocID; [InventoryStack]receiptid; $ReceiptID; [InventoryStack]dateVendorInvc; $DateVenInvc)
//SELECTION TO ARRAY([InventoryStack]vendorID; $VendorID; [InventoryStack]extendedCost; $ExtendCost; [InventoryStack]itemNum; $ItemNum)
//ARRAY TEXT($aDivision; $soa)
//SORT ARRAY($aDivision; $RecNum; $DocID; $ReceiptID; $DateVenInvc; $VendorID; $ExtendCost; $ItemNum)

//C_LONGINT($docCnt)
//C_TEXT($curDivision; $DivOut)
//C_LONGINT($curReceipt; $curPO)
//C_DATE($curDate)
//C_TEXT($curVend)
//C_REAL($AMOUNT)
//C_TEXT($AcctOut)

//$myDocName:=Storage.folder.jitAudits+"Exp_PJ_"+Date_strYrMmDd(Current date)+"["+String($aDivision{1})+"]"
//sumDoc:=EI_UniqueDoc($myDocName)
//$lockRecs:=0
//$index:=1
//QUERY([Vendor]; [Vendor]vendorID=$VendorID{$index})
//QUERY([PO]; [PO]poNum=$DocID{$index})
//QUERY([Term]; [Term]termID=[PO]terms)
////
//$jrnlCnt:=[PurchaseJournal]idNum
//$TAXAmt:="0"
//$FRGHTAmt:="0"
//$MISCAmt:="0"
//GOTO RECORD([DefaultAccount]; 0)
//C_BOOLEAN($notDone)
//Repeat 
//GL_AcctRayInit(0)
//$curPO:=$DocID{$index}
//$curReceipt:=$ReceiptID{$index}
//$curDate:=$DateVenInvc{$index}
//$curVend:=$VendorID{$index}
//$curDivision:=$aDivision{$index}
//$MEMO:=String($ReceiptID{$index})
//$DATE:=String($DateVenInvc{$index}; 1)

//$DOCNUM:=String($DocID{$index})
//QUERY([PO]; [PO]poNum=$DocID{$index})
//If (Records in selection([PO])=1)
//$INVOICE:=Substring([PO]vendorInvoice; 1; 15)
//Else 
//$INVOICE:=Substring(String($ReceiptID{$index}); 1; 15)
//End if 
//If ([Term]termID#[PO]terms)
//QUERY([Term]; [Term]termID=[PO]terms)
//End if 
//$DUEDATE:=String($DateVenInvc{$index}+[Term]dueDays)
//$AMOUNT:=0  //initialize  
//$DiscAmt:=0
//$DistribAmt:=0
//$notDone:=True
//While ($notDone)
//If ($index<=$soa)
//If (($curPO=$DocID{$index}) & ($curDate=$DateVenInvc{$index}) & ($curDivision=$aDivision{$index}))
////
//GOTO RECORD([InventoryStack]; $RecNum{$index})
//LOAD RECORD([InventoryStack])
//If (Locked([InventoryStack]))
//$lockRecs:=$lockRecs+1
//Else 
//$DistribAmt:=Round($ExtendCost{$index}; <>tcDecimalTt)
//If ($ExtendCost{$index}#0)  //
//If ($ItemNum{$index}#[Item]itemNum)
//QUERY([Item]; [Item]itemNum=$ItemNum{$index})
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
//$index:=$index+1
//Else 
//$notDone:=False
//End if 
//Else 
//$notDone:=False
//End if 
//End while 
//If ($AMOUNT#0)
//$DivOut:=GL_MapInsightDv($curDivision)
//SEND PACKET(sumDoc; $curVend+"\t"+""+"\t"+String($DivOut)+"\t"+$DATE+"\t"+$INVOICE+"\t"+$DOCNUM+"\t"+$DUEDATE+"\t"+String($AMOUNT)+"\t"+String($DiscAmt)+"\t"+$TAXAmt+"\t"+$FRGHTAmt+"\t"+$FRGHTAmt+"\t"+$MISCAmt)
//$cntGL:=Size of array(aGLAll)
//If ($cntGL>0)
//SEND PACKET(sumDoc; String($cntGL))
//C_LONGINT($incGL; $cntGL)
//For ($incGL; 1; $cntGL)
//$AcctOut:=GL_MapInsightAc($curDivision; aGLAll{$incGL})
//SEND PACKET(sumDoc; "\t"+$AcctOut+"\t"+String(LSDistAmts{$incGL}))
//End for 
//End if 
//SEND PACKET(sumDoc; "\r")
//End if 
//If ($index<=$soa)
//If ($curDivision#$aDivision{$index})
//CLOSE DOCUMENT(sumDoc)
//spWind:=0
//// spWind:=Open external window(4;40;636;440;8;"";"_4D Calc")//to know if the mod
////SP OPEN DOCUMENT (spWind;$myDocName)
//CREATE RECORD([TallyResult])

//[TallyResult]name:=HFS_ShortName($myDocName)
//[TallyResult]purpose:="Purchase Journal"
//[TallyResult]dtCreated:=DateTime_Enter
//[TallyResult]dtReport:=[TallyResult]dtCreated
//[TallyResult]textBlk1:=$myDocName
//[TallyResult]nameProfile1:="Document Type"
//[TallyResult]profile1:="4SP"




////SP AREA TO FIELD (spWind;Table(->[TallyResult]);Field(->[TallyResult]PictBlk1)
//sumDoc:=Open document(document)
//<>vEoF:=Get document size(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
//RECEIVE PACKET(sumDoc; $theText; <>vEoF)
//[TallyResult]textBlk2:=$theText
//CLOSE DOCUMENT(sumDoc)
//SAVE RECORD([TallyResult])
//$myDocName:=Storage.folder.jitAudits+"Exp_PJ_"+Date_strYrMmDd(Current date)+"["+String($aDivision{$index})+"]"
//sumDoc:=EI_UniqueDoc($myDocName)
//End if 
//End if 
//Until ($index>$soa)
//CLOSE DOCUMENT(sumDoc)


//CREATE RECORD([TallyResult])

//[TallyResult]name:=HFS_ShortName($myDocName)
//[TallyResult]purpose:="Purchase Journal"
//[TallyResult]dtCreated:=DateTime_Enter
//[TallyResult]dtReport:=[TallyResult]dtCreated
//[TallyResult]textBlk1:=$myDocName
//[TallyResult]nameProfile1:="Document Type"



////SP AREA TO FIELD (spWind;Table(->[TallyResult]);Field(->[TallyResult]PictBlk1)
//sumDoc:=Open document(document)
//<>vEoF:=Get document size(document)+1  // ### jwm ### 20160714_1147 is plus 1 needed ?
//RECEIVE PACKET(sumDoc; $theText; <>vEoF)
//[TallyResult]textBlk2:=$theText
//CLOSE DOCUMENT(sumDoc)
//SAVE RECORD([TallyResult])
//ProcessTableOpen(Table(->[TallyResult]); ""; "PJ: "+$GLSource)
//REDUCE SELECTION([TallyResult]; 0)
//booSendDoc:=False


//If ($lockRecs>0)
//ALERT("There were "+String($lockRecs)+" locked records.")
//End if 
//GL_AcctRayInit(0)
//// End if 
//End if 
//UNLOAD RECORD([Item])
//UNLOAD RECORD([DefaultAccount])
//UNLOAD RECORD([Term])
//READ WRITE([Item])
//READ WRITE([DefaultAccount])
//READ WRITE([Term])