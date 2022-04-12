//%attributes = {"publishedWeb":true}
MESSAGES OFF:C175
ORDER BY:C49([Time:56]; [Time:56]nameid:1; [Time:56]dateIn:6; [Time:56]timeIn:4)
FIRST RECORD:C50([Time:56])
BREAK LEVEL:C302(1; 1)
ACCUMULATE:C303([Time:56]lapseTime:8)
vTimeTotal:=0
READ ONLY:C145([Employee:19])
FORM SET OUTPUT:C54([Time:56]; "RptTimeSignOff")
PRINT SELECTION:C60([Time:56])  //prints the report
READ WRITE:C146([Employee:19])
FORM SET OUTPUT:C54(ptCurTable->; "o"+Table name:C256(ptCurTable)+"_"+ScreenSize)
MESSAGES ON:C181