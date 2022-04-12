//%attributes = {"publishedWeb":true}
//Procedure: DupsCustLeads
C_LONGINT:C283($inc; $ris)
KeyModifierCurrent
Srch_FullDia(->[Customer:2])
$ris:=Records in selection:C76([Customer:2])
If (($ris>0) & (myOK=1))
	FIRST RECORD:C50([Customer:2])
	//ThermoInitExit ("Clearing Dup Cust/Leads";$ris;True)
	$viProgressID:=Progress New
	CREATE EMPTY SET:C140([Lead:48]; "Current")
	For ($inc; 1; $ris)
		//Thermo_Update ($inc)
		ProgressUpdate($viProgressID; $inc; $ris; "Clearing Dup Cust/Leads")
		REDUCE SELECTION:C351([Lead:48]; 0)
		Case of 
			: ((Length:C16([Customer:2]company:2)<3) | (Length:C16([Customer:2]zip:8)<3) | (Length:C16([Customer:2]phone:13)<3))
			: (OptKey=1)
				QUERY:C277([Lead:48]; [Lead:48]phone:4=[Customer:2]phone:13)
			Else 
				QUERY:C277([Lead:48]; [Lead:48]company:5=Substring:C12([Customer:2]company:2; 1; 8)+"@"; *)
				QUERY:C277([Lead:48];  & [Lead:48]zip:10=Substring:C12([Customer:2]zip:8; 1; 5)+"@")
		End case 
		If (Records in selection:C76([Lead:48])>0)
			ADD TO SET:C119([Lead:48]; "Current")
		End if 
		NEXT RECORD:C51([Customer:2])
	End for 
	//Thermo_Close
	Progress QUIT($viProgressID)
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	ProcessTableOpen(->[Lead:48])
End if 