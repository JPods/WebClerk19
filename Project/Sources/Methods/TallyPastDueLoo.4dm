//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-30T06:00:00Z)
// Method: TallyPastDueLoo
// Description
// Parameters
// ----------------------------------------------------
var $cntLock; $i; $k : Integer
var $vNewThermoTitle : Text
var $oRec; $oSel; $oTR : Object
$oSel:=ds:C1482.Customer.all()
$k:=$oSel.length
$oTR:=ds:C1482.TallyResult.new()
$oTR.dtReport:=DateTime_Enter
$oTR.dtCreated:=$oTR.dtReport
$oTR.dateCreated:=Current date:C33
$oTR.name:="Tally Receivables"
$oTR.obGeneral:=New object:C1471("keyTags"; ""; "keyText"; ""; "report"; "Tally Receivables"; "count"; $oSel.length; "locked"; New collection:C1472)
$oTR.save()
For each ($oRec; $oSel)
	$viProgressID:=Progress New
	Progress SET BUTTON ENABLED($viProgressID; True:C214)
	$i:=$i+1
	ProgressUpdate($viProgressID; $i; $k; "Processing Customer Receivables")
	If (Progress Stopped($viProgressID))
		vi1:=vi2  // exit the loop
	Else 
		// execute loop
		
		If (Locked:C147([Customer:2]))
			$oTR.obGeneral.locked.push($oRec.id)
		Else 
			// if doing a single record do just this
			Ledger_TallyBal($oRec)
		End if   // customer locked
	End if   // exit
End for each 
$oTR.nameLong1:="locked"
$oTR.longint1:=$oTR.obGeneral.locked.length
$oTR.save()
Progress QUIT($viProgressID)

viReady:=1
DELAY PROCESS:C323(Current process:C322; 60)  // pause