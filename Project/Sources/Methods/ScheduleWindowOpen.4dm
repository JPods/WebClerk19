//%attributes = {"publishedWeb":true}
//Method: ScheduleWindowOpen
<>prcControl:=0
$doPrcWind:=True:C214
Process_InitLocal
ControlRecCheck
jSetMenuNums(1; 5; 6)

WindowOpenTaskOffSets(0; 1000-762+10; 654-572+60)

ptCurTable:=(->[Control:1])
FORM SET INPUT:C55([Control:1]; "Scheduler")
ProcessTableOpen(->[Control:1])
//Process_Running 

POST OUTSIDE CALL:C329(<>theProcessList)