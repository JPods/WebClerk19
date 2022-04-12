//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-30T00:00:00, 20:09:51
// ----------------------------------------------------
// Method: DaysPastDue
// Description
// Modified: 07/30/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20171130_1827 changed Alert to Confirm added Alert when complete

CONFIRM:C162("Run Tally Receivables")
If (ok=1)
	viReady:=0
	allowAlerts_boo:=True:C214  // ### jwm ### 20180629_1023 show progress bar
	vlProcessID:=Execute on server:C373("TallyPastDueLoo"; 64*1024; "Tally Receivables"; False:C215; *)
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
			ProgressUpdate($viProgressID; vi1; vi2; "Processing Customer Receivables")
		End if 
	Until ((viReady>0) | (Current time:C178>$vhTimeOut))
	Progress QUIT($viProgressID)
	ALERT:C41("Tally Receivables Complete")
End if 
