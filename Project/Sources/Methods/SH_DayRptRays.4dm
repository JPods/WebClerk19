//%attributes = {"publishedWeb":true}
//Procedure: SH_DayRptRays
C_TEXT:C284($1; $2)
C_LONGINT:C283($3; $4; $5; $6; $7; $8; $9; $thefile)
If (Count parameters:C259<4)
	ALERT:C41("Specify 'shipped' or 'booked', type report and sort.")
Else 
	jDateTimeUserCl  //vdStDate vdEndDate
	CONFIRM:C162("Build Pacing Report for "+String:C10(vdStDate)+"; "+String:C10(vdEndDate))
	If (OK=1)
		TRACE:C157
		QUERY:C277([TallyResult:73]; [TallyResult:73]dtReport:12>=vlDTStart; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12<=vlDTEnd; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1=$1)
		$k:=Records in selection:C76([TallyResult:73])
		$thefile:=Table:C252(->[TallyResult:73])
		Case of 
			: (Count parameters:C259=4)
				ORDER BY:C49([TallyResult:73]; Field:C253($thefile; $3)->; Field:C253($thefile; $4)->)
			: (Count parameters:C259=5)
				ORDER BY:C49([TallyResult:73]; Field:C253($thefile; $3)->; Field:C253($thefile; $4)->; Field:C253($thefile; $5)->)
			: (Count parameters:C259=6)
				ORDER BY:C49([TallyResult:73]; Field:C253($thefile; $3)->; Field:C253($thefile; $4)->; Field:C253($thefile; $5)->; Field:C253($thefile; $6)->)
		End case 
		TRACE:C157
		FIRST RECORD:C50([TallyResult:73])
		SH_FillRays(0)
		For ($i; 1; $k)
			$doArray:=False:C215
			// Fix and change types. commented out
			// Modified by: Bill James (2022-12-09T06:00:00Z)
			//Case of 
			//: (($2="shipped") & Not(([TallyResult]real1=0) & ([TallyResult]real2=0) & ([TallyResult]real3=0) & ([TallyResult]real4=0) & ([TallyResult]real5=0)))
			//$doArray:=True
			//: (($2="ordered") & Not(([TallyResult]real6=0) & ([TallyResult]real7=0) & ([TallyResult]real8=0) & ([TallyResult]dataRaw=0) & ([TallyResult]real10=0)))
			//$doArray:=True
			//End case 
			If ($doArray)
				$w:=Size of array:C274(aText1)+1
				SH_FillRays(-3; $w; 1)
				aText1{$w}:=[TallyResult:73]siteID:29
				aText2{$w}:=[TallyResult:73]name:1  //period
				aText3{$w}:=[TallyResult:73]purpose:2  //
				aCustAcct{$w}:=[TallyResult:73]customerID:30
				aCustRep{$w}:=[TallyResult:73]salesNameID:31
				aPartNum{$w}:=[TallyResult:73]itemNum:34
				aTmp20Str1{$w}:=[TallyResult:73]profile1:17
				aTmp20Str2{$w}:=[TallyResult:73]profile2:18
				aTmp20Str3{$w}:=[TallyResult:73]profile3:19
				//
				aTmpLong1{$w}:=[TallyResult:73]dtReport:12
				aTmpLong2{$w}:=Record number:C243([TallyResult:73])
				If ($2="shipped")
					aQtyNact{$w}:=[TallyResult:73]real1:13  //qty
					aSaleNact{$w}:=[TallyResult:73]real2:14  //sales
					aInvNact{$w}:=[TallyResult:73]real3:15  //Net Sales
					aScpNPlan{$w}:=[TallyResult:73]real4:16  //FOB diff
					aScpNact{$w}:=[TallyResult:73]real5:32  //Hidden Frght      
				Else 
					aQtyNact{$w}:=[TallyResult:73]real6:42  //qty
					aSaleNact{$w}:=[TallyResult:73]real7:43  //sales
					aInvNact{$w}:=[TallyResult:73]real8:44  //Net Sales
					// Modified by: Bill James (2022-12-09T06:00:00Z)
					// mush fix and adjust to data type and object
					
					//aScpNPlan{$w}:=[TallyResult]dataRaw  //FOB diff
					aScpNact{$w}:=[TallyResult:73]real10:46  //Hidden Frght    
				End if 
			End if 
			NEXT RECORD:C51([TallyResult:73])
		End for 
	End if 
End if 