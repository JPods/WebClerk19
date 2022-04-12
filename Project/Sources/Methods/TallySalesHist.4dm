//%attributes = {"publishedWeb":true}





CONFIRM:C162("Run Tally Sales History")
If (ok=1)
	viReady:=0
	vlProcessID:=Execute on server:C373("TallySales"; 64*1024; "Tally Sales History"; *)
	vlTestID:=Abs:C99(vlProcessID)
	
	$viProgressID:=Progress New
	$vhTimeOut:=Current time:C178+?01:00:00?
	Repeat 
		DELAY PROCESS:C323(Current process:C322; 15)
		GET PROCESS VARIABLE:C371(-vlTestID; viReady; viReady; vi1; vi1; vi2; vi2)
		If (Undefined:C82(viReady))
			// Note: if the stored procedure has not initialized its own instance
			// of the variable viReady, we may be returned an undefined variable
			viReady:=-1  // server not ready
		Else 
			ProgressUpdate($viProgressID; vi1; vi2; "Tallying Sales History")
			
		End if 
	Until ((viReady>0) | (Current time:C178>$vhTimeOut))
	Progress QUIT($viProgressID)
	ALERT:C41("Tally Sales History Complete")  // ### jwm ### 20151001_1629
End if 
