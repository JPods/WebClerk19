//%attributes = {"publishedWeb":true}
If (False:C215)
	//PKPalletWeightReCalc 
	Version_0501
End if 

C_LONGINT:C283($packID; $1)
$packID:=$1
If ([LoadTag:88]idUnique:1#$packID)
	QUERY:C277([LoadTag:88]; [LoadTag:88]idUnique:1=$packID)
End if 
If (Records in selection:C76([LoadTag:88])=1)
	[LoadTag:88]WeightExtended:2:=[LoadTag:88]WeightPalletContainer:35
	$recNumPallet:=Record number:C243([LoadTag:88])
	SAVE RECORD:C53([LoadTag:88])
	QUERY:C277([LoadTag:88]; [LoadTag:88]idUniqueSuperior:27=$packID)
	$k:=Records in selection:C76([LoadTag:88])
	If ($k>0)
		SELECTION TO ARRAY:C260([LoadTag:88]WeightExtended:2; aTmpReal2)
		UNLOAD RECORD:C212([LoadTag:88])
		GOTO RECORD:C242([LoadTag:88]; $recNumPallet)
		[LoadTag:88]WeightExtended:2:=[LoadTag:88]WeightPalletContainer:35
		For ($i; 1; $k)
			[LoadTag:88]WeightExtended:2:=[LoadTag:88]WeightExtended:2+aTmpReal2{$i}
		End for 
	Else 
	End if 
	SAVE RECORD:C53([LoadTag:88])
	ARRAY REAL:C219(aTmpReal2; 0)
Else 
	BEEP:C151
	BEEP:C151
End if 