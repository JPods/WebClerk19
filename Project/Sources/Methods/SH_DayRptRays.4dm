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
			Case of 
				: (($2="shipped") & Not:C34(([TallyResult:73]real1:13=0) & ([TallyResult:73]real2:14=0) & ([TallyResult:73]real3:15=0) & ([TallyResult:73]real4:16=0) & ([TallyResult:73]real5:32=0)))
					$doArray:=True:C214
				: (($2="ordered") & Not:C34(([TallyResult:73]real6:42=0) & ([TallyResult:73]real7:43=0) & ([TallyResult:73]real8:44=0) & ([TallyResult:73]real9:45=0) & ([TallyResult:73]real10:46=0)))
					$doArray:=True:C214
			End case 
			If ($doArray)
				$w:=Size of array:C274(aText1)+1
				SH_FillRays(-3; $w; 1)
				aText1{$w}:=[TallyResult:73]siteid:29
				aText2{$w}:=[TallyResult:73]name:1  //period
				aText3{$w}:=[TallyResult:73]purpose:2  //
				aCustAcct{$w}:=[TallyResult:73]custVendid:30
				aCustRep{$w}:=[TallyResult:73]salesid:31
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
					aScpNPlan{$w}:=[TallyResult:73]real9:45  //FOB diff
					aScpNact{$w}:=[TallyResult:73]real10:46  //Hidden Frght    
				End if 
			End if 
			NEXT RECORD:C51([TallyResult:73])
		End for 
	End if 
End if 