//%attributes = {"publishedWeb":true}
//Method: http_SaveCall
C_LONGINT:C283($1; $err; $orderNum; $recordID; $ppNum; $k)
C_POINTER:C301($2)


C_TEXT:C284($custID)
C_BOOLEAN:C305($modCust; $modContact; $modVend; $modRep)
C_TEXT:C284($doPage; $suffix)
$suffix:=""
$doPage:=WC_DoPage("Posted"+$suffix+".html"; "")
C_LONGINT:C283($recordID)
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$fileID:=Num:C11(WCapi_GetParameter("FileID"; ""))
$custID:=WCapi_GetParameter("customerID"; "")
$modCust:=(WCapi_GetParameter("ModCustomer"; "")="true")
$modContact:=(WCapi_GetParameter("ModContact"; "")="true")
$modVend:=(WCapi_GetParameter("ModVendor"; "")="true")
$modRep:=(WCapi_GetParameter("ModRep"; "")="true")
//
If (($modCust) | ($modContact) | ($modVend) | ($modRep))
	vText10:=$2->
	$checkPrime:=True:C214
Else 
	$checkPrime:=False:C215
End if 

C_TEXT:C284($createdBy)
Case of 
	: ($recordID=-3)
		CREATE RECORD:C68([CallReport:34])
		WC_Parse(Table:C252(->[CallReport:34]); $2)
		If ([CallReport:34]idNum:22=0)
			
		End if 
		[CallReport:34]tableNum:2:=$fileID
		[CallReport:34]customerID:1:=$custID
		Case of 
			: ([RemoteUser:57]tableNum:9=38)  //   GOTO RECORD([Vendor];[EventLog]CustomerRecNum)
				[CallReport:34]initiatedBy:23:=[Vendor:38]vendorID:1
			: ([RemoteUser:57]tableNum:9=8)  //GOTO RECORD([Rep];[EventLog]CustomerRecNum)
				[CallReport:34]initiatedBy:23:=[Rep:8]repID:1
			: ([RemoteUser:57]tableNum:9=19)
				[CallReport:34]initiatedBy:23:=[Employee:19]nameID:1
		End case 
		SAVE RECORD:C53([CallReport:34])
	: ($recordID>-1)
		QUERY:C277([CallReport:34]; [CallReport:34]idNum:22=$recordID; *)
		If ([RemoteUser:57]securityLevel:4<5000)
			QUERY:C277([CallReport:34];  & [CallReport:34]actionBy:3=[RemoteUser:57]customerID:10; *)
		End if 
		QUERY:C277([CallReport:34])
		If (Record number:C243([CallReport:34])>-1)
			$doPage:=WC_DoPage("Posted"+$suffix+".html"; "")
			LOAD RECORD:C52([CallReport:34])
			If (Locked:C147([CallReport:34]))
				CREATE RECORD:C68([TempRec:55])
				[TempRec:55]dataField:7:=$2->
				[TempRec:55]tableNum:1:=Table:C252(->[CallReport:34])
				[TempRec:55]action:5:="Http_DelayParse"
				[TempRec:55]recordNumOrig:2:=Record number:C243([CallReport:34])
				[TempRec:55]purpose:6:=1
				[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
				SAVE RECORD:C53([TempRec:55])
				vResponse:=vResponse+"Call Report Locked, delayed posting."+"\r"
			Else 
				WC_Parse(Table:C252(->[CallReport:34]); $2)
				SAVE RECORD:C53([CallReport:34])
			End if 
			EventLogsMessage("Posted Call "+String:C10([CallReport:34]idNum:22))
			If ([EventLog:75]idNum:5#0)
				SAVE RECORD:C53([EventLog:75])
			End if 
		End if 
	Else 
		C_BOOLEAN:C305($checkPrime)
		$checkPrime:=False:C215
		vResponse:=vResponse+"Call Report does not exist."+"\r"
		$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)


If ($checkPrime)
	Case of 
		: (([CallReport:34]tableNum:2=2) & ($modCust))
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[CallReport:34]customerID:1)
			http_SaveCust($1; ->vText10; 0)
		: (([CallReport:34]tableNum:2=Table:C252(->[Contact:13])) & ($modContact))
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11([CallReport:34]customerID:1))
			If (Record number:C243([Contact:13])>-1)
				LOAD RECORD:C52([Contact:13])
				If (Locked:C147([Contact:13]))
					CREATE RECORD:C68([TempRec:55])
					[TempRec:55]dataField:7:=vText10
					[TempRec:55]tableNum:1:=Table:C252(->[Contact:13])
					[TempRec:55]action:5:="Http_DelayParse"
					[TempRec:55]recordNumOrig:2:=Record number:C243([Contact:13])
					[TempRec:55]purpose:6:=1
					[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
					SAVE RECORD:C53([TempRec:55])
					vResponse:=vResponse+"Contact Locked, delayed posting."+"\r"
				Else 
					WC_Parse(Table:C252(->[Contact:13]); ->vText10)
					SAVE RECORD:C53([Contact:13])
				End if 
			End if 
			EventLogsMessage("Posted Contact "+String:C10([Contact:13]idNum:28))
			If ([EventLog:75]idNum:5#0)
				SAVE RECORD:C53([EventLog:75])
			End if 
		: (([CallReport:34]tableNum:2=Table:C252(->[Vendor:38])) & ($modVend))
			QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[CallReport:34]customerID:1)
			If (Record number:C243([Vendor:38])>-1)
				LOAD RECORD:C52([Vendor:38])
				If (Locked:C147([Vendor:38]))
					CREATE RECORD:C68([TempRec:55])
					[TempRec:55]dataField:7:=vText10
					[TempRec:55]tableNum:1:=Table:C252(->[Vendor:38])
					[TempRec:55]action:5:="Http_DelayParse"
					[TempRec:55]recordNumOrig:2:=Record number:C243([Vendor:38])
					[TempRec:55]purpose:6:=1
					[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
					SAVE RECORD:C53([TempRec:55])
					vResponse:=vResponse+"Vendor Locked, delayed posting."+"\r"
				Else 
					WC_Parse(Table:C252(->[Vendor:38]); ->vText10)
					SAVE RECORD:C53([Vendor:38])
				End if 
				EventLogsMessage("Posted Vendor "+[PO:39]vendorID:1)
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
			End if 
		: (([CallReport:34]tableNum:2=Table:C252(->[Lead:48])) & ($modCust))
			QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11([CallReport:34]customerID:1))
			Http_SaveLead($1; ->vText10; 0)
			EventLogsMessage("Posted Lead "+String:C10([Lead:48]idNum:32))
			If ([EventLog:75]idNum:5#0)
				SAVE RECORD:C53([EventLog:75])
			End if 
		: (([CallReport:34]tableNum:2=Table:C252(->[Rep:8])) & ($modRep))
			QUERY:C277([Rep:8]; [Rep:8]repID:1=[CallReport:34]customerID:1)
			If (Record number:C243([Rep:8])>-1)
				LOAD RECORD:C52([Rep:8])
				If (Locked:C147([Rep:8]))
					CREATE RECORD:C68([TempRec:55])
					[TempRec:55]dataField:7:=vText10
					[TempRec:55]tableNum:1:=Table:C252(->[Rep:8])
					[TempRec:55]action:5:="Http_DelayParse"
					[TempRec:55]recordNumOrig:2:=Record number:C243([Rep:8])
					[TempRec:55]purpose:6:=1
					[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
					SAVE RECORD:C53([TempRec:55])
					vResponse:=vResponse+"Rep Locked, delayed posting."+"\r"
				Else 
					WC_Parse(Table:C252(->[Rep:8]); ->vText10)
					SAVE RECORD:C53([Rep:8])
				End if 
				EventLogsMessage("Posted Rep "+[Rep:8]repID:1)
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
			End if 
	End case 
End if 