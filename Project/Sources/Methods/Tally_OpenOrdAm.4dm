//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-08T00:00:00, 08:39:58
// ----------------------------------------------------
// Method: Tally_OpenOrdAm
// Description
// Modified: 11/08/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_BOOLEAN:C305($1; $doMessage)
$doMessage:=True:C214
If (Count parameters:C259=1)
	$doMessage:=$1
End if 

QUERY:C277([Order:3]; [Order:3]dateInvoiceComp:6=!00-00-00!; *)
QUERY:C277([Order:3];  | [Order:3]dateInvoiceComp:6=!1901-01-01!)
ORDER BY:C49([Order:3]; [Order:3]customerID:1)
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Order:3])
If ($doMessage)
	//ThermoInitExit ("Tally Open Order value";$k;True)
	$viProgressID:=Progress New
End if 
$i:=0
TRACE:C157

CREATE RECORD:C68([Service:6])

[Service:6]actionBy:12:=Current user:C182
//[Service]ActionDate:=Current date
//[Service]ActionTime:=Current time
[Service:6]dtAction:35:=DateTime_DTTo
[Service:6]dtBegin:15:=[Service:6]dtAction:35
[Service:6]action:20:="Update Open Order"
////
//QUERY([Customer];[Customer]OpenOrderValue#0)
//$cntCust:=Records in selection([Customer])
//[Service]Comment:="Customer records failing to initialize, "+String
//($cntCust)
//FIRST RECORD([Customer])
//For ($i;1;$cntCust)
//[Service]Comment:=[Service]Comment+"\r"+[Customer]customerID+"\t"
//+String([Customer]OpenOrderValue)
//NEXT RECORD([Customer])
//End for 
$theCust:=""
$openOrd:=0
FIRST RECORD:C50([Order:3])
While (($i<$k) & (Record number:C243([Order:3])>-1))
	$theCust:=[Order:3]customerID:1
	$openOrd:=0
	Repeat 
		$i:=$i+1
		If ($doMessage)
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Tally Open Order value")
			If (<>ThermoAbort)
				$i:=$k
			End if 
		End if 
		$openOrd:=$openOrd+[Order:3]amountBackLog:54
		NEXT RECORD:C51([Order:3])
	Until (($i=$k) | ($theCust#[Order:3]customerID:1))
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=$theCust)
	If (Records in selection:C76([Customer:2])=0)
		[Service:6]comment:11:=[Service:6]comment:11+"\r"+$theCust+"\t"+String:C10($openOrd)+"\t"+"orphan"
	Else 
		LOAD RECORD:C52([Customer:2])
		If (Locked:C147([Customer:2]))
			[Service:6]comment:11:=[Service:6]comment:11+"\r"+$theCust+"\t"+String:C10($openOrd)+"\t"+"locked"
		Else 
			[Customer:2]balanceOpenOrders:78:=$openOrd
			SAVE RECORD:C53([Customer:2])
			UNLOAD RECORD:C212([Customer:2])
		End if 
	End if 
End while 
SAVE RECORD:C53([Service:6])
If ($doMessage)
	//Thermo_Close 
	Progress QUIT($viProgressID)
End if 
//