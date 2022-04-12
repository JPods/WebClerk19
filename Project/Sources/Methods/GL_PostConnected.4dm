//%attributes = {"publishedWeb":true}

////Procedure: GL_PostConnected
////Noah Dykoski  July 23, 1998 / 1:17 PM

//// ----------------------------------------------------
//// User name (OS): Jim Medlen
//// Date and time: 06/09/15, 11:56:36
//// ----------------------------------------------------
//// Method: GL_PostConnected
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------
//// ### jwm ### 20150430_1614 added ".txt" file extension

//C_POINTER($1; $tablePtr)  //Pointer to the file to work on [SalesJrnl], [PurchaseJrnl] or [CashJrnl]
//$tablePtr:=$1

//Path_Set(Storage.folder.jitAudits)
//C_LONGINT($tableNum; $index; $ris)
//C_POINTER($ptComment; $ptCredit; $ptDateProcessed; $ptDebit; $ptDTSync; $ptDivision; $ptGLAccount; $ptUnLinked)
//$tableNum:=Table($tablePtr)
//$ptComment:=Field($tableNum; 1)
//$ptCredit:=Field($tableNum; 2)
//$ptDateProcessed:=Field($tableNum; 3)
//$ptDebit:=Field($tableNum; 4)  // [SalesJournal]Debit
//$ptDTSync:=Field($tableNum; 5)
//$ptDivision:=Field($tableNum; 6)
//$ptGLAccount:=Field($tableNum; 7)
//$ptUnLinked:=Field($tableNum; 8)
//C_LONGINT($OK)
//$OK:=0
//QUERY($tablePtr->; $ptUnLinked->=0)  // linkedAccount
//jsetDefaultFile($tablePtr)
//myOK:=5000
//File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
//$OK:=myOK
//$ris:=Records in selection($tablePtr->)
//If (($ris>0) & ($OK=1))
//ORDER BY($tablePtr->; $ptDivision->; $ptCredit->)  // Dvsn = 6 source = 2
//FIRST RECORD($tablePtr->)
//C_TEXT($myDocName)
//C_TEXT($StartName)
//Case of 
//: ($tablePtr=(->[SalesJournal]))
//$StartName:="Exp_SJ"
//: ($tablePtr=(->[PurchaseJournal]))
//$StartName:="Exp_PJ"
//: ($tablePtr=(->[CashJournal]))
//$StartName:="Exp_CJ"
//End case 
//C_LONGINT($div; $DivOut)
//C_TEXT($AcctOut)
//$div:=$ptDivision->
//$myDocName:=$StartName+"_"+Date_strYrMmDd(Current date)+"["+String($div)+"]"+".txt"  // ### jwm ### 20150430_1614
//sumDoc:=EI_UniqueDoc(Storage.folder.jitAudits+$myDocName)
//$OK:=OK
//If ($OK=1)
//CREATE EMPTY SET($tablePtr->; "Errors")
//$index:=1
//C_TEXT($mystring)
//$mystring:="Imported from theCustomer."
//While ($index<=$ris)
//If ($div#$ptDivision->)
//CLOSE DOCUMENT(sumDoc)
//$div:=$ptDivision->
//$myDocName:=$StartName+"_"+Date_strYrMmDd(Current date)+"["+String($div)+"]"+".txt"  // ### jwm ### 20150430_1614
//sumDoc:=EI_UniqueDoc(Storage.folder.jitAudits+$myDocName)
//End if 
//LOAD RECORD($tablePtr->)
//If (Locked($tablePtr->))
//BEEP
//ADD TO SET($tablePtr->; "Errors")
//End if 
//If (($ptDebit->#0) | ($ptDTSync->#0))
//$DivOut:=GL_MapInsightDv($ptDivision->)
//$AcctOut:=GL_MapInsightAc($ptDivision->; $ptComment->)
//SEND PACKET(sumDoc; $ptCredit->+"\t"+String($ptDateProcessed->)+"\t"+$AcctOut+"\t"+String($ptDebit->)+"\t"+String($ptDTSync->)+"\t"+$mystring+"\r")
//End if 
//$ptUnLinked->:=2
//SAVE RECORD($tablePtr->)
//NEXT RECORD($tablePtr->)
//$index:=$index+1
//End while 
//CLOSE DOCUMENT(sumDoc)
//End if 
//If (Records in set("Errors")>0)
//USE SET("Errors")
//ALERT("These locked records must be manual marked as JrnlComplete is true.")
//ProcessTableOpen($tablePtr)
//End if 
//CLEAR SET("Errors")
//End if 