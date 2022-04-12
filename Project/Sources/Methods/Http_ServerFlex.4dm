//%attributes = {"publishedWeb":true}
//Method: Http_ServerFlex

C_LONGINT:C283($1)

//Procedure: http_CallRpt
C_LONGINT:C283($1; $err; $orderNum; $recordID; $ppNum; $k)
C_POINTER:C301($2)
C_LONGINT:C283($recordID; $TableNum)

C_TEXT:C284($doPage; $suffix)
vResponse:=""
$suffix:=""
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")

//zttp_UserGet 
If ([EventLog:75]securityLevel:16<1)
	vResponse:="Sign-in before editing or security level does not allow editing: "+String:C10([EventLog:75]securityLevel:16)
Else 
	$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
	$TableNum:=Num:C11(WCapi_GetParameter("TableNum"; ""))
	$jitPageList:=WCapi_GetParameter("jitPageList"; "")
	$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
	If (($TableNum<89) | ($TableNum>98))
		vResponse:="Invalid Table ID: "+String:C10($TableNum)
	Else 
		GOTO RECORD:C242(Table:C252($TableNum)->; $recordID)
		Case of 
			: (($recordID=-3) | (voState.url="/Flex_New@"))
				CREATE RECORD:C68(Table:C252($TableNum)->)
				WC_Parse($TableNum; ->vText11)
				SAVE RECORD:C53(Table:C252($TableNum)->)
				vResponse:="Posted"
				$doPage:=WC_DoPage("FlexMod"+String:C10($TableNum)+$suffix+".html"; "")
			: ($recordID=-1)
				vResponse:="Record does not exist"
			: (voState.url="/Flex_Mod@")
				$doPage:=WC_DoPage("FlexMod"+String:C10($TableNum)+$suffix+".html"; "")
			: (voState.url="/Flex_Save@")
				
				LOAD RECORD:C52(Table:C252($TableNum)->)
				If (Locked:C147(Table:C252($TableNum)->))
					CREATE RECORD:C68([TempRec:55])
					[TempRec:55]dataField:7:=$2->
					[TempRec:55]tableNum:1:=$TableNum
					[TempRec:55]action:5:="Http_DelayParse"
					[TempRec:55]recordNumOrig:2:=Record number:C243(Table:C252($TableNum)->)
					[TempRec:55]purpose:6:=1
					[TempRec:55]nameID:8:=[RemoteUser:57]customerID:10
					SAVE RECORD:C53([TempRec:55])
					vResponse:=vResponse+"Record Locked, delayed posting."+"\r"
				Else 
					WC_Parse($TableNum; $2)
					SAVE RECORD:C53(Table:C252($TableNum)->)
				End if 
				EventLogsMessage("Posted "+Table name:C256($TableNum))
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
		End case 
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)