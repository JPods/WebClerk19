If (<>aPayAction>1)
	Case of 
		: (<>aPayAction{<>aPayAction}="VOID@")  //before [Payment]ProcessorTransID
			pvCardAction:=<>aPayAction{<>aPayAction}
		: (<>aPayAction{<>aPayAction}="Prior@")  //before [Payment]ProcessorTransID
			pvCardAction:=<>aPayAction{<>aPayAction}
		: (<>aPayAction{<>aPayAction}="CREDIT@")
			pvCardAction:=<>aPayAction{<>aPayAction}
		: ([Payment:28]ProcessorTransID:31#"")
			ALERT:C41(<>aPayAction{<>aPayAction}+" applies only to new transactions")
			pvCardAction:=""
			<>aPayAction:=1
		: ((<>aPayAction{<>aPayAction}="AUTH_ONLY@") | (<>aPayAction{<>aPayAction}="AUTH_CAPTURE@") | (<>aPayAction{<>aPayAction}="CAPTURE_ONLY@"))
			pvCardAction:=<>aPayAction{<>aPayAction}
		Else 
			pvCardAction:=<>aPayAction{<>aPayAction}
	End case 
Else 
	pvCardAction:=""
End if 