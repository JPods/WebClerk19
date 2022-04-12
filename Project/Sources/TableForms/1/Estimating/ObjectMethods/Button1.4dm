If (srItemKeywords="")
	ALERT:C41("There are no quantities to calculate")
Else 
	TextToArray(srItemKeyWords; ->aText8; ", ")
	$cntRay:=Size of array:C274(aText8)
	If ($cntRay>0)
		ARRAY LONGINT:C221(aEstimateLines; 0)
		
		ARRAY REAL:C219(iLoaReal5; $cntRay)
		ARRAY REAL:C219(iLoaReal1; $cntRay)
		ARRAY REAL:C219(iLoaReal2; $cntRay)
		ARRAY REAL:C219(iLoaReal3; $cntRay)
		For ($incRay; 1; $cntRay)
			iLoaReal5{$incRay}:=Num:C11(aText8{$incRay})
			iLoaReal1{$incRay}:=0
			iLoaReal2{$incRay}:=0
			iLoaReal3{$incRay}:=0
		End for 
		SORT ARRAY:C229(iLoaReal5; iLoaReal1; iLoaReal2; iLoaReal3)
		//  --  CHOPPED  AL_UpdateArrays(eEstimate; -2)
		
	End if 
End if 