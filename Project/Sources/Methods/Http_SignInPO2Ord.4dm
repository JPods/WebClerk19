//%attributes = {"publishedWeb":true}
//Method: Http_SignInPO2Ord
C_POINTER:C301($1)
//
C_TEXT:C284($userName; $password; $theBody)
C_BOOLEAN:C305($doThis)
$userName:=WCapi_GetParameter("userName"; "")
$password:=WCapi_GetParameter("password"; "")
If (($userName#"") & ($password#""))
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName; *)
	QUERY:C277([RemoteUser:57];  & [RemoteUser:57]userPassword:3=$password)
	If (Records in selection:C76([RemoteUser:57])=1)
		$doThis:=True:C214
		$theBody:=WCapi_GetParameter("jitPO"; "")
		Case of 
			: ([RemoteUser:57]tableNum:9=2)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerid:10)
				$theRecNum:=Record number:C243([Customer:2])
			: ([RemoteUser:57]tableNum:9=48)
				QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11([RemoteUser:57]customerid:10))
				$theRecNum:=Record number:C243([Lead:48])
			: ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]))
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=[RemoteUser:57]customerid:10)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
				$theRecNum:=Record number:C243([Customer:2])
			Else 
				$doThis:=False:C215
		End case 
		If ($doThis)
			[EventLog:75]tableNum:9:=[RemoteUser:57]tableNum:9
			[EventLog:75]customerRecNum:8:=$theRecNum
			[EventLog:75]remoteUserRec:10:=Record number:C243([RemoteUser:57])
		End if 
	End if 
End if 