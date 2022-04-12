//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $3)
vi1:=[Lead:48]idNum:32
C_TEXT:C284(iLoText1)
iLoText1:=String:C10(vi1)
Case of 
	: ($1=-1)
		GOTO RECORD:C242([Lead:48]; $2)
	: ($1=1)  //pull info from previous record into this record
		PREVIOUS RECORD:C110([Lead:48])
	: ($1=0)  //pull info from next record into this record
		NEXT RECORD:C51([Lead:48])
End case 
$thePhone:=[Lead:48]phone:4
$theEmail:=[Lead:48]email:33
$firstName:=[Lead:48]nameFirst:1
$lastName:=[Lead:48]nameLast:2
$comments:=[Lead:48]comment:24
$theFAX:=[Lead:48]fax:29
[Lead:48]action:26:="delete dup"
SAVE RECORD:C53([Lead:48])
QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=Table:C252(->[Lead:48]); *)
QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=String:C10([Lead:48]idNum:32))
ConsolidateAccountID(->[CallReport:34]customerID:1; ->iLoText1)

QUERY:C277([QA:70]; [QA:70]tableNum:11=Table:C252(->[Lead:48]); *)
QUERY:C277([QA:70];  & [QA:70]customerID:1=String:C10([Lead:48]idNum:32))
ConsolidateAccountID(->[QA:70]customerID:1; ->iLoText1)

QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Lead:48]); *)
QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerID:10=String:C10([Lead:48]idNum:32))
ConsolidateAccountID(->[RemoteUser:57]customerID:10; ->iLoText1)

Case of 
	: ($1=-1)
		GOTO RECORD:C242([Lead:48]; $3)
	: ($1=1)  //pull info from previous record into this record
		PREVIOUS RECORD:C110([Lead:48])
	: ($1=0)  //pull info from next record into this record
		NEXT RECORD:C51([Lead:48])
End case 
If ([Lead:48]phone:4="")
	[Lead:48]phone:4:=$thePhone
End if 
If ([Lead:48]email:33="")
	[Lead:48]email:33:=$theEmail
End if 
[Lead:48]comment:24:=[Lead:48]comment:24+"\r"+"  "+"\r"+$comments
If (([Lead:48]nameFirst:1="") & ([Lead:48]nameLast:2=""))
	[Lead:48]nameFirst:1:=$firstName
	[Lead:48]nameLast:2:=$lastName
Else 
	[Lead:48]comment:24:=$firstName+" "+$lastName+"\r"+[Lead:48]comment:24
End if 
If ([Lead:48]fax:29="")
	[Lead:48]fax:29:=$theFAX
End if 
SAVE RECORD:C53([Lead:48])