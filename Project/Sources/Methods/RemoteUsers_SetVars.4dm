//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/08/21, 14:34:14
// ----------------------------------------------------
// Method: RemoteUsers_SetVars
// Description
// 
//
// Parameters
// ----------------------------------------------------

vWccremoteUserID:=""
vWccPrimeRec:=-1
vWccTableNum:=0
vWccSecurity:=0
vWccRemoteUserRec:=-1
justMine:=""


If ((Records in selection:C76([Employee:19])>0) | (Records in selection:C76([Rep:8])>0))
	vWccremoteUserID:=[EventLog:75]wccRemoteUserid:30
	vWccPrimeRec:=[EventLog:75]wccPrimeUserRec:23
	vWccTableNum:=[EventLog:75]tableNumWccPrime:24
	vWccSecurity:=[EventLog:75]wccRemoteSecurity:25
	vWccRemoteUserRec:=[EventLog:75]wccRemoteUserRec:26
	viSecureLvl:=vWccSecurity
End if 


If (False:C215)  // set these values on signin
	Case of 
		: (Record number:C243([Employee:19])>-1)
			
			
		: (Record number:C243([Rep:8])>-1)
			[EventLog:75]wccRemoteUserid:30:=[Rep:8]repID:1
			[EventLog:75]wccPrimeUserRec:23:=Record number:C243([Rep:8])
			[EventLog:75]tableNumWccPrime:24:=Table:C252(->[Rep:8])
			[EventLog:75]wccRemoteSecurity:25:=[RemoteUser:57]securityLevel:4
			[EventLog:75]wccRemoteUserRec:26:=Record number:C243([RemoteUser:57])
		: ((Record number:C243([Customer:2])>-1) & ([Customer:2]mfrLocationid:67<-2000000))
			
			// Modified by: William James (2014-02-16T00:00:00 Subrecord eliminated)
			
			QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1; *)
			QUERY:C277([ManufacturerTerm:111];  & [ManufacturerTerm:111]active:3=True:C214)
			If (Records in selection:C76([ManufacturerTerm:111])=1)
				[EventLog:75]wccRemoteUserid:30:=[ManufacturerTerm:111]customerID:1
				[EventLog:75]wccPrimeUserRec:23:=Record number:C243([ManufacturerTerm:111])
				[EventLog:75]tableNumWccPrime:24:=Table:C252(->[ManufacturerTerm:111])
				[EventLog:75]wccRemoteSecurity:25:=[RemoteUser:57]securityLevel:4
				[EventLog:75]wccRemoteUserRec:26:=Record number:C243([RemoteUser:57])
			End if 
	End case 
	
	SAVE RECORD:C53([EventLog:75])
	
	If ((<>vCommunitySite>0) & (Record number:C243([Customer:2])>-1))
		// ### bj ### 20181228_0632 
		[EventLog:75]wccRemoteUserid:30:=[Customer:2]customerID:1
		[EventLog:75]wccPrimeUserRec:23:=Record number:C243([Customer:2])
		[EventLog:75]tableNumWccPrime:24:=Table:C252(->[Customer:2])
		[EventLog:75]wccRemoteSecurity:25:=[RemoteUser:57]securityLevel:4
		[EventLog:75]wccRemoteUserRec:26:=Record number:C243([RemoteUser:57])
		If ([EventLog:75]idNum:5#0)
			SAVE RECORD:C53([EventLog:75])
		End if 
	End if 
End if 