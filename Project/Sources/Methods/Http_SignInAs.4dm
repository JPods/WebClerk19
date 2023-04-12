//%attributes = {"publishedWeb":true}
//// ----------------------------------------------------
//// User name (OS): williamjames
//// Date and time: 12/05/09, 01:27:43
//// ----------------------------------------------------
//// Method: Http_SignInAs
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------

//C_LONGINT($1; $err; $userRec)
//C_POINTER($2)
////
//READ WRITE([RemoteUser])
//READ WRITE([EventLog])
//C_LONGINT($w; $h; $t; $TableNum)
//C_TEXT($cat; $ser; $val; $suffix; $userName; $recordID)
////LOAD RECORD([EventLog])
//$doPage:=WC_DoPage("Error.html"; "")
////TRACE
////If (Not((<>vbSaleLevel<1)|(<>vMakeSales<1)))
//// vResponse:="Feature not activated"
////Else 
//vResponse:="Only Reps and Sales can enter for Leads and Customers, or you are not authorized"
//$recordiD:=WCapi_GetParameter("RecordiD"; "")
//$tableName:=WCapi_GetParameter("TableName"; "")
//If ($tableName="")
//$tableName:=WCapi_GetParameter("jitTable"; "")
//If ($tableName="")
//$TableNum:=Num(WCapi_GetParameter("TableNum"; ""))
//If (($TableNum>0) & ($TableNum<=Get last table number))
//$tableName:=Table name($TableNum)
//End if 
//End if 
//End if 
//$userName:=WCapi_GetParameter("userName"; "")
//$password:=WCapi_GetParameter("password"; "")

//If ($tableName#"")
//$TableNum:=STR_GetTableNumber($tableName)
//End if 
//$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//vAddressBillTo:=""
//vAddressShipTo:=""

//// ### bj ### 20190128_0829
//// close current [EventLog] 
//// create a new [EventLog] filling in the Customer and Employee/Rep
//WC_EventLogReplace("Http_SignInAs")

//If ((($TableNum=(Table(->[Customer]))) )) \
& ((vWccTableNum=(Table(->[Employee]))) | (vWccTableNum=(Table(->[Rep]))) | (vWccTableNum=(Table(->[zManufacturerTerm])))))
//vResponse:="No Authorized record found"
//Case of 
//: (($recordiD="") & (($userName="") | ($password="")))
//vResponse:="Note enough inputs"
//$doPage:=WC_DoPage("Error.html"; "")
//: ($TableNum=2)
//If ($recordID#"")
//QUERY([Customer]; [Customer]customerID=$recordID; *)  //find remote user record
//WccAuthAccessByAcct(->[Customer]; ->[Customer]repID; ->[Customer]salesNameID)
//QUERY([Customer])
//Else 
//QUERY([RemoteUser]; [RemoteUser]userName=$userName; *)  //find remote user record
//QUERY([RemoteUser];  & [RemoteUser]userPassword=$password)
////        
//QUERY([Customer]; [Customer]customerID=[RemoteUser]customerID)  //find remote user record
////WccAuthAccessByAcct (->[Customer];->[Customer]RepID;->[Customers
////]SalesName)
//QUERY([Customer])
//End if 
//If (Records in selection([Customer])=1)
//vResponse:="Signed in as: "+[Customer]company
//$theRecNum:=Record number([Customer])

//QUERY([CallReport]; [CallReport]tableNum=2; *)
//QUERY([CallReport];  & [CallReport]customerID=[Customer]customerID; *)
//QUERY([CallReport];  & [CallReport]complete=False; *)
//QUERY([CallReport];  & [CallReport]initiatedBy="Public")
//If ([Customer]terms="CC_SSLSecure")
//tcCheckOutPath:=tcSSLSecure+"/Check_Out"+"_"+<>tcSSLUser+"_"+<>tcDotted
//End if 

//[EventLog]customerRecNum:=Record number([Customer])
//[EventLog]tableNum:=2
//[EventLog]customerID:=[Customer]customerID
//QUERY([RemoteUser]; [RemoteUser]tableNum=Table(->[Customer]); *)
//QUERY([RemoteUser]; [RemoteUser]customerID=[Customer]customerID)
//If (Records in selection([RemoteUser])>0)
//FIRST RECORD([RemoteUser])
//If ([RemoteUser]company="")
//[RemoteUser]company:=[Customer]company
//SAVE RECORD([RemoteUser])
//End if 
//Else 
//RemoteUser_Create(->[Customer]; [Customer]customerID+Txt_RandomString(5; "a"; "z"); [Customer]zip; 1)
//End if 
//If ([RemoteUser]securityLevel=1)
//[RemoteUser]securityLevel:=2
//SAVE RECORD([RemoteUser])
//End if 
////
//P_AddressesCustomer
////
//[EventLog]securityLevel:=[RemoteUser]securityLevel
//[EventLog]remoteUserRec:=Record number([RemoteUser])
//vUseBase:=SetPricePoint([Customer]typeSale)
//// If ($jitPageOne
//$doPage:=WC_DoPage("CustomersOne"+([Customer]webPage*Num([Customer]webPage#"0"))+".html"; $jitPageOne)
//Else 
//vResponse:="No customer record found with matching access Rep/EmployeeID or security level. "
//$doPage:=WC_DoPage("Error.html"; "")
//End if 

//End case 
////P_FillVars (Table([RemoteUser]TableNum))
//[EventLog]shipToRecordid:=0
//[EventLog]shipToTableNum:=0
//If ([EventLog]idNum#0)
//SAVE RECORD([EventLog])
//End if 
//End if 
//$err:=WC_PageSendWithTags($1; $doPage; 0)

//custAddress:=""
//vAddressBillTo:=""
//vAddressShipTo:=""
//ARRAY TEXT(aSignInText; 0)
