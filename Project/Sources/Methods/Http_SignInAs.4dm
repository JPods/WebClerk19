//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/05/09, 01:27:43
// ----------------------------------------------------
// Method: Http_SignInAs
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $err; $userRec)
C_POINTER:C301($2)
//
READ WRITE:C146([RemoteUser:57])
READ WRITE:C146([EventLog:75])
C_LONGINT:C283($w; $h; $t; $TableNum)
C_TEXT:C284($cat; $ser; $val; $suffix; $userName; $recordID)
//LOAD RECORD([EventLog])
$doPage:=WC_DoPage("Error.html"; "")
//TRACE
//If (Not((<>vbSaleLevel<1)|(<>vMakeSales<1)))
// vResponse:="Feature not activated"
//Else 
vResponse:="Only Reps and Sales can enter for Leads and Customers, or you are not authorized"
$recordiD:=WCapi_GetParameter("RecordiD"; "")
$tableName:=WCapi_GetParameter("TableName"; "")
If ($tableName="")
	$tableName:=WCapi_GetParameter("jitTable"; "")
	If ($tableName="")
		$TableNum:=Num:C11(WCapi_GetParameter("TableNum"; ""))
		If (($TableNum>0) & ($TableNum<=Get last table number:C254))
			$tableName:=Table name:C256($TableNum)
		End if 
	End if 
End if 
$userName:=WCapi_GetParameter("userName"; "")
$password:=WCapi_GetParameter("password"; "")

If ($tableName#"")
	$TableNum:=STR_GetTableNumber($tableName)
End if 
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
vAddressBillTo:=""
vAddressShipTo:=""

// ### bj ### 20190128_0829
// close current [EventLog] 
// create a new [EventLog] filling in the Customer and Employee/Rep
WC_EventLogReplace("Http_SignInAs")

If ((($TableNum=(Table:C252(->[Customer:2]))) | ($TableNum=(Table:C252(->[zzzLead:48])))) & ((vWccTableNum=(Table:C252(->[Employee:19]))) | (vWccTableNum=(Table:C252(->[Rep:8]))) | (vWccTableNum=(Table:C252(->[ManufacturerTerm:111])))))
	vResponse:="No Authorized record found"
	Case of 
		: (($recordiD="") & (($userName="") | ($password="")))
			vResponse:="Note enough inputs"
			$doPage:=WC_DoPage("Error.html"; "")
		: ($TableNum=2)
			If ($recordID#"")
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=$recordID; *)  //find remote user record
				WccAuthAccessByAcct(->[Customer:2]; ->[Customer:2]repID:58; ->[Customer:2]salesNameID:59)
				QUERY:C277([Customer:2])
			Else 
				QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$userName; *)  //find remote user record
				QUERY:C277([RemoteUser:57];  & [RemoteUser:57]userPassword:3=$password)
				//        
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[RemoteUser:57]customerID:10)  //find remote user record
				//WccAuthAccessByAcct (->[Customer];->[Customer]RepID;->[Customers
				//]SalesName)
				QUERY:C277([Customer:2])
			End if 
			If (Records in selection:C76([Customer:2])=1)
				vResponse:="Signed in as: "+[Customer:2]company:2
				$theRecNum:=Record number:C243([Customer:2])
				
				QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=2; *)
				QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=[Customer:2]customerID:1; *)
				QUERY:C277([CallReport:34];  & [CallReport:34]complete:7=False:C215; *)
				QUERY:C277([CallReport:34];  & [CallReport:34]initiatedBy:23="Public")
				If ([Customer:2]terms:33="CC_SSLSecure")
					tcCheckOutPath:=tcSSLSecure+"/Check_Out"+"_"+<>tcSSLUser+"_"+<>tcDotted
				End if 
				
				[EventLog:75]customerRecNum:8:=Record number:C243([Customer:2])
				[EventLog:75]tableNum:9:=2
				[EventLog:75]customerID:38:=[Customer:2]customerID:1
				QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=Table:C252(->[Customer:2]); *)
				QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerID:10=[Customer:2]customerID:1)
				If (Records in selection:C76([RemoteUser:57])>0)
					FIRST RECORD:C50([RemoteUser:57])
					If ([RemoteUser:57]company:16="")
						[RemoteUser:57]company:16:=[Customer:2]company:2
						SAVE RECORD:C53([RemoteUser:57])
					End if 
				Else 
					RemoteUser_Create(->[Customer:2]; [Customer:2]customerID:1+Txt_RandomString(5; "a"; "z"); [Customer:2]zip:8; 1)
				End if 
				If ([RemoteUser:57]securityLevel:4=1)
					[RemoteUser:57]securityLevel:4:=2
					SAVE RECORD:C53([RemoteUser:57])
				End if 
				//
				P_AddressesCustomer
				//
				[EventLog:75]securityLevel:16:=[RemoteUser:57]securityLevel:4
				[EventLog:75]remoteUserRec:10:=Record number:C243([RemoteUser:57])
				vUseBase:=SetPricePoint([Customer:2]typeSale:18)
				// If ($jitPageOne
				$doPage:=WC_DoPage("CustomersOne"+([Customer:2]webPage:94*Num:C11([Customer:2]webPage:94#"0"))+".html"; $jitPageOne)
			Else 
				vResponse:="No customer record found with matching access Rep/EmployeeID or security level. "
				$doPage:=WC_DoPage("Error.html"; "")
			End if 
		: ($TableNum=48)
			QUERY:C277([zzzLead:48]; [zzzLead:48]idNum:32=Num:C11($recordID); *)
			WccAuthAccessByAcct(->[zzzLead:48]; ->[zzzLead:48]repID:12; ->[zzzLead:48]salesNameID:13)
			QUERY:C277([zzzLead:48])
			If (Records in selection:C76([zzzLead:48])=1)
				vResponse:="Signed in as: "+[zzzLead:48]company:5
				$theRecNum:=Record number:C243([zzzLead:48])
				QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=48; *)
				QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=String:C10([zzzLead:48]idNum:32); *)
				QUERY:C277([CallReport:34];  & [CallReport:34]complete:7=False:C215; *)
				QUERY:C277([CallReport:34];  & [CallReport:34]initiatedBy:23="Public")
				If (Records in selection:C76([RemoteUser:57])>0)
					FIRST RECORD:C50([RemoteUser:57])
					If ([RemoteUser:57]company:16="")
						[RemoteUser:57]company:16:=[zzzLead:48]company:5
						SAVE RECORD:C53([RemoteUser:57])
					End if 
				Else 
					RemoteUser_Create(->[zzzLead:48]; "L"+String:C10([zzzLead:48]idNum:32)+Txt_RandomString(5; "a"; "z"); [zzzLead:48]zip:10; 1)
				End if 
				[EventLog:75]securityLevel:16:=[RemoteUser:57]securityLevel:4
				[EventLog:75]tableNum:9:=48
				[EventLog:75]remoteUserRec:10:=Record number:C243([RemoteUser:57])
				[EventLog:75]customerRecNum:8:=Record number:C243([zzzLead:48])
				$doPage:=WC_DoPage("LeadsOne.html"; $jitPageOne)
			Else 
				vResponse:="No lead record found with matching access Rep/EmployeeID or security level. "
				$doPage:=WC_DoPage("Error.html"; "")
			End if 
	End case 
	//P_FillVars (Table([RemoteUser]TableNum))
	[EventLog:75]shipToRecordid:35:=0
	[EventLog:75]shipToTableNum:34:=0
	If ([EventLog:75]idNum:5#0)
		SAVE RECORD:C53([EventLog:75])
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)

custAddress:=""
vAddressBillTo:=""
vAddressShipTo:=""
ARRAY TEXT:C222(aSignInText; 0)
