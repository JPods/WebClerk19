//%attributes = {"publishedWeb":true}
//Procedure: Script_Launch
READ ONLY:C145([Script:12])
QUERY:C277([Script:12]; [Script:12]title:3=<>aScripts{<>aScripts})
vScript:=[Script:12]text:4
UNLOAD RECORD:C212([Script:12])
READ WRITE:C146([Script:12])
Open window:C153(4; 40; 377; 288; 8; "Scripts"; "Wind_CloseBox")
DIALOG:C40([Customer:2]; "diaScripts")
CLOSE WINDOW:C154
vScript:=""
<>aScripts:=1
POST OUTSIDE CALL:C329(Storage:C1525.process.processList)