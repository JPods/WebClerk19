C_DATE:C307($theDate; $sDate; $eDate)
C_LONGINT:C283($theMonth; $theYear; $k; $Count)
C_BOOLEAN:C305($retallyMonths)

READ WRITE:C146([Usage:5])
READ WRITE:C146([UsageSummary:33])

$theMonth:=<>TCMTallyMonth  //index of selected month
$theYear:=<>TCMTallyYear{<>TCMTallyYear}
TRACE:C157
$sDate:=Date:C102("1"+"/1/"+String:C10($theYear))
$eDate:=Date:C102("12"+"/31/"+String:C10($theYear))


If ($theMonth=13)  //include tally for full year
	QUERY:C277([Usage:5]; [Usage:5]PeriodDate:2>=$sDate; *)
	QUERY:C277([Usage:5];  & ; [Usage:5]PeriodDate:2<=$eDate)
	$Count:=Records in selection:C76([Usage:5])
	If ($Count=0)  //make a forced retallyMonths if there are no records in Usage
		$retallyMonths:=True:C214
	Else 
		CONFIRM:C162("Click OK to retally all twelve months")
		$retallyMonths:=(OK=1)
	End if 
	If ($retallyMonths)
		//delete previous usages    
		QUERY:C277([Usage:5]; [Usage:5]PeriodDate:2>=$sDate; *)
		QUERY:C277([Usage:5];  & ; [Usage:5]PeriodDate:2<=$eDate)
		DELETE SELECTION:C66([Usage:5])
		For ($k; 1; 12)
			$theDate:=Date:C102(String:C10($k)+"/1/"+String:C10($theYear))  //start from Jan month for full year
			TallyMonthlyUsage($theDate; $retallyMonths)
		End for 
	End if 
	TallyYearlyUsageSum($sDate; $eDate)
Else   // the month is specified in input
	$theDate:=Date:C102(String:C10($theMonth)+"/1/"+String:C10($theYear))
	$retallyMonths:=False:C215
	//delete previous usages
	QUERY:C277([Usage:5]; [Usage:5]PeriodDate:2=$theDate)
	DELETE SELECTION:C66([Usage:5])
	TallyMonthlyUsage($theDate; $retallyMonths)
End if 

CANCEL:C270

