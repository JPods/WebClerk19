//[ItmSrl]oLo,Sh Inv.Script: b22
//October 25, 1995
C_LONGINT:C283($i; $k)
CONFIRM:C162("This may take some time.")
If (OK=1)
	CREATE EMPTY SET:C140([Invoice:26]; "CurRecs")
	ORDER BY:C49([ItemSerial:47]; [ItemSerial:47]invoiceNum:10)
	$i:=0
	FIRST RECORD:C50([ItemSerial:47])
	$k:=Records in selection:C76([ItemSerial:47])
	$viProgressID:=Progress New
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Processing ItemSerials:")
		If (<>ThermoAbort)
			$i:=$k
		End if 
		If ([ItemSerial:47]invoiceNum:10#[Invoice:26]invoiceNum:2)
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[ItemSerial:47]invoiceNum:10)
			If (Records in selection:C76([Invoice:26])>0)
				ADD TO SET:C119([Invoice:26]; "CurRecs")
			End if 
		End if 
		NEXT RECORD:C51([ItemSerial:47])
	End for 
	//Thermo_Close 
	Progress QUIT($viProgressID)
	USE SET:C118("CurRecs")
	CLEAR SET:C117("CurRecs")
	ProcessTableOpen(->[Invoice:26])
End if 