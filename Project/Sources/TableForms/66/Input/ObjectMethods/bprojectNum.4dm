C_LONGINT:C283(bprojectNum)
C_TEXT:C284($vScript)
$vScript:="QUERY([Project];[Project]projectNum="+String:C10([WorkOrder:66]projectNum:80)+")"
ProcessTableOpen(Table:C252(->[Project:24]); $vScript; "Parent of WO: "+String:C10([WorkOrder:66]woNum:29))

