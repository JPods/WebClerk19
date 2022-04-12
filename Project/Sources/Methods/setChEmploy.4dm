//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/01/18, 00:23:04
// ----------------------------------------------------
// Method: setChEmploy
// Description
// 
//
// Parameters
// ----------------------------------------------------


CREATE SET:C116([Employee:19]; "Current")
READ ONLY:C145([Employee:19])
CREATE SET:C116([AdSource:35]; "Current")
QUERY:C277([Employee:19]; [Employee:19]clientServerUser:56=True:C214)  // ### jwm ### 20161207_1306 changed from Active = True
ARRAY LONGINT:C221(<>aNameColorFG; 0)
ARRAY LONGINT:C221(<>aNameColorBG; 0)
SELECTION TO ARRAY:C260([Employee:19]nameid:1; <>aNameID; [Employee:19]colorForeGround:54; <>aNameColorFG; [Employee:19]colorBackground:55; <>aNameColorBG)
SORT ARRAY:C229(<>aNameID; <>aNameColorFG; <>aNameColorBG)
INSERT IN ARRAY:C227(<>aNameID; 1; 2)  // ### jwm ### 20180101_0051
<>aNameID{1}:="Name ID"
<>aNameID{2}:="All Users"  // ### jwm ### 20180101_0051
<>aNameID:=1
INSERT IN ARRAY:C227(<>aNameColorFG; 1; 1)
INSERT IN ARRAY:C227(<>aNameColorBG; 1; 1)
//
QUERY:C277([Employee:19]; [Employee:19]active:12=True:C214; *)
QUERY:C277([Employee:19];  & [Employee:19]salesGroup:8=True:C214)
SELECTION TO ARRAY:C260([Employee:19]nameid:1; <>aComNameID; [Employee:19]comRate:6; <>aEmpRate; [Employee:19]script:53; <>aEmpRateScript)
SORT ARRAY:C229(<>aComNameID; <>aEmpRate; <>aEmpRateScript)
INSERT IN ARRAY:C227(<>aComNameID; 1; 1)
INSERT IN ARRAY:C227(<>aEmpRate; 1; 1)
INSERT IN ARRAY:C227(<>aEmpRateScript; 1; 1)
<>aComNameID{1}:="CloneAllowed"
<>aEmpRate{1}:=0
<>aEmpRateScript{1}:=""
INSERT IN ARRAY:C227(<>aComNameID; 1; 1)
INSERT IN ARRAY:C227(<>aEmpRate; 1; 1)
INSERT IN ARRAY:C227(<>aEmpRateScript; 1; 1)
<>aComNameID{1}:="Sales ID"
<>aComNameID:=1
<>aEmpRate{1}:=0
<>aEmpRateScript{1}:=""

// ### jwm ### 20171120_1154 new choice arrays for SalesName and Full Name
C_LONGINT:C283($vi1)
C_TEXT:C284($vtFullName)
ARRAY TEXT:C222(<>atSalesName; 0)
ARRAY TEXT:C222(<>atSalesFullName; 0)
FIRST RECORD:C50([Employee:19])

For ($vi1; 1; Records in selection:C76([Employee:19]))
	
	Case of 
		: (([Employee:19]nameFirst:3="") & ([Employee:19]nameLast:2=""))
			$vtFullName:=""
		: (([Employee:19]nameFirst:3="") & ([Employee:19]nameLast:2#""))
			$vtFullName:=[Employee:19]nameLast:2
		: (([Employee:19]nameFirst:3#"") & ([Employee:19]nameLast:2=""))
			$vtFullName:=[Employee:19]nameFirst:3
		: (([Employee:19]nameFirst:3#"") & ([Employee:19]nameLast:2#""))
			$vtFullName:=[Employee:19]nameFirst:3+" "+[Employee:19]nameLast:2
	End case 
	
	APPEND TO ARRAY:C911(<>atSalesName; [Employee:19]nameid:1)
	APPEND TO ARRAY:C911(<>atSalesFullName; $vtFullName)
	
	NEXT RECORD:C51([Employee:19])
	
End for 

SORT ARRAY:C229(<>atSalesName; <>atSalesFullName)
INSERT IN ARRAY:C227(<>atSalesName; 1; 1)
INSERT IN ARRAY:C227(<>atSalesFullName; 1; 1)
<>atSalesName{1}:="SalesName"
<>atSalesFullName{1}:="SalesFullName"

UNLOAD RECORD:C212([Employee:19])
READ WRITE:C146([Employee:19])
USE SET:C118("Current")
CLEAR SET:C117("Current")
//
ARRAY TEXT:C222(<>aOrderSignOff; 0)
ARRAY LONGINT:C221(<>aOrderSignValue; 0)
QUERY:C277([Employee:19]; [Employee:19]signOffOrders:57>0)
SELECTION TO ARRAY:C260([Employee:19]nameid:1; <>aOrderSignOff; [Employee:19]signOffOrders:57; <>aOrderSignValue)
SORT ARRAY:C229(<>aOrderSignOff; <>aOrderSignValue)
INSERT IN ARRAY:C227(<>aOrderSignOff; 1; 1)
INSERT IN ARRAY:C227(<>aOrderSignValue; 1; 1)
<>aOrderSignOff{1}:="Approval ID"
<>aOrderSignOff:=1
UNLOAD RECORD:C212([Employee:19])

