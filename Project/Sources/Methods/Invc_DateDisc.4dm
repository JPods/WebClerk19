//%attributes = {"publishedWeb":true}
//Procedure: Invc_DateDisc
C_DATE:C307($0)  //the discount date of the current invoice based in terms

$fia:=Find in array:C230(<>aTerms; [Invoice:26]terms:24)
If ($fia=-1)
	$0:=Invc_PrimeDate
Else 
	$0:=Invc_PrimeDate+<>aTermDctDay{$fia}
End if 