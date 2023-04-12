//%attributes = {"publishedWeb":true}
//Method: ScheduleWindowOpen
<>prcControl:=0
$doPrcWind:=True:C214
Process_InitLocal
ControlRecCheck
jSetMenuNums(1; 5; 6)

WindowOpenTaskOffSets(0; 1000-762+10; 654-572+60)

ptCurTable:=(->[Base:1])
FORM SET INPUT:C55([Base:1]; "Scheduler")
ProcessTableOpen(->[Base:1])
//Process_Running 

POST OUTSIDE CALL:C329(Storage:C1525.process.processList)