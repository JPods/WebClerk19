//%attributes = {"publishedWeb":true}
//Procedure: Invc_CalcDaysPd
C_LONGINT:C283($0)  //the Days Paid for this Invoice

C_LONGINT:C283($fiaTerms)
$fiaTerms:=Find in array:C230(<>aTerms; [Invoice:26]terms:24)
If ($fiaTerms>0)
	$0:=([Invoice:26]datePaid:26-Invc_PrimeDate)-<>aTermDueDay{$fiaTerms}
Else 
	$0:=[Invoice:26]datePaid:26-Invc_PrimeDate
End if 
