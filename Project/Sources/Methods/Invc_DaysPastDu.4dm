//%attributes = {"publishedWeb":true}
//Procedure: Terms_DaysOld
C_LONGINT:C283($0)  //the numbers of days the current invoice is past due

C_LONGINT:C283($fiaTerms)
$fiaTerms:=Find in array:C230(<>aTerms; [Invoice:26]terms:24)
If ($fiaTerms>0)
	$0:=Current date:C33-Invc_PrimeDate-<>aTermDueDay{$fiaTerms}
Else 
	$0:=Current date:C33-Invc_PrimeDate
End if 