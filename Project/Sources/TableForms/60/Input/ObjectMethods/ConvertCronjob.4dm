

// Script TallyMaster2Cronjob 20161207

QUERY:C277([CronJob:82]; [CronJob:82]nameid:10=[TallyMaster:60]name:8; *)
QUERY:C277([CronJob:82]; [CronJob:82]eventName:15=[TallyMaster:60]status:33; *)
QUERY:C277([CronJob:82]; [CronJob:82]machineName:22=[TallyMaster:60]realName2:17; *)
QUERY:C277([CronJob:82])

If (Records in selection:C76([CronJob:82])=0)
	
	CREATE RECORD:C68([CronJob:82])
	[CronJob:82]idNum:1:=CounterNew(->[CronJob:82])
	[CronJob:82]cronString:28:=[TallyMaster:60]alphaKey:26
	[CronJob:82]nameid:10:=[TallyMaster:60]name:8
	[CronJob:82]eventName:15:=[TallyMaster:60]status:33
	[CronJob:82]machineName:22:=[TallyMaster:60]realName2:17
	If ([TallyMaster:60]realName1:16="@Active@")
		[CronJob:82]active:12:=True:C214
	Else 
		[CronJob:82]active:12:=False:C215
	End if 
	[CronJob:82]dateRevision:34:=[TallyMaster:60]dateRevision:32
	[CronJob:82]dateCreated:35:=Current date:C33
	[CronJob:82]script:11:=[TallyMaster:60]build:6
	[CronJob:82]comment:23:=[TallyMaster:60]script:9
	[CronJob:82]comment:23:=[CronJob:82]comment:23+"\r\r"+[TallyMaster:60]after:7
	[CronJob:82]dtNextEvent:20:=[TallyMaster:60]dtNextStart:10
	[CronJob:82]profile1:24:=[TallyMaster:60]profile1:23
	[CronJob:82]profile2:26:=[TallyMaster:60]profile2:24
	[CronJob:82]profile3:21:=[TallyMaster:60]profile3:35
	[CronJob:82]status:27:=[TallyMaster:60]realName3:18
	[CronJob:82]instances:36:=1
	
	
	SAVE RECORD:C53([CronJob:82])
	
End if 

//UNLOAD RECORD([TallyMaster])
If (Records in selection:C76([CronJob:82])>0)
	ProcessTableOpen(Table:C252(->[CronJob:82]); ""; "Cronjob")
End if 
