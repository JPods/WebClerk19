// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 13:28:14
// ----------------------------------------------------
// Method: Object Method: b11
// Description
// TestThis
//
// Parameters
// ----------------------------------------------------


ORDER BY:C49([RemoteUser:57]; [RemoteUser:57]tableNum:9)
//
TRACE:C157
C_LONGINT:C283($tableNum; $k; $i; $curProc)
C_POINTER:C301($ptTable)
FIRST RECORD:C50([RemoteUser:57])
$tableNum:=[RemoteUser:57]tableNum:9
If (($tableNum>1) & ($tableNum<=Get last table number:C254))
	$ptTable:=Table:C252($tableNum)
	$k:=Records in selection:C76([RemoteUser:57])
	$curProc:=Current process:C322
	$i:=0
	Repeat 
		CREATE EMPTY SET:C140($ptTable->; "Current")
		While (($tableNum=[RemoteUser:57]tableNum:9) & ($i<$k))
			Case of 
				: ([RemoteUser:57]tableNum:9=2)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
				: ([RemoteUser:57]tableNum:9=48)
					QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11([RemoteUser:57]customerID:10))
				: ([RemoteUser:57]tableNum:9=13)
					QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([RemoteUser:57]customerID:10))
			End case 
			$i:=$i+1
			ADD TO SET:C119($ptTable->; "Current")
			NEXT RECORD:C51([RemoteUser:57])
		End while 
		UNLOAD RECORD:C212($ptTable->)
		USE SET:C118("Current")
		CLEAR SET:C117("Current")
		If (Records in selection:C76($ptTable->)>0)
			DB_ShowCurrentSelection($ptTable; ""; 1; "")  //tablePt, script, flowBranch, Title
		End if 
	Until ($i=$k)
End if 