//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-13T00:00:00, 07:44:14
// ----------------------------------------------------
// Method: ConvertTextInScripts
// Description
// Modified: 09/13/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($voRec; $voSel)
$voSel:=ds:C1482.TallyMaster.all()
For each ($voRec; $voSel)
	$voRec.script:=Tx_ConvertScripts($voRec.script)
	$voRec.build:=Tx_ConvertScripts($voRec.build)
	$voRec.after:=Tx_ConvertScripts($voRec.after)
	$voRec.template:=Tx_ConvertScripts($voRec.template)
	$result_o:=$voRec.save()
End for each 

$voSel:=ds:C1482.CronJob.all()
For each ($voRec; $voSel)
	$voRec.script:=Tx_ConvertScripts($voRec.script)
	$voRec.scriptAfter:=Tx_ConvertScripts($voRec.scriptAfter)
	$result_o:=$voRec.save()
End for each 



$voSel:=ds:C1482.UserReport.all()
For each ($voRec; $voSel)
	$voRec.scriptBegin:=Tx_ConvertScripts($voRec.scriptBegin)
	$voRec.scriptEnd:=Tx_ConvertScripts($voRec.scriptEnd)
	$voRec.scriptLoop:=Tx_ConvertScripts($voRec.scriptLoop)
	$result_o:=$voRec.save()
End for each 


$voSel:=ds:C1482.TaxJurisdiction.all()
For each ($voRec; $voSel)
	$voRec.scriptCost:=Tx_ConvertScripts($voRec.scriptCost)
	$voRec.scriptSales:=Tx_ConvertScripts($voRec.scriptSales)
	$result_o:=$voRec.save()
End for each 

$voSel:=ds:C1482.Employee.all()
For each ($voRec; $voSel)
	$voRec.script:=Tx_ConvertScripts($voRec.script)
	$result_o:=$voRec.save()
End for each 





