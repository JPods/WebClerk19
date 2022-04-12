//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/06/19, 11:38:50
// ----------------------------------------------------
// Method: TallySales
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($firstDate)
C_DATE:C307($1; $2; $begDate; $endDate)
// TRACE
viReady:=0
If (Count parameters:C259=2)
	$begDate:=$1
	$endDate:=$2
Else 
	$begDate:=Date_ThisMon(Current date:C33; 0)
	$endDate:=Date_ThisMon(Current date:C33; 1)
	vdDateBeg:=$begDate
	vdDateEnd:=$endDate
End if 
$firstDate:=Tally_dInvent
vdDateBeg:=$begDate
vdDateEnd:=$endDate
If ($firstDate#0)
	jDateTimeRecov($firstDate; ->vdDateBeg; ->complTime)
End if 
TallySumOrdSale(vdDateBeg)

TallySalesMonth2Date

Wcc_ReduceSelection

viReady:=1
DELAY PROCESS:C323(Current process:C322; 60)  // pause