//%attributes = {"publishedWeb":true}
////Procedure: GL_PostInsight
////Noah Dykoski  July 23, 1998 / 1:17 PM
//C_POINTER($1; $FilePtr)  //Pointer to the file to work on [SalesJrnl], [PurchaseJrnl] or [CashJrnl]
//$FilePtr:=$1

//Path_Set(Storage.folder.jitAudits)
//C_LONGINT($FileNum; $index; $ris)
//$FileNum:=Table($FilePtr)
//C_LONGINT($OK)
//$OK:=0
//QUERY($FilePtr->; Field($FileNum; 8)->=0)
//jsetDefaultFile($FilePtr)
//myOK:=5000
//File_Select("Pending Records are in the Current Selection. Click OK to proceed.")
//$OK:=myOK
//$ris:=Records in selection($FilePtr->)
//If (($ris>0) & ($OK=1))
//ORDER BY($FilePtr->; Field($FileNum; 6)->; Field($FileNum; 2)->)
//FIRST RECORD($FilePtr->)
//C_TEXT($myDocName)
//C_TEXT($StartName)
//Case of 
//: ($FilePtr=(->[SalesJournal]))
//$StartName:="Exp_SJ"
//: ($FilePtr=(->[PurchaseJournal]))
//$StartName:="Exp_PJ"
//: ($FilePtr=(->[CashJournal]))
//$StartName:="Exp_CJ"
//End case 
//C_LONGINT($div; $DivOut)
//C_TEXT($AcctOut)
//$div:=Field($FileNum; 6)->
//$myDocName:=$StartName+"_"+Date_strYrMmDd(Current date)+"["+String($div)+"]"
//sumDoc:=EI_UniqueDoc(Storage.folder.jitAudits+$myDocName)
//$OK:=OK
//If ($OK=1)
//CREATE EMPTY SET($FilePtr->; "Errors")
//$index:=1
//C_TEXT($mystring)
//$mystring:="Imported from theCustomer."
//While ($index<=$ris)
//If ($div#Field($FileNum; 6)->)
//CLOSE DOCUMENT(sumDoc)
//$div:=Field($FileNum; 6)->
//$myDocName:=$StartName+"_"+Date_strYrMmDd(Current date)+"["+String($div)+"]"
//sumDoc:=EI_UniqueDoc(Storage.folder.jitAudits+$myDocName)
//End if 
//LOAD RECORD($FilePtr->)
//If (Locked($FilePtr->))
//BEEP
//ADD TO SET($FilePtr->; "Errors")
//End if 
//$DivOut:=GL_MapInsightDv(Field($FileNum; 6)->)
//$AcctOut:=GL_MapInsightAc(Field($FileNum; 6)->; Field($FileNum; 1)->)
//SEND PACKET(sumDoc; Field($FileNum; 2)->+"\t"+String(Field($FileNum; 3)->)+"\t"+String($DivOut)+"\t"+$AcctOut+"\t"+Field($FileNum; 2)->+"\t"+String(Field($FileNum; 4)->)+"\t"+String(Field($FileNum; 5)->)+"\t"+$mystring+"\r")
//Field($FileNum; 8)->:=2
//SAVE RECORD($FilePtr->)
//NEXT RECORD($FilePtr->)
//$index:=$index+1
//End while 
//CLOSE DOCUMENT(sumDoc)
//End if 
//If (Records in set("Errors")>0)
//USE SET("Errors")
//ALERT("These locked records must be manual marked as JrnlComplete is true.")
//ProcessTableOpen($FilePtr)
//End if 
//CLEAR SET("Errors")
//End if 