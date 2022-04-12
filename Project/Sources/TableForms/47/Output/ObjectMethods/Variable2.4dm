//(S) [itemSerial].oItemSerials_9.b21, show PO's
//October 25, 1995
C_LONGINT:C283($i; $k)
CONFIRM:C162("This may take some time.")
If (OK=1)
	CREATE EMPTY SET:C140([PO:39]; "CurRecs")
	ORDER BY:C49([ItemSerial:47]; [ItemSerial:47]poNum:6)
	$i:=0
	FIRST RECORD:C50([ItemSerial:47])
	$k:=Records in selection:C76([ItemSerial:47])
	//ThermoInitExit ("Updating Records";$k;True)
	$viProgressID:=Progress New
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Updating Records")
		If (<>ThermoAbort)
			$i:=$k
		End if 
		If ([ItemSerial:47]poNum:6#[PO:39]poNum:5)
			QUERY:C277([PO:39]; [PO:39]poNum:5=[ItemSerial:47]poNum:6)
			If (Records in selection:C76([PO:39])>0)
				ADD TO SET:C119([PO:39]; "CurRecs")
			End if 
		End if 
		NEXT RECORD:C51([ItemSerial:47])
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	USE SET:C118("CurRecs")
	CLEAR SET:C117("CurRecs")
	ProcessTableOpen(->[PO:39])
End if 