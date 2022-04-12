//%attributes = {"publishedWeb":true}
If (Size of array:C274(aText1)>0)
	C_LONGINT:C283($1; $i)
	C_REAL:C285($theTotal; $salesCredit; $Comm; $Count)
	C_TEXT:C284($theRep)
	If (Count parameters:C259=0)
		$doByRep:=True:C214
	Else 
		$doByRep:=($1=1)
	End if 
	$endDate:=Date:C102(Request:C163("Enter the end date for this reporting period."))
	If (OK=1)
		$dtDate:=DateTime_Enter($endDate; ?23:59:59?)
		If ($doByRep)
			SORT ARRAY:C229(aText1; aText2; aText3; aText4; aText5; aText6; aText7; aText8; aText9; aText10; aText11; aText12)
		Else 
			SORT ARRAY:C229(aText2; aText1; aText3; aText4; aText5; aText6; aText7; aText8; aText9; aText10; aText11; aText12)
		End if 
		$i:=1
		$endLoop:=False:C215
		$k:=Size of array:C274(aText1)
		Repeat 
			$theRep:=aText1{$i}
			$theTotal:=0
			$salesCredit:=0
			$Comm:=0
			$Count:=0
			While (($theRep=aText1{$i}) | ($endLoop))
				$theTotal:=$theTotal+Num:C11(aText10{$i})
				$salesCredit:=$salesCredit+Num:C11(aText9{$i})
				$Comm:=$Comm+Num:C11(aText11{$i})
				$Count:=$Count+1
				If ($i<$k)
					$i:=$i+1
				Else 
					$endLoop:=True:C214
				End if 
			End while 
			QUERY:C277([TallyResult:73]; [TallyResult:73]dtReport:12=$dtDate; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="Commission Report"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$theRep)
			If (Records in selection:C76([TallyResult:73])=0)
				CREATE RECORD:C68([TallyResult:73])
				
				[TallyResult:73]dtReport:12:=$dtDate
				[TallyResult:73]purpose:2:="Commission Report"
				[TallyResult:73]name:1:=$theRep
			End if 
			[TallyResult:73]nameReal1:20:="Total"
			[TallyResult:73]nameReal2:21:="Sales Credit"
			[TallyResult:73]nameReal3:22:="Commissions"
			[TallyResult:73]nameReal4:23:="Count"
			[TallyResult:73]real1:13:=$theTotal
			[TallyResult:73]real2:14:=$salesCredit
			[TallyResult:73]real3:15:=$Comm
			[TallyResult:73]real4:16:=$Count
			[TallyResult:73]tableNum:3:=Table:C252(->[Rep:8])
			SAVE RECORD:C53([TallyResult:73])
		Until (($endLoop) | ($i>=$k))
	End if 
End if 