//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/08/21, 14:36:03
// ----------------------------------------------------
// Method: RemoteUser_SetEventLog
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $pageOne; $pageList; $pageReturn; $thePage; $tablePage)

//
Case of 
	: ([RemoteUser:57]tableNum:9=2)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
		If (Records in selection:C76([Customer:2])=1)
			[EventLog:75]tableNum:9:=2
			[EventLog:75]idNumProposal:57:="Customer"
			[EventLog:75]customerRecNum:8:=Record number:C243([Customer:2])
			[EventLog:75]customerID:38:=[RemoteUser:57]customerID:10
			[EventLog:75]typeSale:47:=[Customer:2]typeSale:18
			vUseBase:=SetPricePoint([Customer:2]typeSale:18)
			If ([Customer:2]webPage:94="0")
				[Customer:2]webPage:94:=""
			End if 
			$insert:=[Customer:2]webPage:94
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			
			// likely redundate update consider consolidating in jAcceptButton 
			[RemoteUser:57]company:16:=[Customer:2]company:2
			[RemoteUser:57]name:20:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
			[RemoteUser:57]domain:7:=[Customer:2]domain:90
			[RemoteUser:57]email:14:=[Customer:2]email:81
			$accountID:=[RemoteUser:57]customerID:10
			
			
			[EventLog:75]company:46:=[Customer:2]company:2
			[EventLog:75]zip:21:=[Customer:2]zip:8
			
			If ([Customer:2]mfrLocationid:67<-10000)
				QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1; *)
				QUERY:C277([ManufacturerTerm:111];  & [ManufacturerTerm:111]active:3=True:C214)
				If (Records in selection:C76([ManufacturerTerm:111])=1)
					RemoteUsers_SetVars
				End if 
			End if 
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]))
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=[RemoteUser:57]contactID:11)
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
		If (Records in selection:C76([Customer:2])=1)
			[EventLog:75]typeSale:47:=[Customer:2]typeSale:18
		Else 
			[EventLog:75]typeSale:47:="no customer record"
		End if 
		If (Records in selection:C76([Contact:13])=1)
			[EventLog:75]idNumProposal:57:="Contact-Customer"
			$accountID:=[Customer:2]customerID:1
			[EventLog:75]customerRecNum:8:=Record number:C243([Contact:13])
			[EventLog:75]tableNum:9:=Table:C252(->[Contact:13])
			[EventLog:75]customerID:38:=[Contact:13]customerID:1
			vUseBase:=SetPricePoint([Customer:2]typeSale:18)
			$insert:=[Contact:13]webPage:47
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			
			// likely redundate update consider consolidating in jAcceptButton
			[RemoteUser:57]company:16:=[Contact:13]company:23
			[RemoteUser:57]name:20:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
			[RemoteUser:57]domain:7:=[Contact:13]domain:53
			[RemoteUser:57]email:14:=[Contact:13]email:35
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
			
			[EventLog:75]company:46:=[Contact:13]company:23
			[EventLog:75]zip:21:=[Contact:13]zip:11
			
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Employee:19]))
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=[RemoteUser:57]customerID:10)
		If (Records in selection:C76([Employee:19])=1)
			[EventLog:75]idNumProposal:57:=[Employee:19]role:7
			
			If (False:C215)  // do not set any thing at the customer level when signed in as employee.
				// do not wipe out anything incase the employee is taking over to help a customer
				[EventLog:75]customerRecNum:8:=0
				[EventLog:75]tableNum:9:=0
				[EventLog:75]customerID:38:=""
			End if 
			[EventLog:75]idPrimary:30:=[Employee:19]nameID:1
			[EventLog:75]wccPrimeUserRec:23:=Record number:C243([Employee:19])
			[EventLog:75]tableNumWccPrime:24:=Table:C252(->[Employee:19])
			[EventLog:75]securityLevelWCC:25:=[RemoteUser:57]securityLevel:4
			[EventLog:75]wccRemoteUserRec:26:=Record number:C243([RemoteUser:57])
			
			RemoteUsers_SetVars
			If ([Employee:19]webPage:43="0")
				[Employee:19]webPage:43:=""
			End if 
			$insert:=[Employee:19]webPage:43
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			
			// This should be done on saving Employee record
			[RemoteUser:57]company:16:=Storage:C1525.default.company
			[RemoteUser:57]name:20:=[Employee:19]nameFirst:3+" "+[Employee:19]nameLast:2
			[RemoteUser:57]domain:7:=[Employee:19]domain:30
			[RemoteUser:57]email:14:=[Employee:19]email:16
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
	: ([RemoteUser:57]tableNum:9=48)
		QUERY:C277([zzzLead:48]; [zzzLead:48]idNum:32=Num:C11([RemoteUser:57]customerID:10))
		If (Records in selection:C76([zzzLead:48])=1)
			[EventLog:75]tableNum:9:=48
			[EventLog:75]idNumProposal:57:="Lead"
			[EventLog:75]customerRecNum:8:=Record number:C243([zzzLead:48])
			[EventLog:75]customerID:38:=[RemoteUser:57]customerID:10
			[EventLog:75]typeSale:47:=[zzzLead:48]typeSale:30
			vUseBase:=SetPricePoint([zzzLead:48]typeSale:30)
			$insert:=[zzzLead:48]webPage:47
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			[RemoteUser:57]company:16:=[zzzLead:48]company:5
			[RemoteUser:57]name:20:=[zzzLead:48]nameFirst:1+" "+[zzzLead:48]nameLast:2
			[RemoteUser:57]domain:7:=[zzzLead:48]domain:46
			[RemoteUser:57]email:14:=[zzzLead:48]email:33
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
			
			[EventLog:75]company:46:=[zzzLead:48]company:5
			[EventLog:75]zip:21:=[zzzLead:48]zip:10
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Vendor:38]))
		QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[RemoteUser:57]customerID:10)
		If (Records in selection:C76([Vendor:38])=1)
			$theRecNum:=Record number:C243([Vendor:38])
			[EventLog:75]tableNum:9:=Table:C252(->[Vendor:38])
			[EventLog:75]idNumProposal:57:="Vendor"
			[EventLog:75]customerRecNum:8:=Record number:C243([Vendor:38])
			[EventLog:75]customerID:38:=[RemoteUser:57]customerID:10
			$insert:=[Vendor:38]webPage:80
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			[RemoteUser:57]company:16:=[Vendor:38]company:2
			[RemoteUser:57]name:20:=[Vendor:38]nameFirst:85+" "+[Vendor:38]nameLast:86
			[RemoteUser:57]domain:7:=[Vendor:38]domain:68
			[RemoteUser:57]email:14:=[Vendor:38]email:59
			$accountID:=[RemoteUser:57]customerID:10
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
			
			[EventLog:75]company:46:=[Vendor:38]company:2
			[EventLog:75]zip:21:=[Vendor:38]zip:8
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
	: ([RemoteUser:57]tableNum:9=Table:C252(->[ManufacturerTerm:111]))
		QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)
		QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=[Customer:2]customerID:1)
		If (Records in selection:C76([ManufacturerTerm:111])=1)
			[EventLog:75]customerRecNum:8:=Record number:C243([Customer:2])
			[EventLog:75]tableNum:9:=Table:C252(->[Customer:2])
			[EventLog:75]idNumProposal:57:="Manufacturer"
			[EventLog:75]customerID:38:=[RemoteUser:57]customerID:10
			$accountID:=[RemoteUser:57]customerID:10
			$insert:=[Customer:2]webPage:94
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
			
			[EventLog:75]company:46:=[Customer:2]company:2
			[EventLog:75]zip:21:=[Customer:2]zip:8
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]))
		QUERY:C277([Rep:8]; [Rep:8]RepID:1=[RemoteUser:57]customerID:10)
		If (Records in selection:C76([Rep:8])=1)
			[EventLog:75]idNumProposal:57:="Rep"
			[EventLog:75]customerRecNum:8:=Record number:C243([Rep:8])
			[EventLog:75]tableNum:9:=Table:C252(->[Rep:8])
			[EventLog:75]customerID:38:=[Rep:8]RepID:1
			$accountID:=[RemoteUser:57]customerID:10
			RemoteUsers_SetVars(3)
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			[RemoteUser:57]company:16:=[Rep:8]company:2
			[RemoteUser:57]name:20:=[Rep:8]nameFirst:25+" "+[Rep:8]nameLast:27
			[RemoteUser:57]domain:7:=[Rep:8]domain:30
			[RemoteUser:57]email:14:=[Rep:8]email:22
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
			
			[EventLog:75]company:46:=[Rep:8]company:2
			[EventLog:75]zip:21:=[Rep:8]zip:8
			
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
		If ([RemoteUser:57]securityLevel:4>999)
			$idGroup:=[Rep:8]repIDGroup:45
			If ([Rep:8]repIDGroup:45#"")
				QUERY:C277([Rep:8]; [Rep:8]repIDGroup:45=$idGroup)
			End if 
		End if 
	: ([RemoteUser:57]tableNum:9=Table:C252(->[RepContact:10]))
		QUERY:C277([RepContact:10]; [RepContact:10]idNum:23=Num:C11([RemoteUser:57]customerID:10))
		QUERY:C277([Rep:8]; [Rep:8]RepID:1=[RepContact:10]repID:1)
		If (Records in selection:C76([Rep:8])=1)
			RemoteUsers_SetVars
			[EventLog:75]idNumProposal:57:="Contact-Rep"
			[EventLog:75]customerID:38:=[Rep:8]RepID:1
			[EventLog:75]customerRecNum:8:=Record number:C243([RepContact:10])
			[EventLog:75]tableNum:9:=[RemoteUser:57]tableNum:9
			$tablePage:=Table name:C256([RemoteUser:57]tableNum:9)+"One"+$insert+".html"
			[RemoteUser:57]company:16:=[Rep:8]company:2
			[RemoteUser:57]name:20:=[RepContact:10]nameFirst:3+" "+[RepContact:10]nameLast:5
			//[RemoteUser]Domain:=[RepContact]Domain
			[RemoteUser:57]email:14:=[RepContact:10]email:21
			[RemoteUser:57]dtLastVisit:5:=DateTime_Enter
			$accountID:=[Rep:8]RepID:1
			
			
			[EventLog:75]company:46:=[Rep:8]company:2
			[EventLog:75]zip:21:=[Rep:8]zip:8
			
		Else 
			[RemoteUser:57]tableNum:9:=-1
		End if 
		SAVE RECORD:C53([RemoteUser:57])
	Else 
		[EventLog:75]customerRecNum:8:=-1
		[EventLog:75]tableNum:9:=-1
		//keep table and customerID to hunt for issues
		$tablePage:="error.html"
End case 
Case of 
	: ([EventLog:75]tableNum:9=-1)  // keep the error page
	: ($thePage#"")
		$thePage:=Replace string:C233($thePage; "TableName"; Table name:C256([EventLog:75]tableNum:9))
	Else 
		$thePage:=$tablePage
End case 
$0:=$thePage
vResponse:=vResponse+": "+[RemoteUser:57]userName:2+": "+String:C10([RemoteUser:57]securityLevel:4)
If ([EventLog:75]customerRecNum:8>-1)
	[EventLog:75]securityLevel:16:=[RemoteUser:57]securityLevel:4
	[EventLog:75]remoteUserRec:10:=Record number:C243([RemoteUser:57])
	[EventLog:75]shipToRecordid:35:=0
	[EventLog:75]shipToTableNum:34:=0
Else 
	[EventLog:75]securityLevel:16:=1
	[EventLog:75]remoteUserRec:10:=-1
	[EventLog:75]tableNum:9:=0
	[EventLog:75]shipToRecordid:35:=0
	[EventLog:75]shipToTableNum:34:=0
End if 
SAVE RECORD:C53([EventLog:75])
viSecureLvl:=[EventLog:75]securityLevel:16

///  QQQ???? review and update register
Case of 
	: ([EventLog:75]lastQueryScript:31="pendingSign@")
		C_TEXT:C284($getPage)
		[EventLog:75]lastQueryScript:31:=Replace string:C233([EventLog:75]lastQueryScript:31; "accountID"; $accountID)
		WC_InitRequest
		vWCPayload:="SignIn.html?"+[EventLog:75]lastQueryScript:31
		WC_ParseRequestParameter("SignIn.html?"+[EventLog:75]lastQueryScript:31)
		vResponse:="Query="+[EventLog:75]lastQueryScript:31
		C_LONGINT:C283($tableNum)
		$0:=PageParameterParse([EventLog:75]lastQueryScript:31; "jitPageOne"; "")
		If ($0="")
			$0:=PageParameterParse([EventLog:75]lastQueryScript:31; "jitPageList"; "")
		End if 
		$tableNum:=WccQuery3Fields
		[EventLog:75]lastQueryScript:31:=""
	: (Position:C15("NoticeOnly"; vText11)>0)
		$0:="NoticeOnly"
End case 


If ([EventLog:75]idNum:5#0)
	SAVE RECORD:C53([EventLog:75])
End if 