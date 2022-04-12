//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/07/09, 15:51:25
// ----------------------------------------------------
// Method: WC_TestFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($testFolder)
C_TEXT:C284($1)
C_BOOLEAN:C305($0; $vbLaunch)
$vbLaunch:=False:C215

If (([WebClerk:78]pathTojitWeb:16[[Length:C16([WebClerk:78]pathTojitWeb:16)]]#"\\") & ([WebClerk:78]pathTojitWeb:16[[Length:C16([WebClerk:78]pathTojitWeb:16)]]#":"))
	//[WebClerk]PathTojitWeb:=[WebClerk]PathTojitWeb+Folder separator
	//SAVE RECORD([WebClerk])    // ### JWM ### 20171013_1652 problem if Mac path opened on Windows and vice versa
	ALERT:C41("Error: The path to the jitWeb folder is missing last seperator\r\r"+[WebClerk:78]pathTojitWeb:16)
	$vbLaunch:=False:C215
Else 
	If ((Position:C15("jitWeb"; [WebClerk:78]pathTojitWeb:16)<1))
		ALERT:C41("Error: The path to the jitWeb folder is missing \"jitWeb\".\r\r"+[WebClerk:78]pathTojitWeb:16)
		$vbLaunch:=False:C215
	Else 
		If (Test path name:C476([WebClerk:78]pathTojitWeb:16)#Is a folder:K24:2)
			ALERT:C41("Error: The path to the jitWeb folder is invalid.\r\r"+[WebClerk:78]pathTojitWeb:16)
			$vbLaunch:=False:C215
		Else 
			$vbLaunch:=True:C214
			C_TEXT:C284($defaults)
			// ### bj ### 20181228_1114
			WC_PathRemoteTest  // does not seem to be used at this time
			// [WebClerk]ArrayWebPages removed
			<>vbWCRegisterLeads:=[WebClerk:78]registerLeads:18
			<>WebFolder:=[WebClerk:78]pathTojitWeb:16
			
			Use (Storage:C1525)
				Use (Storage:C1525.paths)
					Storage:C1525.paths.jitWeb:=[WebClerk:78]pathTojitWeb:16
				End use 
			End use 
			<>wcPortNum:=[WebClerk:78]port:8
			<>wcPortNumSSL:=[WebClerk:78]portSSL:9
			<>vbforceSSL:=[WebClerk:78]sslForce:19
			<>HTTPD_EnableSSL:=<>vbforceSSL
			If (<>vbforceSSL=False:C215)
				<>HTTPD_EnableSSL:=[WebClerk:78]sslEnable:24
			End if 
			<>viWCThreadCount:=[WebClerk:78]threadCount:25
			<>HTTPD_ServerSocket:=0
			<>HTTPD_SSLSocket:=0
			<>HTTPD_IsInitialised:=True:C214
			<>vbWCstop:=False:C215  //issue a stop to all WC_ThreadPoolWorker
			
			<>voWebServerPrefs.registerLeads:=[WebClerk:78]registerLeads:18
			<>voWebServerPrefs.baseWebFolder:=[WebClerk:78]pathTojitWeb:16
			<>voWebServerPrefs.portNum:=[WebClerk:78]port:8
			<>voWebServerPrefs.portNumSSL:=[WebClerk:78]portSSL:9
			<>voWebServerPrefs.forceSSL:=[WebClerk:78]sslForce:19
			If (<>voWebServerPrefs.forceSSL)
				<>voWebServerPrefs.enableSSL:=True:C214
			Else 
				<>voWebServerPrefs.enableSSL:=[WebClerk:78]sslEnable:24
			End if 
			<>voWebServerPrefs.threadCount:=[WebClerk:78]threadCount:25
			
			<>voWebServerPrefs.childProductTypes:=New collection:C1472
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-RD"; "label"; "Red Housing"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-BL"; "label"; "Blue Housing"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-GY"; "label"; "Gray Lid"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-N4"; "label"; "NEMA4 Housing"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-NC"; "label"; "Normally Closed"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-NONC"; "label"; "Normally Closed"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-L4"; "label"; "Coin Latch"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-IC"; "label"; "UL508 Version"))
			<>voWebServerPrefs.childProductTypes.push(New object:C1471("suffix"; "-P1"; "label"; "Dry Contact Control"))
			
			
			<>vLocalHost:=[WebClerk:78]localIP:26
			<>tcServerFarm:=[WebClerk:78]pathToRemote:17
			C_TEXT:C284(<>vtapiURLFragment)
			<>vtapiURLFragment:=[WebClerk:78]apiURLFragment:44
			// <>vlCEAware:=
			<>wcbCustomerMods:=1
			<>vbNoCustomWeb:=1  // allow custom 
			<>vtcAutoPrint:=0  // no auto print of orders at this time Use Timed Events
			<>vCommunitySite:=1
			<>vSiteSwitching:=1
			<>vWebCustomerDirect:=1  // always register a person as a customer
			<>vWebCustBalMaxOrd:=0  //
			
			<>vMakeSales:=1
			<>vbSaleLevel:=1
			<>vbCustMod:=1
			<>vbLeadMod:=1
			<>vbServMod:=1
			
			<>vlChangeReservations:=0
			<>vlPublishReservations:=0
			<>vlCartTime:=0
			<>vlCycleTime:=0
			
			<>viMatrixPricing:=0
			<>CashDrawerOpen:=0
			<>vbItemExtender:=0
			<>vlWcGetSpec:=1
			<>vlWildSrch:=1
			<>vlignorShipping:=0
			<>vtcStrictInventory:=0
			<>vMinOrder:=[WebClerk:78]orderMinimum:43
			
			<>vWebNoPriceComment:=[WebClerk:78]commentNoPrice:41
			<>viWebPriceLevel:=2
			<>vlWebRealPr:=2
			<>WebRealFormat:=("###,###,###,##0.00")  // #### AZM #### 20171013_1409 - This is hardcoded in main prefs now.
			<>vlWebTimeOutDelay:=0
			
			<>vlSecurityBump:=0
			<>vlFixPages:=0
			
			// <>vWebPrice:=[WebClerk]PricePoint
			<>vWebTerms:=[WebClerk:78]terms:32
			
			<>RPServer:=0
			<>RPPort:=0
			
			<>vMaxUpLoadSize:=2000
			<>UpLoadSecurity:=0
			<>UpLoadServer:=0
			
			<>viMaxShow:=10000
			<>viWebShow:=10000
			
			<>viDoHttpLog:=0
			<>viOrdStatus:=1
			
			
			<>vEmailDelay:=60
			<>vEmailPerSend:=20
			
			// ### azm ### 20180914_1619 for future development
			C_TEXT:C284(<>vtErrorPage401; <>vtErrorPage403; <>vtErrorPage404; <>vtErrorPage500)
			<>vtErrorPage401:="Error.html"  // NOT AUTHENTICATED
			<>vtErrorPage403:="Error.html"  // NOT AUTHORIZED
			<>vtErrorPage404:="Error.html"  // PAGE NOT FOUND
			<>vtErrorPage500:="Error.html"  // GENERAL
			
			
			//  Version              ComEx15cm           Date                                                                 9/5/17
			//  variable             value               Type            where used
			//  <>tcDotted                               is string Var   Remnant from use of tcCheckOutPath
			//  <>tcSecure                               is string Var   Remnant from use of tcCheckOutPath
			//  <>tcSSLUser                              is string Var   Remnant from use of tcCheckOutPath
			//  <>viOrdStatus                         1  Is LongInt      Window top right, Clone orders Http_CloneOrd and Http_OrdStatus
			//  <>viDoHttpLog                         1  Is LongInt      Remnant to track changes
			//  <>viMaxShow                        2000  Is LongInt      Maximum records to display on a web page
			//  <>vHttpProcesses                     10  Is LongInt      Number of web listening processes
			//  lPort                              8080  Is LongInt      Primary unsecured port
			//  <>vlWcGetSpec                         1  Is LongInt      Remnant, relate ItemSpec when showing Items, automatic now
			//  <>vlWebRealPr                         2  Is LongInt      Number of decimal points for real numbers
			//  <>vlFixPages                          0  Is LongInt      Remnant
			//  <>vWebPrice          List                is string Var   New customer default type sale
			//  <>vlWildSrch                          1  Is LongInt      Allow wild card searches
			//  <>vWebTerms          Credit Card         is string Var   New customer default terms
			//  <>vMakeSales                          1  Is LongInt      Remnant
			//  <>vbSaleLevel                         1  Is LongInt      Remnant
			//  <>vbCustMod                           1  Is LongInt      Remnant
			//  <>vbLeadMod                           1  Is LongInt      Remnant
			//  <>vbServMod                           1  Is LongInt      Remnant
			//  <>tcCCNameRefNum     wcRefNum_Zip        is string Var   where used
			//  <>tcCCNameAuthNum    wcApproval_Address  is string Var   where used
			//  <>tcCCNamePayType    wcPayType           is string Var   where used
			//  <>tcCCNameDocID      wceventID           is string Var   where used
			//  <>tcCCNameTotal      wcOrderTotal        is string Var   where used
			//  <>tcCCNameAction     wcPayAction         is string Var   where used
			//  <>tcCCNameAVS        wcAVS               is string Var   where used
			//  <>tcPrivateKeyFile   key.pem             is string Var   where used
			//  <>tcCertificateFile  cert.pem            is string Var   where used
			//  <>tcPrivateKeyPass                       is string Var   where used
			//  <>tcServerFarm                           is string Var   where used
			//  <>vbItemExtender                      1  Is LongInt      Remnant, ItemNum extenders always checked
			//  <>vtcOldOrders                        1  Is LongInt      Show completed orders Http_OrdStatus
			//  <>vtcAutoIDs                          1  Is LongInt      Remnant
			//  <>vtcAltSearch                        0  Is LongInt      <>vtcAltSearch
			//  <>vbNoCustomWeb                       5  Is LongInt      Prevents web scripts when zero http_Custom
			//  <>vtcShowLedgers                      0  Is LongInt      Relate Ledgers at sign-in, replace with page script
			//  <>vtcDoWOs                            0  Is LongInt      Remnant, http_Custom allow WorkOrders
			//  <>viWebShow                        1000  Is LongInt      Setting records per web page
			//  <>vtcAutoPrint                        0  Is LongInt      Automatic printing new orders
			//  <>vtcStrictInventory                  0  Is LongInt      ItemNarrow restricts to items with available inventory
			//  <>vlCycleTime                         0  Is LongInt      Timeout of Reservation processing
			//  <>vlCartTime                          1  Is LongInt      Timeout of Reservation processing
			//  <>vlSecurityBump                      0  Is LongInt      Adjusts Security requirements, zero unless special case
			//  <>bWebChange                          0  Is LongInt      Remnant, restricts some changes in orders and proposals
			//  <>vlignorShipping                     1  Is LongInt      Allows orders to be processed without shipping data.
			//  <>vlPublishReservatio                 0  Is LongInt      Remnant allows reservation
			//  <>vlChangeReservation                 0  Is LongInt      Remnant change reservation
			//  Storage.default.email            sales@functio       is string Var   Default service email, overwrite by Employee Admin
			//  Storage.default.emailServer        functionaldevices.cois string Var   Default server email, overwrite by Employee Admin
			//  <>vlCEAware                           1  Is LongInt      Remnant, replaced by jitUserAgent
			//  <>vSecurePortNum                   8443  Is LongInt      Port number for secure web serving
			//  <>vSecureNumProcesses                10  Is LongInt      Number of listening processes for secure web serving
			//  <>vEmailPerSend                      20  Is LongInt      Email governor timing
			//  <>vEmailDelay                       360  Is LongInt      Email governor delays between sends
			//  <>vHTMLTest                           0  Is LongInt      Pending switching between JITtag with numbers/names
			//  <>UpLoadServer                        0  Is LongInt      NTKHTTPD__Server number of listening process to upload documents
			//  <>vSiteSwitching                      0  Is LongInt      Http_ServerAdmin chan
			//  <>vCommunitySite                      1  Is LongInt      Allows CWSCommunityServer
			//  <>UpLoadSecurity                      0  Is LongInt      Security level required to upload docs
			//  <>vMaxUpLoadSize                      0  Is LongInt      Maximum size of file allowed to be uploaded.
			//  <>viDebugTries                       10  Is LongInt      Remnant
			//  <>viDebugDelay                       10  Is LongInt      Remnant
			//  <>vLocalHost                             is string Var   Address of the local host
			//  <>vWebCustomerDirect                  1  Is LongInt      Http_Register automatically converts Leads data into Customers records.
			//  <>vWebCustBalMaxOrd                   0  Is LongInt      Http_OrdFill calculates customer balance
			//  <>vMinOrder                           0  Is LongInt      Http_PostOrd2_Hold to check dollars ordered by manufacturer
			//  <>viWebPriceLevel                     0  Is LongInt      Comments out pricing if not WCC signed it ItemKeyPathVariables
			//  <>vWebNoPriceComment Call                is string Var   Remnant, Replaces Unit price with 'Call' manage with -6
			//  <>CashDrawerOpen                      0  Is LongInt      Opens a cash draw via serial signal
			//  <>RPServer                            0  Is LongInt      Setup for RecordPassing Server
			//  <>RPPort                              0  Is LongInt      Port for RecordPassing
			//  <>vlWebTimeOutDelay                   0  Is LongInt      Set timeout length for sending emails
			//  Storage.default.domain           .com                is string Var   putting the web site on html pages
			//  <>viMatrixPricing                     1  Is LongInt      Allows using PriceMatrix
			
			If (([WebClerk:78]scriptExecute:33) & ([WebClerk:78]script:13#""))
				ExecuteText(0; [WebClerk:78]script:13)
			End if 
			//
			//TRACE
			
			If ([WebClerk:78]selectBuild:37)  // set to true to update all properly defined selection lists
				// update the selection and objects on pages
				
				
				<>WebFolder:=[WebClerk:78]pathTojitWeb:16
				
			End if 
			
			C_TEXT:C284($content)
			If ([WebClerk:78]mime:2="")
				[WebClerk:78]mime:2:=WC_MimeBuild
			End if 
			WC_JsonMime
			// $content:=WC_GetContentTypeFor ([WebClerk]Mime)
			
			
			<>webFolderShortName:=HFS_ShortName(<>WebFolder)
			ARRAY TEXT:C222(<>aUserAgent; 0)
			ARRAY TEXT:C222(<>aUserAgentRoot; 0)
			C_TEXT:C284($uaName; $uaAccept; $uaRoot; $vtAgents)
			C_OBJECT:C1216($obPathAgents; $obAgents)
			If (Test path name:C476(<>WebFolder+"jitUserAgent.txt")=Is a document:K24:1)
				$obPathAgents:=Path to object:C1547(<>WebFolder+"jitUserAgent.txt")
				$vtAgents:=Document to text:C1236(<>WebFolder+"jitUserAgent.txt")
				$obAgents:=New object:C1471
				If ($obPathAgents#Null:C1517)
					If ($vtAgents="{@")
						$obAgents:=JSON Parse:C1218($vtAgents)
					End if 
					// ### bj ### 20201208_1159
					// leave this empty for now
					If (False:C215)
						ARRAY TEXT:C222(<>aUserAgent; 0)
						ARRAY TEXT:C222(<>aUserAgentRoot; 0)
						ALERT:C41(“aUserAgent: “+String:C10(Size of array:C274(<>aUserAgent))+”:  aUserAgentRoot: “+String:C10(Size of array:C274(<>aUserAgentRoot)))
					End if 
				End if 
			End if 
			//
			<>jitWebFolderFull:=<>WebFolder
			
			
			C_TEXT:C284(<>vAllyhtmlTemplate; <>AllyTagTemplate)
			<>vAllyhtmlTemplate:=""
			<>AllyTagTemplate:=""
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="Admin"; *)  // convert to [WebClerk]
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="AllyTemplate")
			If (Records in selection:C76([TallyMaster:60])=0)
				CREATE RECORD:C68([TallyMaster:60])
				
				[TallyMaster:60]purpose:3:="Admin"
				[TallyMaster:60]name:8:="AllyTemplate"
				[TallyMaster:60]build:6:="Retailer: <br />"+"<table id="+Char:C90(34)+"myTable1"+Char:C90(34)+" class="+Char:C90(34)+"tableStandard tablesorter"+Char:C90(34)+">"+"\r"+"  <tr>"+"\r"+"    <td class="+Char:C90(34)+"tdLabel"+Char:C90(34)+">Company</td><td  id="+Char:C90(34)+"Company"+Char:C90(34)+">_jit_2_2jj</td>"+"\r"+"  </tr>"+"\r"+"  <tr>"+"\r"+"    <td class="+Char:C90(34)+"tdLabel"+Char:C90(34)+">Address1</td><td  id="+Char:C90(34)+"Address1"+Char:C90(34)+">_jit_2_4jj</td>"+"\r"+"  </tr>"+"\r"+"  <tr>"+"\r"+"    <td class="+Char:C90(34)+"tdLabel"+Char:C90(34)+">Address2</td><td  id="+Char:C90(34)+"Address2"+Char:C90(34)+">_jit_2_5jj</td>"+"\r"+"  </tr>"+"\r"+"  <tr>"+"\r"+"    <td class="+Char:C90(34)+"tdLabel"+Char:C90(34)+">City</td><td  id="+Char:C90(34)+"City"+Char:C90(34)+">_jit_2_6jj, _jit_2_7jj  _jit_2_8jj</td>"+"\r"+"  </tr>"+"\r"+"  <tr>"+"\r"+"    <td class="+Char:C90(34)+"tdLabel"+Char:C90(34)+">Phone</td><td  id="+Char:C90(34)+"Phone"+Char:C90(34)+">_jit_2_13_fonejj</td>"+"\r"+"  </tr>"+"\r"+"  <tr>"+"\r"+"    <td class="+Char:C90(34)+"tdLabel"+Char:C90(34)+">Email</td><td  id="+Char:C90(34)+"Email"+Char:C90(34)+">_jit_2_81jj</td>"+"\r"+"  </tr>"+"\r"+"</table>"
				[TallyMaster:60]template:29:="Retailer: _jit_2_2jj: _jit_2_13_fonejj: Zip: _jit_2_8jj"
				[TallyMaster:60]profileName1:13:="Data Template"
				[TallyMaster:60]profileName2:14:="Data varialbe"
				[TallyMaster:60]profileName3:15:="Tag Template"
				
				[TallyMaster:60]profile1:23:="<>vAllyhtmlTemplate"
				[TallyMaster:60]profile2:24:="_jit_0_vAllyDatajj"
				[TallyMaster:60]profile3:35:="[EventLog]AllyTag"
				SAVE RECORD:C53([TallyMaster:60])
			End if 
			If (Records in selection:C76([TallyMaster:60])>1)
				<>vAllyhtmlTemplate:="Multiple Templates: "+"\r"
				REDUCE SELECTION:C351([TallyMaster:60]; 1)
				LOAD RECORD:C52([TallyMaster:60])
			End if 
			<>vAllyhtmlTemplate:=<>vAllyhtmlTemplate+[TallyMaster:60]build:6  // <>vAllyhtmlTemplate will be empty unless multiple records.
			<>AllyTagTemplate:=[TallyMaster:60]template:29
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
			
			
			// Modified by: Bill James (2015-12-18T00:00:00 Simplified)
			WC_MfgArrays
			
			//  This creates an array of commands that can override 
			ARRAY LONGINT:C221(<>aWebOverrideSecure; 0)
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="WebCommandOverRide"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)
			ARRAY TEXT:C222(<>aWebCommandOverRide; 0)
			ARRAY TEXT:C222(<>aWebCommandScript; 0)
			SELECTION TO ARRAY:C260([TallyMaster:60]name:8; <>aWebCommandOverRide; [TallyMaster:60]script:9; <>aWebCommandScript; [TallyMaster:60]publish:25; <>aWebOverrideSecure)
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
			
			
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="WebCommandAlias"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0)
			ARRAY TEXT:C222(<>aWebCommandAlias; 0)
			ARRAY TEXT:C222(<>aWebCommandAliasPreScript; 0)
			ARRAY TEXT:C222(<>aWebCommandReal; 0)
			SELECTION TO ARRAY:C260([TallyMaster:60]name:8; <>aWebCommandAlias; [TallyMaster:60]script:9; <>aWebCommandAliasPreScript; [TallyMaster:60]alphaKey:26; <>aWebCommandReal)
			REDUCE SELECTION:C351([TallyMaster:60]; 0)
		End if 
	End if 
End if   // missing last seperator

$0:=$vbLaunch