//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $recordID)
C_POINTER:C301($2)

C_TEXT:C284($doPage; $suffix)
$suffix:=""
READ ONLY:C145([Order:3])
READ ONLY:C145([Customer:2])
//
$doPage:=<>WebFolder+"Error"+$suffix+".html"
$recordID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
$jitPageOne:=WCapi_GetParameter("$jitPageOne"; "")
vResponse:="No Work Order: "+String:C10($recordID)+" with this User."
If ($recordID>0)
	If (vWccTableNum=(Table:C252(->[Employee:19])))
		GOTO RECORD:C242([Employee:19]; vWccPrimeRec)
		If (Records in selection:C76([Employee:19])=1)
			QUERY:C277([WorkOrder:66]; [WorkOrder:66]woNum:29=$recordID)
			If ((Records in selection:C76([WorkOrder:66])=1) & (([RemoteUser:57]securityLevel:4>4999) | ([WorkOrder:66]actionBy:8=[Employee:19]nameID:1) | ([WorkOrder:66]actionByInitiated:9=[Employee:19]nameID:1)))
				If ([WorkOrder:66]taskid:22#0)
					QUERY:C277([Order:3]; [Order:3]taskid:85=[WorkOrder:66]taskid:22)
					QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
				End if 
				If ([WorkOrder:66]customerID:28#"")
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[WorkOrder:66]customerID:28)
				End if 
				$doPage:=WC_DoPage("WOMod"+$suffix+".html"; $jitPageOne)
			Else 
				REDUCE SELECTION:C351([WorkOrder:66]; 0)
			End if 
		End if 
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
//
