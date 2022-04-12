//%attributes = {"publishedWeb":true}
<>ZonRcvRun:=False:C215
While (Process state:C330(<>ZonRcvPrcss)>=0)  //wait for completion
	If (Process state:C330(<>ZonRcvPrcss)=5)  //paused
		RESUME PROCESS:C320(<>ZonRcvPrcss)
	End if 
	IDLE:C311
End while 