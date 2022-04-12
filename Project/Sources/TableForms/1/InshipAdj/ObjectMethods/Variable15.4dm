doSearch:=11
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aStkSelect)
C_REAL:C285($total; $evenSplitDuty; $evenSplitNP; $evenSplitVAT)
C_REAL:C285($checkSumDuty; $checkSumNP; $checkSumVAT)
ARRAY REAL:C219(aTmpReal1; $k)
TRACE:C157
If ($k>0)
	$checkSumDuty:=vR1
	$checkSumNP:=vR2
	$checkSumVAT:=vR3
	$evenSplitDuty:=Round:C94(vR1/$k; <>tcDecimalTt)
	$evenSplitNP:=Round:C94(vR2/$k; <>tcDecimalTt)
	$evenSplitVAT:=Round:C94(vR3/$k; <>tcDecimalTt)
	For ($i; 1; $k)
		If (b44=1)
			aStkWayBill{aStkSelect{$i}}:=v1
		End if 
		If (b41=1)
			aStkDuty{aStkSelect{$i}}:=$evenSplitDuty
			$checkSumDuty:=$checkSumDuty-aStkDuty{aStkSelect{$i}}
		End if 
		If (b42=1)
			aStkNonPd{aStkSelect{$i}}:=$evenSplitNP
			$checkSumNP:=$checkSumNP-aStkNonPd{aStkSelect{$i}}
		End if 
		If (b43=1)
			aStkVAT{aStkSelect{$i}}:=$evenSplitVAT
			$checkSumVAT:=$checkSumVAT-aStkVAT{aStkSelect{$i}}
		End if 
	End for 
	If ($checkSumDuty#0)
		aStkDuty{aStkSelect{1}}:=aStkDuty{aStkSelect{1}}+$checkSumDuty
	End if 
	If ($checkSumNP#0)
		aStkNonPd{aStkSelect{1}}:=aStkNonPd{aStkSelect{1}}+$checkSumNP
	End if 
	If ($checkSumVAT#0)
		aStkVAT{aStkSelect{1}}:=aStkVAT{aStkSelect{1}}+$checkSumVAT
	End if 
End if 





//doSearch:=11
//C_LONGINT($i;$k)
//$k:=Size of array(aStkSelect)
//C_REAL($total)
//ARRAY REAL(aStkExtWt;$k)
//C_BOOLEAN($allZero)
//C_POINTER($ptRay)
//$allZero:=True
//$total:=0
//If ($k>0)
//If (vR1#0)
//For ($i;1;$k)
//$total:=$total+Abs(aStkExtWt{$i})
//End for 
//End if 
//$doFill:=False
//Case of 
//: (b41=1)
//$ptTarget:=(->aStkDuty)
//$doFill:=True
//: (b42=1)
//$ptTarget:=(->aStkNonPd)
//$doFill:=True
//End case 
//If ($doFill=True)
//$checkSum:=$total
//$evenSplit:=Round(vR1/$k;<>tcDecimalTt)
//For ($i;1;$k)
//$ptTarget->{aStkSelect{$i}}:=$evenSplit
//aStkWayBill{aStkSelect{$i}}:=v1
//End for 
//If ($checkSum#0)
//$ptTarget->{aStkSelect{1}}:=$ptTarget->{aStkSelect{1}}+$checkSum
//End if 
//End if 
//End if 