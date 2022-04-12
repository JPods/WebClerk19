//%attributes = {"publishedWeb":true}
TRACE:C157
//(GP) TC_SaveRayRec
C_LONGINT:C283($1)
C_BOOLEAN:C305($doRecNum; $2)  //$2 is new/old  true/false
C_REAL:C285($3; $4)
$doRecNum:=False:C215
If ($1<0)
	$1:=TC_InsrtTimeAry
	aTCSignedIN{$1}:="*"
	$doRecNum:=True:C214
	CREATE RECORD:C68([Time:56])
	
	[Time:56]complete:11:="tc"
Else 
	GOTO RECORD:C242([Time:56]; aTCTimeRecs{$1})
End if 
If ($2)
	aTCNameID{$1}:=vNameID
	aTCLapsed{$1}:=vLapseTime*1
	aTCDateIn{$1}:=vDateIn
	aTCDateOut{$1}:=vDateOut
	aTCTimeIn{$1}:=vTimeIn*1
	aTCTimeOut{$1}:=vTimeOut*1
	aTCActivity{$1}:=vActivity
	aTCOrdNum{$1}:=vWONum
	[Time:56]nameID:1:=vNameID
	[Time:56]lapseTime:8:=vLapseTime
	[Time:56]dateIn:6:=vDateIn
	[Time:56]dateOut:7:=vDateOut
	[Time:56]timeIn:4:=vTimeIn
	[Time:56]timeOut:5:=vTimeOut
	[Time:56]activity:10:=vActivity
	[Time:56]idNumOrder:3:=vWONum
	If ([Time:56]dtSignIn:13=0)
		[Time:56]dtSignIn:13:=DateTime_Enter
	End if 
	If ([Time:56]dtSignOut:14=0)
		[Time:56]dtSignOut:14:=DateTime_Enter
	End if 
End if 
aTCHourWage{$1}:=$3
aTCExtWage{$1}:=$4
[Time:56]rate:9:=$3
[Time:56]totalDollars:12:=$4
Case of 
	: ((aTCSignedIN{$1}="") & (vLapseTime#?00:00:00?))
		aTCSignedIN{$1}:="*"
		[Time:56]complete:11:="tc"
	: ((aTCSignedIN{$1}="*") & (vLapseTime=?00:00:00?))
		aTCLapsed{$1}:=?00:00:00?*1
		aTCSignedIN{$1}:=""
		[Time:56]complete:11:="tc"
End case 
SAVE RECORD:C53([Time:56])
If ($doRecNum)
	aTCTimeRecs{$1}:=Record number:C243([Time:56])
End if 
UNLOAD RECORD:C212([Time:56])
aTCTimeRecs:=$1
doSearch:=5