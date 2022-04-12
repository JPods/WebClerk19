

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/12/19, 20:39:44
// ----------------------------------------------------
// Method: Shutdown
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(viProgress)
C_TEXT:C284($vtTimeRemaining; vtTimeRemaining)
C_TIME:C306($vhNow; $vhTimeRemaining; vhDelayShutdown; vhTimeOut)

If (vhDelayShutdown=?00:00:00?)
	vhDelayShutdown:=?00:05:00?
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		vhTimeOut:=Current time:C178+vhDelayShutdown  // five minutes from now
		vtTimeRemaining:=String:C10(vhDelayShutdown; Min sec:K7:7)
		
		SET TIMER:C645(60)
		GOTO OBJECT:C206(*; "btLogOut")  // is this needed ???
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event code:C388=On Timer:K2:25)
		
		$vhNow:=Current time:C178
		
		If ($vhNow>=vhTimeOut)
			//alert("jquit")
			jQUIT
			CANCEL:C270
			
		End if 
		
		$vhTimeRemaining:=(vhTimeOut-Current time:C178)
		$vtTimeRemaining:=String:C10($vhTimeRemaining; Min sec:K7:7)
		viProgress:=1-($vhTimeRemaining/vhDelayShutdown)*100
		vtTimeRemaining:=$vtTimeRemaining
		
End case 
