If (False:C215)
	[CronJob:82]dtNextEvent:20:=CronDTNext([CronJob:82]cronString:28)  //calculate if there is a future event.
	jDateTimeRecov([CronJob:82]dtNextEvent:20; ->vDate2; ->vTime2)
	$tolerance:=0
	If ([CronJob:82]cronString:28="* * * * * *@")
		$tolerance:=120
	End if 
	If (([CronJob:82]active:12) & (([CronJob:82]dtNextEvent:20+$tolerance)<DateTime_Enter))
		ALERT:C41("Event is past due and will not run.")
	End if 
End if 