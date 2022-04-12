If (<>aScripts>1)
	READ ONLY:C145([QQQScript:12])
	QUERY:C277([QQQScript:12]; [QQQScript:12]Title:3=<>aScripts{<>aScripts})
	vScript:=[QQQScript:12]Text:4
	UNLOAD RECORD:C212([QQQScript:12])
	READ WRITE:C146([QQQScript:12])
End if 