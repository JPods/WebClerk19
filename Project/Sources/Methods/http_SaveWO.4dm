//%attributes = {"publishedWeb":true}
//Method: http_SaveWO
C_LONGINT:C283($1; $err; $orderNum; $recordID; $ppNum; $k)
C_POINTER:C301($2)
C_LONGINT:C283($recordID; $LineId; $SOid)
C_BOOLEAN:C305($modCust)
C_TEXT:C284($recordStr)
$recordStr:=WCapi_GetParameter("RecordID"; "")
$recordID:=Num:C11($recordStr)
$custID:=WCapi_GetParameter("customerID"; "")
$SOid:=Num:C11(WCapi_GetParameter("OrderID"; ""))
$LineId:=Num:C11(WCapi_GetParameter("LineID"; ""))
$modCust:=(WCapi_GetParameter("ModCustomer"; "")="true")
$modOrder:=(WCapi_GetParameter("ModOrder"; "")="true")
Case of 
	: ($recordStr="")
		vResponse:="No WorkOrder specified."+"\r"
	: ($recordID=-3)
		CREATE RECORD:C68([WorkOrder:66])
		//If ([WorkOrder]Publish>1)
		//[WorkOrder]Publish:=1
		//End if 
		If ($SOid#0)
			QUERY:C277([Order:3]; [Order:3]idNum:2=$SOid)
			TaskIDAssign(->[Order:3]idNumTask:85)
			[WorkOrder:66]idNumTask:22:=[Order:3]idNumTask:85
			
			
		End if 
		If ($LineId#0)
			[WorkOrder:66]salesOrderLine:2:=$LineId
		End if 
		WC_Parse(Table:C252(->[WorkOrder:66]); $2; False:C215)
		If ([WorkOrder:66]woNum:29=0)
			[WorkOrder:66]woNum:29:=CounterNew(->[WorkOrder:66])
		End if 
		[WorkOrder:66]comment:17:="Via WebSite:"+"\r"+[WorkOrder:66]comment:17
		[WorkOrder:66]mfrID:41:="jitWeb"
		[WorkOrder:66]actionByApproved:48:=[RemoteUser:57]userName:2
		If ($custID#"")
			[WorkOrder:66]customerID:28:=$custID
		End if 
		[WorkOrder:66]dtCreated:44:=DateTime_Enter
		SAVE RECORD:C53([WorkOrder:66])
	Else 
		QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$recordID)
		If (([WorkOrder:66]customerID:28#"") & ([EventLog:75]securityLevel:16>=<>vbCustMod) & ($modCust))
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
			http_SaveCust($1; $2)
		Else 
			vResponse:=vResponse+"Changes Not authorized or No Customer Record."+"\r"
		End if 
		If (([WorkOrder:66]idNumTask:22#0) & ([EventLog:75]securityLevel:16>=<>vbOrdMod))
			QUERY:C277([Order:3]; [Order:3]idNum:2=[WorkOrder:66]idNumTask:22)
			If (Record number:C243([Order:3])>-1)
				LOAD RECORD:C52([Order:3])
				If (Locked:C147([Order:3]))
					CREATE RECORD:C68([TempRec:55])
					[TempRec:55]dataField:7:=$2->
					[TempRec:55]tableNum:1:=Table:C252(->[Order:3])
					[TempRec:55]action:5:="Http_DelayParse"
					[TempRec:55]recordNumOrig:2:=Record number:C243([Order:3])
					[TempRec:55]purpose:6:=1
					[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
					SAVE RECORD:C53([TempRec:55])
					vResponse:=vResponse+"Order Locked, delayed posting."+"\r"
				Else 
					vText10:=$2->
					WC_Parse(Table:C252(->[Order:3]); ->vText10)
					
					If ([Order:3]idNum:2>0)
						SAVE RECORD:C53([Order:3])
					Else 
						[EventLog:75]areYouHuman:36:="zeroOrder"
						EventLogsMessage("Trying to save a zero Order Http_SaveWO.")
					End if 
					
				End if 
				EventLogsMessage("Posted Order "+String:C10([Service:6]idNumOrder:22))
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
			Else 
				vResponse:=vResponse+"Order Record does not exist."+"\r"
			End if 
		Else 
			vResponse:=vResponse+"Changes Not authorized or No Order Record."+"\r"
		End if 
		READ WRITE:C146([WorkOrder:66])
		LOAD RECORD:C52([WorkOrder:66])
		If (Locked:C147([WorkOrder:66]))
			CREATE RECORD:C68([TempRec:55])
			[TempRec:55]dataField:7:=$2->
			[TempRec:55]tableNum:1:=Table:C252(->[WorkOrder:66])
			[TempRec:55]action:5:="Http_DelayParse"
			[TempRec:55]recordNumOrig:2:=Record number:C243([WorkOrder:66])
			[TempRec:55]purpose:6:=1
			[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
			SAVE RECORD:C53([TempRec:55])
			vResponse:=vResponse+"WorkOrder Locked, delayed posting."+"\r"
		Else 
			WC_Parse(Table:C252(->[WorkOrder:66]); $2)
			SAVE RECORD:C53([WorkOrder:66])
			vResponse:=vResponse+"WorkOrder posted."+"\r"
		End if 
		EventLogsMessage("Posted Service "+String:C10([WorkOrder:66]woNum:29))
		If ([EventLog:75]idNum:5#0)
			SAVE RECORD:C53([EventLog:75])
		End if 
End case 