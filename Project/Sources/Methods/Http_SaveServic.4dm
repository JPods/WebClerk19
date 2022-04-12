//%attributes = {"publishedWeb":true}
//Procedure: Http_Service

C_LONGINT:C283($1; $err; $orderNum; $recordID; $ppNum; $k)
C_POINTER:C301($2)
C_LONGINT:C283($recordID)
C_BOOLEAN:C305($modCust)
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$fileID:=Num:C11(WCapi_GetParameter("FileID"; ""))
$custID:=WCapi_GetParameter("customerID"; "")
$modCust:=(WCapi_GetParameter("ModCustomer"; "")="true")
$modOrder:=(WCapi_GetParameter("ModOrder"; "")="true")
$modPp:=(WCapi_GetParameter("ModProposal"; "")="true")
If ($recordID<0)
	CREATE RECORD:C68([Service:6])
	[Service:6]customerID:1:=$custID
	WC_Parse(Table:C252(->[Service:6]); $2)
	If ([Service:6]idNum:26=0)
		
	End if 
	SAVE RECORD:C53([Service:6])
Else 
	QUERY:C277([Service:6]; [Service:6]idNum:26=$recordID)
	If (($recordID>0) & (Record number:C243([Service:6])>-1))  //do not allow access to un identified service records
		//If (([Service]OrderNum#0)&([RemoteUser]SecurityLevel>
		//=<>vbCustMod)&($modOrder))
		//QUERY([Order];[Order]OrderNum=[Service]OrderNum)
		//http_SaveCust ($1;$2)
		//Else 
		//vResponse:=vResponse+"Changes Not authorized or No Customer Record."
		//+"\r"
		//End if 
		If ($modCust)
			If (([Service:6]customerID:1#"") & ([EventLog:75]securityLevel:16>=<>vbCustMod))
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Service:6]customerID:1)
				http_SaveCust($1; $2)
			Else 
				vResponse:=vResponse+"Changes Not authorized or No Customer Record."+"\r"
			End if 
		End if 
		If ($modOrder)
			If (([Service:6]orderNum:22#0) & ([EventLog:75]securityLevel:16>=<>vbOrdMod))
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[Service:6]orderNum:22)
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
						
						If ([Order:3]orderNum:2>0)
							SAVE RECORD:C53([Order:3])
						Else 
							[EventLog:75]areYouHuman:36:="zeroOrder"
							EventLogsMessage("Trying to save a zero Order Http_SaveServic.")
						End if 
						
					End if 
					EventLogsMessage("Posted Order "+String:C10([Service:6]orderNum:22))
					If ([EventLog:75]idNum:5#0)
						SAVE RECORD:C53([EventLog:75])
					End if 
				Else 
					vResponse:=vResponse+"Order Record does not exist."+"\r"
				End if 
			Else 
				vResponse:=vResponse+"Changes Not authorized or No Order Record."+"\r"
			End if 
		End if 
		If ($modPp)
			If (([Service:6]proposalNum:27#0) & ([EventLog:75]securityLevel:16>=<>vbPpMod))
				QUERY:C277([Proposal:42]; [Proposal:42]proposalNum:5=[Service:6]proposalNum:27)
				If (Record number:C243([Proposal:42])>-1)
					LOAD RECORD:C52([Proposal:42])
					If (Locked:C147([Proposal:42]))
						CREATE RECORD:C68([TempRec:55])
						[TempRec:55]dataField:7:=$2->
						[TempRec:55]tableNum:1:=Table:C252(->[Proposal:42])
						[TempRec:55]action:5:="Http_DelayParse"
						[TempRec:55]recordNumOrig:2:=Record number:C243([Proposal:42])
						[TempRec:55]purpose:6:=1
						[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
						SAVE RECORD:C53([TempRec:55])
						vResponse:=vResponse+"Proposal Locked, delayed posting."+"\r"
					Else 
						vText10:=$2->
						WC_Parse(Table:C252(->[Proposal:42]); ->vText10)
					End if 
					EventLogsMessage("Posted Proposal "+String:C10([Service:6]proposalNum:27))
					If ([EventLog:75]idNum:5#0)
						SAVE RECORD:C53([EventLog:75])
					End if 
				Else 
					vResponse:=vResponse+"Proposal Record does not exist."+"\r"
				End if 
			Else 
				vResponse:=vResponse+"Changes Not authorized or No Order Record."+"\r"
			End if 
		End if 
		LOAD RECORD:C52([Service:6])
		If (Locked:C147([Service:6]))
			CREATE RECORD:C68([TempRec:55])
			[TempRec:55]dataField:7:=$2->
			[TempRec:55]tableNum:1:=Table:C252(->[Service:6])
			[TempRec:55]action:5:="Http_DelayParse"
			[TempRec:55]recordNumOrig:2:=Record number:C243([Service:6])
			[TempRec:55]purpose:6:=1
			[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
			SAVE RECORD:C53([TempRec:55])
			vResponse:=vResponse+"Service Locked, delayed posting."+"\r"
		Else 
			WC_Parse(Table:C252(->[Service:6]); $2)
			$doPage:=WC_DoPage("ServiceRec"+$suffix+".html"; "")
			$doThis:=2
		End if 
		EventLogsMessage("Posted Service "+String:C10([Service:6]idNum:26))
		If ([EventLog:75]idNum:5#0)
			SAVE RECORD:C53([EventLog:75])
		End if 
	End if 
End if 