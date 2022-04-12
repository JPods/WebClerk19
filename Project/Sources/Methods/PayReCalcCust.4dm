//%attributes = {"publishedWeb":true}
//C_Longint($i)
//C_REAL($TempTotal)
//C_POINTER($ptVar)
//$TempTotal:=[Customer]BalanceDue
//For ($i;0;4)
//$ptVar:=Get pointer("vR"+String($i))
//$ptVar:=0
//End for 
//For ($i;1;Size of array(aPayInvs))
//If (aPayCust{$i}=[Customer]customerID)
//vR1:=vR1-aPayments{$i}
//End if 
//End for 
////UNLOAD RECORD([Payment])
//If (aPayInvs>0)
//GOTO RECORD([Payment];aPayRecs{aPayInvs})
//End if 
//For ($i;1;Size of array(aInvCust))
//If (aInvCust{$i}=[Customer]customerID)
//Case of 
//: ((aInvDays{$i}<1)|(aUnPaid{$i}<0))
//vR1:=vR1+aUnPaid{$i}
//: (aInvDays{$i}<31)//30 to 60
//vR2:=vR2+aUnPaid{$i}
//: (aInvDays{$i}<61)//60 to 90
//vR3:=vR3+aUnPaid{$i}
//Else //            over 90
//vR4:=vR4+aUnPaid{$i}
//End case 
//End if 
//End for 
//vR0:=vR1+vR2+vR3+vR4
//[Customer]BalanceDue:=vR0
//[Customer]BalanceCurrent:=vR1
//[Customer]BalPastPeriod1:=vR2
//[Customer]BalPastPeriod2:=vR3
//[Customer]BalPastPeriod3:=vR4
//SAVE RECORD([Customer])
////If ((aInvoices>0)&(aInvoices{aInvoices}#[Invoice]InvoiceNum))
////GOTO RECORD([Invoice];aInvRecs{aInvoices})
////End if //

C_LONGINT:C283($curPayRec; $curInvoiceRec)
$curPayRec:=Record number:C243([Payment:28])
$curInvoiceRec:=Record number:C243([Invoice:26])


//Ledger_TallyBal(False; False)
vR0:=[Customer:2]balanceDue:42
vR1:=[Customer:2]balanceCurrent:41
vR2:=[Customer:2]balPastPeriod1:43
vR3:=[Customer:2]balPastPeriod2:44
vR4:=[Customer:2]balPastPeriod3:45

If ($curPayRec>-1)
	GOTO RECORD:C242([Payment:28]; $curPayRec)
End if 
If ($curInvoiceRec>-1)
	GOTO RECORD:C242([Invoice:26]; $curInvoiceRec)
End if 
