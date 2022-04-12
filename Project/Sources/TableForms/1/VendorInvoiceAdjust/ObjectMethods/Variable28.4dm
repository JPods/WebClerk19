doSearch:=10
C_LONGINT:C283($i; $k; b41; b42; b43)
$k:=Size of array:C274(aStkSelect)
C_REAL:C285($total; $evenSplitDuty; $evenSplitNP; $evenSplitVAT)
C_REAL:C285($checkSumDuty; $checkSumNP; $checkSumVAT)
ARRAY REAL:C219(aTmpReal1; $k)
TRACE:C157
ALERT:C41("Feature not released.")
If (False:C215)
	CONFIRM:C162("Spread difference by Cost of each selected line.")
	
	
	
	If (OK=1)
		If ($k=0)
			ALERT:C41("No lines selected.")
		Else 
			For ($i; 1; $k)
				aTmpReal1{$i}:=aStkOrCost{aStkSelect{$i}}*aStkOrQty{aStkSelect{$i}}
				$total:=$total+Abs:C99(aTmpReal1{$i})
			End for 
			
			$checkSumDuty:=vR1
			$checkSumNP:=vR2
			$checkSumVAT:=vR3
			$evenSplitDuty:=Round:C94(vR1/$k; <>tcDecimalTt)
			$evenSplitNP:=Round:C94(vR2/$k; <>tcDecimalTt)
			$evenSplitVAT:=Round:C94(vR3/$k; <>tcDecimalTt)
			For ($i; 1; $k)
				//If (b44=1)//should be in original receipts
				//aStkWayBill{aStkSelect{$i}}:=v1
				//End if 
				//If (b41=1)
				Case of 
					: (vR1=0)
						aStkDuty{aStkSelect{$i}}:=0
					: ($total=0)
						aStkDuty{aStkSelect{$i}}:=$evenSplitDuty
						$checkSumDuty:=$checkSumDuty-aStkDuty{aStkSelect{$i}}
					Else 
						aStkDuty{aStkSelect{$i}}:=Round:C94(vR1*aTmpReal1{$i}/$total; <>tcDecimalTt)
						$checkSumDuty:=$checkSumDuty-aStkDuty{aStkSelect{$i}}
				End case 
				//End if 
				//If (b42=1)
				Case of 
					: (vR1=0)
						aStkNonPd{aStkSelect{$i}}:=0
					: ($total=0)
						aStkNonPd{aStkSelect{$i}}:=$evenSplitNP
						$checkSumNP:=$checkSumNP-aStkNonPd{aStkSelect{$i}}
					Else 
						aStkNonPd{aStkSelect{$i}}:=Round:C94(vR1*aTmpReal1{$i}/$total; <>tcDecimalTt)
						$checkSumNP:=$checkSumNP-aStkNonPd{aStkSelect{$i}}
				End case 
				//End if 
				//If (b43=1)
				Case of 
					: (vR1=0)
						aStkVAT{aStkSelect{$i}}:=0
					: ($total=0)
						aStkVAT{aStkSelect{$i}}:=$evenSplitNP
						$checkSumVAT:=$checkSumVAT-aStkVAT{aStkSelect{$i}}
					Else 
						aStkVAT{aStkSelect{$i}}:=Round:C94(vR1*aTmpReal1{$i}/$total; <>tcDecimalTt)
						$checkSumVAT:=$checkSumVAT-aStkVAT{aStkSelect{$i}}
				End case 
				//End if 
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
	End if 
End if 