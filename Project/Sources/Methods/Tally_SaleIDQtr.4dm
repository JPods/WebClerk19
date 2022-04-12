//%attributes = {"publishedWeb":true}
//Procedure: Tally_SaleIDQtr
C_DATE:C307($1)

READ ONLY:C145([Invoice:26])
READ WRITE:C146([TallyResult:73])
C_LONGINT:C283($dtReport; $dtCalc; $i; $k; $incRay; $cntRay; $incQtr)
C_TEXT:C284($ReportName)
C_DATE:C307($date1; $date2; $date3; $dateQtrBeg; $dateQtrEnd)
C_REAL:C285($sumCost; $sumPrice)
TRACE:C157
If (Count parameters:C259=0)
	CONFIRM:C162("Tally salesNameID by Qtr")
	C_TEXT:C284($dateStrRpt)
	$dateStrRpt:=Request:C163("Enter date in Qtr to Tally"; String:C10(Current date:C33))
	If (OK=1)
		$date3:=Date:C102($dateStrRpt)
	End if 
Else 
	$date3:=$1
	OK:=1
End if 
If (OK=1)
	$InvcDate:=Invc_PrimeDateP  //set primary invoice control date  
	$date1:=Date_ThisYear($date3; 0)
	$date2:=Date_ThisYear($date3; 1)
	$dtCalc:=DateTime_Enter
	$dtReport:=DateTime_Enter($date2; ?23:59:59?)
	$ReportName:="SaleIDQtr"+Substring:C12(String:C10(Year of:C25($date3)); 3; 4)
	$k:=Size of array:C274(<>aComNameID)
	ARRAY REAL:C219($aPrice; 0)
	ARRAY REAL:C219($aCost; 0)
	For ($i; 2; $k)
		QUERY:C277([TallyResult:73]; [TallyResult:73]salesNameID:31=<>aComNameID{$i}; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="SalesQuarterly"; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=$dtReport; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$ReportName)
		If (Records in selection:C76([TallyResult:73])=0)
			CREATE RECORD:C68([TallyResult:73])
			
			[TallyResult:73]salesNameID:31:=<>aComNameID{$i}
			[TallyResult:73]purpose:2:="SalesQuarterly"
			[TallyResult:73]dtReport:12:=$dtReport
			[TallyResult:73]name:1:=$ReportName
			[TallyResult:73]nameReal1:20:="1Q Sales"
			[TallyResult:73]nameReal2:21:="2Q Sales"
			[TallyResult:73]nameReal3:22:="3Q Sales"
			[TallyResult:73]nameReal4:23:="4Q Sales"
			[TallyResult:73]nameReal5:33:="Sum Sales"
			[TallyResult:73]nameReal6:37:="1Q CofG"
			[TallyResult:73]nameReal7:38:="2Q CofG"
			[TallyResult:73]nameReal8:39:="3Q CofG"
			[TallyResult:73]nameReal9:40:="4Q CofG"
			[TallyResult:73]nameReal10:41:="Sum Cost"
		End if 
		//  
		For ($incQtr; 1; 4)
			Case of 
				: ($incQtr=1)
					$dateQtrBeg:=Date_ThisQtr($date1; 0)
					$dateQtrEnd:=Date_ThisQtr($date1; 1)
				: ($incQtr=2)
					$dateQtrBeg:=Date_ThisQtr($date1+100; 0)
					$dateQtrEnd:=Date_ThisQtr($date1+100; 1)
				: ($incQtr=3)
					$dateQtrBeg:=Date_ThisQtr($date1+190; 0)
					$dateQtrEnd:=Date_ThisQtr($date1+190; 1)
				: ($incQtr=4)
					$dateQtrBeg:=Date_ThisQtr($date1+280; 0)
					$dateQtrEnd:=Date_ThisQtr($date1+280; 1)
			End case 
			QUERY:C277([Invoice:26]; [Invoice:26]dateDocument:35>=$dateQtrBeg; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]dateDocument:35<=$dateQtrEnd; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]salesNameID:23=<>aComNameID{$i})
			SELECTION TO ARRAY:C260([Invoice:26]amount:14; $aPrice; [Invoice:26]totalCost:37; $aCost)
			$cntRay:=Size of array:C274($aPrice)
			$sumCost:=0
			$sumPrice:=0
			For ($incRay; 1; $cntRay)
				$sumPrice:=$sumPrice+$aPrice{$incRay}
				$sumCost:=$sumCost+$aCost{$incRay}
			End for 
			Case of 
				: ($incQtr=1)
					[TallyResult:73]real1:13:=$sumPrice
					[TallyResult:73]real6:42:=$sumCost
				: ($incQtr=2)
					[TallyResult:73]real2:14:=$sumPrice
					[TallyResult:73]real7:43:=$sumCost
				: ($incQtr=3)
					[TallyResult:73]real3:15:=$sumPrice
					[TallyResult:73]real8:44:=$sumCost
				: ($incQtr=4)
					[TallyResult:73]real4:16:=$sumPrice
					[TallyResult:73]real9:45:=$sumCost
			End case 
		End for 
		//
		[TallyResult:73]real5:32:=[TallyResult:73]real1:13+[TallyResult:73]real2:14+[TallyResult:73]real3:15+[TallyResult:73]real4:16
		[TallyResult:73]real10:46:=[TallyResult:73]real6:42+[TallyResult:73]real7:43+[TallyResult:73]real8:44+[TallyResult:73]real9:45
		[TallyResult:73]longint1:7:=Round:C94($sumPrice-$sumCost; 0)
		SAVE RECORD:C53([TallyResult:73])
	End for 
End if 
READ WRITE:C146([Invoice:26])
READ WRITE:C146([Customer:2])
UNLOAD RECORD:C212([Invoice:26])
UNLOAD RECORD:C212([Customer:2])
UNLOAD RECORD:C212([TallyResult:73])
READ ONLY:C145([TallyResult:73])