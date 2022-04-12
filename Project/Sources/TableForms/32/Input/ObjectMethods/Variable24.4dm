READ WRITE:C146([DefaultQQQ:15])
QUERY:C277([DefaultQQQ:15]; [DefaultQQQ:15]PrimeDefault:176=1)
LOAD RECORD:C52([DefaultQQQ:15])
If (Locked:C147([DefaultQQQ:15]))
	jAlertMessage(10004)
	Self:C308->:=[DefaultQQQ:15]CCDeviceType:71
Else 
	[DefaultQQQ:15]MacAuthAEATLoc:90:=""
	[DefaultQQQ:15]MacAuthAEName:91:=""
	[DefaultQQQ:15]MacAuthAEPort:92:=""
	SAVE RECORD:C53([DefaultQQQ:15])
End if 
UNLOAD RECORD:C212([DefaultQQQ:15])
READ ONLY:C145([DefaultQQQ:15])