//Method: Trigger: TimedEvents
//Noah Dykoski   August 28, 1999 / 4:39 PM

If ((Trigger event:C369=On Saving Existing Record Event:K3:2) | (Trigger event:C369=On Saving New Record Event:K3:1))
	If ([CronJob:82]runOnServer:18)
		[CronJob:82]multipleThread:16:=False:C215
		[CronJob:82]nameid:10:=""
	End if 
End if 