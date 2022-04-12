//If (Size of array(aSrvLines)>0)
//If (aServiceTableName{aSrvLines{1}}="C")
//<>CustAcct:=[Customer]AccountCode
//<>ptCurFile:=([Customer])
//
//Else 
//<>CustAcct:=String([ShowLead]UniqueID)
//<>ptCurFile:=([ShowLead])
//End if 
//C_LONGINT($found)
//$found:=Prs_CheckRunnin ("Q &A")
//If ($found>0)
//If (Frontmost process#<>aPrsNum{$found})
//BRING TO FRONT(<>aPrsNum{$found})
//US POSTKEY (Ascii("U");256)
//End if 
//Else 
//<>prcControl:=1
//C_Text(<>CustAcct)
//<>processAlt:=New process("QA_Open";<>tcPrsMemory;"Q &A")
//End if 
//End if 
POST KEY:C465(Character code:C91("U"); 256)