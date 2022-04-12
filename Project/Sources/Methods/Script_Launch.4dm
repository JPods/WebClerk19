//%attributes = {"publishedWeb":true}
//Procedure: Script_Launch
READ ONLY:C145([QQQScript:12])
QUERY:C277([QQQScript:12]; [QQQScript:12]Title:3=<>aScripts{<>aScripts})
vScript:=[QQQScript:12]Text:4
UNLOAD RECORD:C212([QQQScript:12])
READ WRITE:C146([QQQScript:12])
Open window:C153(4; 40; 377; 288; 8; "Scripts"; "Wind_CloseBox")
DIALOG:C40([QQQCustomer:2]; "diaScripts")
CLOSE WINDOW:C154
vScript:=""
<>aScripts:=1
POST OUTSIDE CALL:C329(<>theProcessList)