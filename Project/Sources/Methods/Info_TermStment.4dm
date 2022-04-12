//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/03/09, 11:10:04
// ----------------------------------------------------
// Method: Info_TermStment
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($w)
C_POINTER:C301($1)
$w:=Find in array:C230(<>aTerms; [Invoice:26]terms:24)
If ($w=-1)
	v1:=[Invoice:26]terms:24
	$1->:=""
Else 
	prntTerms:=<>aTermDesc{$w}
	Case of 
		: (<>aTermDctRt{$w}>0)
			C_DATE:C307($DscntDate; $DueDate)
			C_REAL:C285($DscntAmt)
			$DueDate:=Invc_DateDue
			$DscntDate:=Invc_DateDisc
			$DscntAmt:=Round:C94(([Invoice:26]amount:14*(1-(<>aTermDctRt{$w}*0.01)))+[Invoice:26]salesTax:19+[Invoice:26]shipTotal:20; <>tcDecimalTt)
			$1->:="Discount to "+String:C10($DscntAmt; <>tcFormatTt)+" if post marked by "+String:C10($DscntDate; 1)+", else post mark by "+String:C10($DueDate; 1)+"."
		: ([Invoice:26]balanceDue:44<=0)
			$1->:=""
		: ([Invoice:26]terms:24=<>tcCODTerm)
			$1->:="Collect on Delivery"
		Else 
			//test this
			Ledger_InvSave
			C_LONGINT:C283($risLed; $incRay)
			C_TEXT:C284($textTotal)
			$risLed:=Records in selection:C76([Ledger:30])
			ARRAY DATE:C224($aLdgDue; $risLed)  //[Ledger]DateDue  
			ARRAY REAL:C219($aLdgValue; $risLed)  // [Ledger]Debit
			ARRAY REAL:C219($aLdgCredit; $risLed)  //[Ledger]Credit
			SELECTION TO ARRAY:C260([Ledger:30]dateDue:5; $aLdgDue; [Ledger:30]unAppliedValue:6; $aLdgValue)
			$textTotal:=""
			For ($incRay; 1; $risLed)
				$textTotal:=$textTotal+"Date Due: "+String:C10($aLdgDue{$incRay}; 4)+" - Amount: "+String:C10($aLdgValue{$incRay}; "$###,###,##0.00")+"\r"  //###_jwm_### 20091016
			End for 
			$1->:=$textTotal
	End case 
End if 





