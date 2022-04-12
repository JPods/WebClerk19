//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/29/08, 19:11:38
// ----------------------------------------------------
// Method: SMTP_SentBy
// Description
// Modified 02/19/2010 James W. Medlen
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(vtEmailSenderID; vtEmailSenderOverRide)
C_TEXT:C284($1; $2; $3)
C_LONGINT:C283($cntParameters)

$doSearch:=True:C214
//###_jwm_### 20100219 test for valid Email for vtEmailSenderOverRide
If (vtEmailSenderOverRide#"")
	$vtEmailSenderOverRide:=vtEmailSenderOverRide
	QUERY:C277([Employee:19]; [Employee:19]email:16=$vtEmailSenderOverRide)
	If (Records in selection:C76([Employee:19])=1)
		vtEmailSenderOverRide:=[Employee:19]email:16
		$doSearch:=False:C215
	Else 
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=vtEmailSenderOverRide)
		If (Records in selection:C76([Employee:19])=1)
			vtEmailSenderOverRide:=[Employee:19]email:16
			$doSearch:=False:C215
		Else 
			REDUCE SELECTION:C351([Employee:19]; 0)
			$doSearch:=True:C214
		End if 
	End if 
Else 
	//###_jwm_### 20100219 test for valid Email for vtEmailSenderOverRide
	If (vtEmailSenderID#"")
		vtEmailSenderID:=vtEmailSenderID
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=vtEmailSenderID)
		If ((Records in selection:C76([Employee:19])#1) | ([Employee:19]emailServerOut:58="") | ([Employee:19]emailServerOut:58="error@") | ([Employee:19]emailPassword:61="") | ([Employee:19]emailUserName:60="") | ([Employee:19]emailPortOut:59<10))
			REDUCE SELECTION:C351([Employee:19]; 0)
			$doSearch:=True:C214
		Else 
			QUERY:C277([Employee:19]; [Employee:19]email:16=vtEmailSenderID)
			If ((Records in selection:C76([Employee:19])#1) | ([Employee:19]emailServerOut:58="") | ([Employee:19]emailServerOut:58="error@") | ([Employee:19]emailPassword:61="") | ([Employee:19]emailUserName:60="") | ([Employee:19]emailPortOut:59<10))
				REDUCE SELECTION:C351([Employee:19]; 0)
				$doSearch:=True:C214
			Else 
				$doSearch:=False:C215
			End if 
		End if 
	End if 
End if 

If ($doSearch)
	$cntParameters:=Count parameters:C259
	If ($cntParameters>0)
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=$1)  //
		If ((Records in selection:C76([Employee:19])#1) | ([Employee:19]emailServerOut:58="") | ([Employee:19]emailServerOut:58="error@") | ([Employee:19]emailPassword:61="") | ([Employee:19]emailUserName:60="") | ([Employee:19]emailPortOut:59<10))
			REDUCE SELECTION:C351([Employee:19]; 0)
			If ($cntParameters>1)
				QUERY:C277([Employee:19]; [Employee:19]nameID:1=$2)
				If ((Records in selection:C76([Employee:19])#1) | ([Employee:19]emailServerOut:58="") | ([Employee:19]emailServerOut:58="error@") | ([Employee:19]emailPassword:61="") | ([Employee:19]emailUserName:60="") | ([Employee:19]emailPortOut:59<10))
					REDUCE SELECTION:C351([Employee:19]; 0)
					If ($cntParameters>2)
						QUERY:C277([Employee:19]; [Employee:19]nameID:1=$3)
						If ((Records in selection:C76([Employee:19])#1) | ([Employee:19]emailServerOut:58="") | ([Employee:19]emailServerOut:58="error@") | ([Employee:19]emailPassword:61="") | ([Employee:19]emailUserName:60="") | ([Employee:19]emailPortOut:59<10))
							REDUCE SELECTION:C351([Employee:19]; 0)
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

If (Records in selection:C76([Employee:19])#1)
	QUERY:C277([Employee:19]; [Employee:19]nameID:1="Admin")
End if 

If ((Records in selection:C76([Employee:19])#1) | ([Employee:19]emailServerOut:58="") | ([Employee:19]emailServerOut:58="error@") | ([Employee:19]emailPassword:61="") | ([Employee:19]emailUserName:60="") | ([Employee:19]emailPortOut:59<10))
	LOAD RECORD:C52([Employee:19])
	Case of 
		: (Records in selection:C76([Employee:19])=0)
			CREATE RECORD:C68([Employee:19])
			[Employee:19]nameID:1:="Admin"
			[Employee:19]emailServerOut:58:="error"
			[Employee:19]emailPassword:61:="error"
			[Employee:19]emailUserName:60:="error"
			[Employee:19]emailPortOut:59:=0
			SAVE RECORD:C53([Employee:19])
			If (allowAlerts_boo)
				ProcessTableOpen(Table:C252(->[Employee:19])*-1)
			End if 
		: (([Employee:19]emailServerOut:58="error") | ([Employee:19]emailPassword:61="error") | ([Employee:19]emailUserName:60="error") | ([Employee:19]emailPortOut:59<10))
			//((Record number([Employee])>-1)&
			If (allowAlerts_boo)
				ProcessTableOpen(Table:C252(->[Employee:19])*-1)
			End if 
	End case 
End if 
If ((Position:C15(Char:C90(64); vtEmailSender)<2) | (Record number:C243([Employee:19])<0))
	QUERY:C277([Employee:19]; [Employee:19]nameID:1="Admin")  //
End if 
vtEmailSender:=[Employee:19]email:16
eSender_Tag:=[Employee:19]nameFirst:3+Char:C90(32)+[Employee:19]nameLast:2+Char:C90(32)+"<"+[Employee:19]email:16+">"

// Modified by: Bill James (2015-02-17T00:00:00 Better error reporting and added SSL, auto detect was not working)

If ([Employee:19]emailPortOut:59=0)
	viEmailport:=0
Else 
	viEmailport:=[Employee:19]emailPortOut:59
End if 
If ([Employee:19]emailServerOut:58="")
	vtEmailServer:="No Email Server Declared"
Else 
	vtEmailServer:=[Employee:19]emailServerOut:58
End if 

If ([Employee:19]emailUserName:60="")
	vtEmailUserName:="skip"
Else 
	vtEmailUserName:=[Employee:19]emailUserName:60
End if 
If ([Employee:19]emailPassword:61="")
	vtEmailPassword:="skip"
Else 
	vtEmailPassword:=[Employee:19]emailPassword:61
End if 
// ### bj ### 20191206_1213
C_LONGINT:C283(viEmailSSL)  // TSL
viEmailSSL:=[Employee:19]emailSSL:70

If ((vtEmailSender="") | (vtEmailSender="insertValid@") | (vtEmailServer="") | (vtEmailServer="insertValid@") | (vtEmailUserName="") | (vtEmailUserName="insertValid@") | (vtEmailPassword="") | (vtEmailPassword="insertValid"))
	ALERT:C41("Must define a valid sender email setup in Employees")
Else 
	UNLOAD RECORD:C212([Employee:19])
End if 