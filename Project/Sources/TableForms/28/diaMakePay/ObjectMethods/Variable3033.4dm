If (<>aPayAction>1)
	Case of 
		: (<>aPayAction{<>aPayAction}="AUTH_CAPTURE@")
			pvCardAction:=<>aPayAction{<>aPayAction}
		: (<>aPayAction{<>aPayAction}="AUTH_ONLY@")
			pvCardAction:=<>aPayAction{<>aPayAction}
		: (<>aPayAction{<>aPayAction}="CREDIT@")
			ALERT:C41("Must be processed from within the payment being credited.")
			pvCardAction:=""
			<>aPayAction:=1
		: ((<>aPayAction{<>aPayAction}="Prior@") | (<>aPayAction{<>aPayAction}="VOID@") | (<>aPayAction{<>aPayAction}="CAPTURE_ONLY@"))
			ALERT:C41(<>aPayAction{<>aPayAction}+" applies only to existing transactions")
			pvCardAction:=""
			<>aPayAction:=1
		Else 
			pvCardAction:=<>aPayAction{<>aPayAction}
	End case 
Else 
	pvCardAction:=""
End if 