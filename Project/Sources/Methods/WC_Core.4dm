//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/06/08, 18:33:32
// ----------------------------------------------------
// Method: WC_Core
// Description
// 
// $1, $socket
// ----------------------------------------------------
// ### jwm ### 20171005_1700 moved debug 411 from WC_Core to WC_PageDocOut

C_LONGINT:C283($1; $socket)
$socket:=voState.socket
C_LONGINT:C283($hangTime)
$hangTime:=Tickcount:C458  // check at the end for processing time

If (Macintosh control down:C544)
	TRACE:C157
End if 
Case of 
	: (voState.url="/WCapi/Admin/@")  // must be first
		WC_AdminServer
	: (voState.url="/WCapi/@")
		WC_apiServer
	: (voState.url="@CommerceExpert@")
		WC_SendServerResponsePath(voState.url)
	: (voState.url="/ajax/@")
		WC_ajaxServer($socket)
	: (voState.url="/WCapi/user/@")
		WC_UserServer($socket)  // StateEnforceBeef
	: (voState.url="/Bots/@")
		WC_BotServer($socket)
	: ((voState.url="/RP/@") | (voState.url="/RP_@"))
		WC_ServerRP($socket)
	Else 
		
		
		// MustFixQQQZZZ: Bill James (2021-12-07T06:00:00Z)
		// harvest anything valuable out of these and delete them.
		
		
		Case of 
			: ($overrideScript#"")  // WebCommandOverRide
				ExecuteText(0; $overrideScript)  //
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")  // #### AZM #### 20171102 // STANDARDIZE
				$thePage:=WC_DoPage($jitPageOne; "")
				$err:=WC_PageSendWithTags($socket; $thePage; 0)
			: (voState.url#"")
				Case of   // check if t his URL must be processed (cgi-like) or if it is a real file  
					: (voState.url="/heart_beat")  //  | (voState.url="/heartbeat"))
						SET BLOB SIZE:C606(vblWCResponse; 0)
						$myMessage:="Heart_beat reply from: "+Storage:C1525.default.company+", Version: "+Storage:C1525.version.rev
						TEXT TO BLOB:C554($myMessage; vblWCResponse; UTF8 text without length:K22:17; *)
						Http_SendWWWHd($socket; "text/html"; BLOB size:C605(vblWCResponse))
						WC_SendBody($socket; ->vblWCResponse)
						
					: (voState.url="/item_@")  //list the found items
						Http_ServerItems($socket; ->vText11; 0)
					: (voState.url="/Sign_Off@")  // replace in /User?
						WccResetUser($socket; ->vText11)
					: (voState.url="/Lead_Add@")  //new Lead
						Http_PostLead($socket; ->vText11)
					: (voState.url="/search_@")  //get /user
						Http_serverSearch($socket; ->vText11)
					: (voState.url="/Status_@")  //
						Http_serverStatus($socket; ->vText11)
					: (voState.url="/Show_User@")  //get /user
						Http_ShowUser($socket; ->vText11)
					: (voState.url="/Register_@")
						http_Register($socket; ->vText11)  // must not use this here     
					: (voState.url="/Password_@")
						http_Password($socket; ->vText11)  // must not use this here  
						//
					: ((voState.url="/Order_@") | (voState.url="/check_@") | (voState.url="/Update_items@"))  //GoCheck out    |
						Http_serverOrd($socket; ->vText11; 0)
						//
					: ((voState.url="/pay_@") | (voState.url="/CCpay_@"))  //pay the order
						//http_PayOrder ($socket;->vText11)
						Http_ServerPay($socket; ->vText11; 0)
						//
					: (voState.url="/Nav_@")  //post Proposal
						Http_NavServer($socket; ->vText11)
						//
					: (voState.url="/Proposal_Send@")  //post Proposal
						Http_PpNew($socket; ->vText11)
						//
					: ((voState.url="/jit_Custom@") | (voState.url="/jit_Script@") | (voState.url="/jit_webScript@"))  //add items to order, 
						http_Custom($socket; ->vText11; 0)
						//            
					: (voState.url="/Forum_@")
						Http_ServerForu($socket; ->vText11)
						//
					: (voState.url="/Service_@")  //service              
						Http_ServerService($socket; ->vText11)
						//
					: (voState.url="/Flex_@")
						Http_ServerFlex
						//              
					: (voState.url="/Sales_@")  //Sales features older
						Http_ServerSale($socket; ->vText11)
						//
					: (voState.url="/WCC_MyPage@")
						Http_MyPage($socket; ->vText11)
						//
					: (voState.url="/WCC_@")
						WccSERVER($socket; ->vText11)
						//
					: (voState.url="/CWS_@")
						CWSCommunityServer($socket; ->vText11)
						//
					: (voState.url="/LWC_@")
						LWCServer($socket; ->vText11)
						//
					: (voState.url="/Mfr_@")
						MfrServer($socket; ->vText11)
						//
					: (voState.url="/Reservation_@")
						Http_ServerReservation($socket; ->vText11)
						//
					: (voState.url="/FAQ_List@")
						Http_SrchFAQ($socket; ->vText11)
						//
					: (voState.url="/Tech_List@")
						http_srchTech($socket; ->vText11)
						//
					: (voState.url="/Library_@")
						Http_SrchLibraries($socket; ->vText11)
						//
					: (voState.url="/Dealer_List@")
						Http_DealLocate($socket; ->vText11)
						//   
					: (voState.url="/Admin_@")
						Http_ServerAdmin($socket; ->vText11)
						//   
					: (voState.url="/eMail_Form@")
						Http_eMailForm($socket; ->vText11)
						//
					: (voState.url="/B2B_@")
						B2B_Server($socket; ->vText11)
						//
						//: (vWCDocumentURI="Calendar_@")//Utilities
						//CalendarServer ($socket;->vText11)
						//
					: (voState.url="/Do_Last@")  //new Lead
						Http_DoLast($socket; ->vText11)
						//
						//
					: (voState.url="/first@")  //Milgaard procedures
						$doPage:=WC_DoPage("Comment.html"; "")
						$err:=WC_PageSendWithTags($socket; $doPage; 0)
						
					Else 
						WC_SendServerResponsePath(voState.url)
						// WC_PageDocOut($socket)
				End case 
			Else 
				WC_SendServerResponsePath(voState.url)
				// WC_PageDocOut($socket)
		End case 
End case 
//

vText11:=""
iloText11:=""
Wcc_ReduceSelection

