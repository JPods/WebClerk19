//%attributes = {"publishedWeb":true}
//EvtLog_trackIDChanges
C_POINTER:C301($1; $2)
CREATE RECORD:C68([EventLog:75])

[EventLog:75]dtEvent:1:=DateTime_DTTo
[EventLog:75]groupid:3:=-11
EventLogsMessage("Current Record number"+String:C10(Record number:C243($1->))+"\r"+Old:C35($2->)+"\r"+$2->+"\r"+Current user:C182+"\r"+String:C10(Current time:C178)+"\r"+String:C10(Current date:C33))