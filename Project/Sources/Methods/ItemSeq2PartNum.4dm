//%attributes = {"publishedWeb":true}
//Procedure: ItemSeq2PartNum
//October 25, 1995
C_LONGINT:C283($i; $k)
CONFIRM:C162("Are you SURE you wish to Change LOCATION ID's to Item Number Sequence.")
If (OK=1)
	//  ON EVENT CALL("jotcCmdQAction")
	ALL RECORDS:C47([Item:4])
	ORDER BY:C49([Item:4]; [Item:4]itemNum:1)
	FIRST RECORD:C50([Item:4])
	$k:=Records in selection:C76([Item:4])
	//ThermoInitExit ("Processing Item Records";$k;True)
	$viProgressID:=Progress New
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Processing Item Records")
		If (<>ThermoAbort)
			$i:=$k
		End if 
		[Item:4]location:9:=$i
		SAVE RECORD:C53([Item:4])
		NEXT RECORD:C51([Item:4])
	End for 
	UNLOAD RECORD:C212([Item:4])
	//Thermo_Close 
	Progress QUIT($viProgressID)
	//  ON EVENT CALL("")
End if 