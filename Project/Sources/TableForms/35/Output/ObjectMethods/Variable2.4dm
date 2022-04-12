C_LONGINT:C283($i; $k)
CONFIRM:C162("Tally all listed Ad Sources?")
If (OK=1)
	$k:=Records in selection:C76([QQQAdSource:35])
	//ThermoInitExit ("Tally Ad Source Changes";$k;True)
	$viProgressID:=Progress New
	
	FIRST RECORD:C50([QQQAdSource:35])
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Tally Ad Source Changes")
		
		If (<>ThermoAbort)
			$i:=$k
		End if 
		If (Not:C34(Locked:C147([QQQAdSource:35])))
			Tally_AdLeads
			Tally_AdSales
			SAVE RECORD:C53([QQQAdSource:35])
		End if 
		NEXT RECORD:C51([QQQAdSource:35])
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
End if 