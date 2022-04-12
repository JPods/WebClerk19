//%attributes = {"publishedWeb":true}
//Procedure: TC_AddRecRay
TC_FillArrays(-3; 1; 1)
CREATE RECORD:C68([Time:56])

[Time:56]nameID:1:=vNameID
If (vdDateBeg=!00-00-00!)
	vdDateBeg:=Current date:C33
End if 
[Time:56]dateIn:6:=vdDateBeg
[Time:56]dateOut:7:=!00-00-00!
[Time:56]complete:11:="t"
If (<>aActivities>1)
	[Time:56]activity:10:=<>aActivities{<>aActivities}
End if 
If (<>aActivities>0)
	[Time:56]cause:16:=<>aCostCause{<>aCostCause}
End if 
[Time:56]timeIn:4:=Current time:C178
[Time:56]comment:15:=vText1
[Time:56]perCentActive:18:=100
//If (<>aActiveWOs>0)
//[Time]OrderNum:=<>aActiveWOs{<>aActiveWOs}
[Time:56]orderNum:3:=srSO
//End if 
READ ONLY:C145([Employee:19])
QUERY:C277([Employee:19]; [Employee:19]nameID:1=[Time:56]nameID:1)
[Time:56]rate:9:=[Employee:19]payRate:11
UNLOAD RECORD:C212([Employee:19])
READ WRITE:C146([Employee:19])
SAVE RECORD:C53([Time:56])
aTCNameID{1}:=[Time:56]nameID:1
aTCHourWage{1}:=[Time:56]rate:9
aTCDateIn{1}:=[Time:56]dateIn:6
aTCDateOut{1}:=[Time:56]dateOut:7
aTCSignedIN{1}:=[Time:56]complete:11
aTCActivity{1}:=[Time:56]activity:10
aTCCause{1}:=[Time:56]cause:16
aTCTimeIn{1}:=[Time:56]timeIn:4*1
aTCComment{1}:=vText1
aTCPerCent{1}:=100
aTCOrdNum{1}:=[Time:56]orderNum:3
aTCTimeRecs{1}:=Record number:C243([Time:56])
UNLOAD RECORD:C212([Time:56])
ARRAY LONGINT:C221(aTCSelLns; 1)
aTCSelLns{1}:=1