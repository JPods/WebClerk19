//%attributes = {"publishedWeb":true}
//Procedure: Ivc_RayAdjust
//TRACE
C_LONGINT:C283($1)
C_LONGINT:C283($startPara)
If (Count parameters:C259>=1)
	$startPara:=$1
Else 
	$startPara:=1
End if 
$1:=$startPara
C_LONGINT:C283($2; $end)
If (Count parameters:C259>=2)
	$end:=$2
Else 
	$end:=Size of array:C274(aInvDays)
End if 



If (False:C215)
	For ($incRay; 1; $k)
		$fiaTerm:=Find in array:C230(<>aTerms; aInvTerms{$incRay})
		If ($fiaTerm>0)
			aInvDate{$incRay}:=aInvDate{$incRay}+<>aTermDueDay{$fiaTerm}
		End if 
		aInvDays{$incRay}:=0
		aInvDiscountAmounts{$incRay}:=0
	End for 
End if 


C_LONGINT:C283($index)
If ($end>0)
	For ($index; $startPara; $end)
		If (aInvTotals{$index}<0)
			aInvDiscountAmounts{$index}:=0
			aInvDays{$index}:=0
		Else 
			$w:=Find in array:C230(<>aTerms; aInvTerms{$index})
			
			aInvDiscountAmounts{$index}:=0
			If ($w>0)
				If (((aInvDate{$index}+<>aTermDueDay{$w})>=Current date:C33) & (<>aTermDctRt{$w}>0))
					aInvDiscountAmounts{$index}:=Round:C94((aUnPaid{$index}*(<>aTermDctRt{$w})*0.01); <>tcDecimalTt)  //
				End if 
			End if 
			
			If (aUnPaid{$index}=0)
				aInvDays{$index}:=aTmpInt1{$index}
			Else 
				If ($w>0)
					If (<>aTermType{$w}=1)
						aInvDays{$index}:=Current date:C33-<>aTermDate{$w}
					Else 
						aInvDays{$index}:=(Current date:C33-aInvDate{$index})-<>aTermDueDay{$w}  //Current date-
					End if 
				Else 
					aInvDays{$index}:=Current date:C33-aInvDate{$index}
				End if 
			End if 
			
		End if 
	End for 
End if 