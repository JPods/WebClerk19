//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/04/09, 18:01:57
// ----------------------------------------------------
// Method: WarrantyIssue
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel; $webResponse; $doRemoteUser)
C_POINTER:C301($2)

C_TEXT:C284($pathItem; $pubType; $pathTemplate)
ARRAY TEXT:C222(aTmpText1; 1)
vResponse:="No matching Warranty System"
$doPage:=WC_DoPage("Error.html"; "")
C_LONGINT:C283($num)
C_TEXT:C284($recID; $itemNum; $jitPageOne)
$sendPage:=True:C214
Case of 
	: (voState.url="/Item_WarrantyEndUser@")
		
	: (voState.url="/Item_WarrantyAction@")
		$sendPage:=True:C214
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		If ((Record number:C243([Customer:2])<0) & (Record number:C243([Contact:13])<0))
			vResponse:="Submit email."
			$doPage:=WC_DoPage("ItemWarrantyRequestEmail.html"; $jitPageOne)
		Else 
			REDUCE SELECTION:C351([ItemSerial:47]; 0)
			vResponse:="Complete form."
			$doPage:=WC_DoPage("ItemWarrantyRequestDirect.html"; $jitPageOne)
		End if 
	: (voState.url="/Item_WarrantySignOffContact@")
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		REDUCE SELECTION:C351([Customer:2]; 0)
		REDUCE SELECTION:C351([ItemSerial:47]; 0)
		vResponse:="Complete form."
		$doPage:=WC_DoPage("ItemWarrantyRequestDirect.html"; $jitPageOne)
	: (voState.url="/Item_WarrantyClearStore@")
		[Contact:13]customerID:1:=""
		SAVE RECORD:C53([Contact:13])
		REDUCE SELECTION:C351([Customer:2]; 0)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		vResponse:="Complete form."
		$doPage:=WC_DoPage("ItemWarrantyRequestDirect.html"; $jitPageOne)
		
	: (voState.url="/Item_WarrantyEmail@")
		RegisterViaEmail($1; $2)
		$doPage:=WC_DoPage("Comment.html"; "ItemWarrantyCheckEmail.html")
	: (voState.url="/Item_WarrantyRequest@")
		$userEmailSrch:=WCapi_GetParameter("email"; "")
		vtEmailReceiver:=$userEmailSrch
		$userEmailSrch:=$userEmailSrch
		If ($userEmailSrch="")
			vResponse:="No email address in link."
			$doPage:=WC_DoPage("Comment.html"; $jitPageOne)
		Else 
			QUERY:C277([RemoteUser:57]; [RemoteUser:57]email:14=$userEmailSrch)
			QUERY:C277([Contact:13]; [Contact:13]email:35=$userEmailSrch)
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			If ($jitPageOne="")
				$jitPageOne:="ItemWarrantyRequestDirect.html"
			End if 
			If (Records in selection:C76([RemoteUser:57])=1)
				//If (Record number([RemoteUser])>-1)
				//333Http_UserGet 
				//End if 
				vResponse:="Your email address is already registered.  Your password has been emailed to you."
				HTTP_passwordForget($1; ->vText11)
				$sendPage:=False:C215
			Else 
				$doPage:=WC_DoPage("Comment.html"; $jitPageOne)
			End if 
		End if 
	: (voState.url="/Item_WarrantyIssue@")
		////$recID:=WCapi_GetParameter("RecordNum";"")
		$itemNum:=WCapi_GetParameter("_jit_47_1jj"; "")
		If ($itemNum="")
			$itemNum:=WCapi_GetParameter("itemNum"; "")
		End if 
		
		If ($itemNum="")
			$doPage:=WC_DoPage("Error.html"; $jitPageOne)
			vResponse:="Not ItemNum Defined"
		Else 
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			C_LONGINT:C283($theContactUniqueID)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum; *)
			QUERY:C277([Item:4];  & [Item:4]retired:64=False:C215; *)
			QUERY:C277([Item:4];  & [Item:4]publish:60>0; *)
			QUERY:C277([Item:4];  & [Item:4]publish:60<=viEndUserSecurityLevel)
			$num:=Records in selection:C76([Item:4])
			
			//zzzFixThis after we know they are working
			If ($num=0)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
				$num:=Records in selection:C76([Item:4])
				If ($num=0)
					CREATE RECORD:C68([Item:4])
					[Item:4]dateCreated:129:=Current date:C33  // AZM 2019-09-05 .... FILL IN DateCreated WHEN THE RECORD IS CREATED
					[Item:4]itemNum:1:=$itemNum
					[Item:4]description:7:="Force to create, "+$itemNum
				End if 
				//[Item]Retired:=False
				ChangeCurItemLifecycleStatus("Active")  // AZM 2019-09-05 .... USE THE HELPER METHOD TO MAKE SURE ALL DATES GET UPDATED AS WELL
				[Item:4]publish:60:=1
				SAVE RECORD:C53([Item:4])
			End if 
			customerIDRetailer:=WCapi_GetParameter("customerIDRetailer"; "")
			customerIDEnduser:=WCapi_GetParameter("customerIDEnduser"; "")
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=customerIDEnduser)
			CREATE RECORD:C68([ItemSerial:47])
			[ItemSerial:47]customerID:9:=[Customer:2]customerID:1
			[ItemSerial:47]customerName:43:=[Customer:2]company:2
			// [ItemSerial]contactID:=[Contact]UniqueID
			[ItemSerial:47]itemNum:1:=[Item:4]itemNum:1
			[ItemSerial:47]description:2:=[Item:4]description:7
			[ItemSerial:47]emailCustomer:32:=[Customer:2]email:81
			[ItemSerial:47]dateDocument:13:=Current date:C33
			[ItemSerial:47]dateReceived:12:=Current date:C33
			[ItemSerial:47]warrantyDays:20:=[Item:4]warrantyDays:46
			If ([ItemSerial:47]warrantyDays:20=-1)
				[ItemSerial:47]dateWarrantyEnd:21:=[ItemSerial:47]dateDocument:13+21915
				variable10:="Lifetime"
			Else 
				[ItemSerial:47]dateWarrantyEnd:21:=[ItemSerial:47]dateDocument:13+[Item:4]warrantyDays:46
				variable10:=String:C10([ItemSerial:47]dateWarrantyEnd:21; Internal date short:K1:7)
			End if 
			[ItemSerial:47]addressText2:47:=[Customer:2]address1:4+"\r"+[Customer:2]address2:5+"\r"+[Customer:2]city:6+", "+[Customer:2]state:7+"  "+[Customer:2]zip:8
			[ItemSerial:47]contactName:45:=[Customer:2]nameLast:23+", "+[Customer:2]nameFirst:73
			[ItemSerial:47]emailContact:49:=[Customer:2]email:81
			[ItemSerial:47]phoneContact:51:=[Customer:2]phone:13
			[ItemSerial:47]profile5:37:=[Customer:2]adSource:62
			
			[ItemSerial:47]serialNum:4:=[Item:4]itemNum:1+"_"+String:C10([ItemSerial:47]idNum:18)
			
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=customerIDRetailer)
			[ItemSerial:47]tableNum:59:=2
			[ItemSerial:47]vendorID:5:=[Customer:2]customerID:1
			[ItemSerial:47]vendorName:44:=[Customer:2]company:2
			[ItemSerial:47]phoneVendor:52:=[Customer:2]phone:13
			[ItemSerial:47]emailVendor:48:=[Customer:2]email:81
			[ItemSerial:47]invoiceNum:10:=-5  // yet to be billed
			
			SAVE RECORD:C53([ItemSerial:47])
			C_TEXT:C284($nameEmail)
			$nameEmail:=WCapi_GetParameter("sendemail"; "")
			If (($nameEmail#"") & ([ItemSerial:47]emailCustomer:32#""))
				vHere:=0
				vHere:=Num:C11(WCapi_GetParameter("vHere"; ""))
				C_TEXT:C284($vtScript)
				$vtScript:="QUERY([Customer];[Customer]customerID=\""+customerIDEnduser+"\")"+"\r"
				$vtScript:=$vtScript+"QUERY([UserReport];[UserReport]Name=\""+$nameEmail+"\")"+"\r"
				$vtScript:=$vtScript+"QUERY([ItemSerial];[ItemSerial]UniqueID="+String:C10([ItemSerial:47]idNum:18)+")"+"\r"
				vHere:=0
				vHere:=Num:C11(WCapi_GetParameter("vHere"; ""))
				$vtScript:=$vtScript+"vHere:="+String:C10(vHere)+"\r"
				
				If (False:C215)
					// ### bj ### 20191211_0031  document how to send emain in new process
					vHere:=0
					C_TEXT:C284($vtScript)
					$vtScript:="QUERY([Customer];[Customer]customerID=\"JPods\")"+"\r"
					$vtScript:=$vtScript+"QUERY([UserReport];[UserReport]Name=\"Test Email\")"+"\r"
					$vtScript:=$vtScript+"QUERY([ItemSerial];[ItemSerial]UniqueID="+String:C10(1306)+")"+"\r"
					vHere:=2  // needed
					//vHere:=Num(WCapi_GetParameter ("vHere";""))
					$vtScript:=$vtScript+"vHere:="+String:C10(2)+"\r"
					$vtScript:=$vtScript+"ptCurTable:=Table(2)"+"\r"  // this will be overwritten by the table defined in the UserReport
					
				End if 
				
				// ### bj ### 20191204_1451
				SMTP_Email($vtScript; "NewProcess")
				vHere:=0
			End if 
			$sendPage:=True:C214  // send at the bottom
			vResponse:=vResponse+", ItemSerials: "+String:C10([ItemSerial:47]idNum:18)
			//
			
			//
			
			$doPage:=WC_DoPage("Warranty04Print.html"; $jitPageOne)
			//Else 
			//$doPage:=WC_DoPage ("Error.html";"ItemWarrantyRequestDirect.html")
			//End if 
			//
			vResponse:=vResponse+", ItemSerials: "+String:C10([ItemSerial:47]idNum:18)
		End if 
		
		
	: (voState.url="/Item_WarrantyListStore@")
		//$userEmail:=WCapi_GetParameter("email";"")
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]customerID:9=[Customer:2]customerID:1; *)
		QUERY:C277([ItemSerial:47];  & [ItemSerial:47]dateWarrantyEnd:21<Current date:C33)
		ORDER BY:C49([ItemSerial:47]; [ItemSerial:47]dateWarrantyEnd:21)
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		If ($jitPageList="")
			$jitPageList:="ItemWarrantyList.html"
		End if 
		$doPage:=WC_DoPage("Error.html"; "ItemWarrantyList.html")
	: (voState.url="/Item_WarrantyService@")
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]customerID:9=[Customer:2]customerID:1; *)
		QUERY:C277([ItemSerial:47];  & [ItemSerial:47]dateWarrantyEnd:21<Current date:C33)
		
		
	: (voState.url="/Item_WarrantyStatusStore@")
		//$userEmail:=WCapi_GetParameter("email";"")
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]customerID:9=[Customer:2]customerID:1; *)
		ORDER BY:C49([ItemSerial:47]; [ItemSerial:47]dateReceived:12; <)
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		If ($jitPageList="")
			$jitPageList:="ItemWarrantyList.html"
		End if 
		$doPage:=WC_DoPage("Error.html"; "ItemWarrantyList.html")
		
	: (voState.url="/Item_WarrantyStatusUser@")
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]contactID:30=[Contact:13]idNum:28)
		ORDER BY:C49([ItemSerial:47]; [ItemSerial:47]dateReceived:12; <)
		
	: (voState.url="/Item_WarrantyRecord@")
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		C_LONGINT:C283($itemUniqueID)
		$itemUniqueID:=Num:C11(WCapi_GetParameter("RecordID"; ""))
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]idNum:18=$itemUniqueID; *)
		QUERY:C277([ItemSerial:47];  & [ItemSerial:47]contactID:30=[Contact:13]idNum:28)
		$doPage:=WC_DoPage("ItemWarrantyRecord.html"; $jitPageOne)
		$sendPage:=True:C214
	: (voState.url="/Item_WarrantyStatusExpired@")
		$userEmail:=WCapi_GetParameter("email"; "")
		
		
	: (False:C215)
		
		If (False:C215)
			If ($num#1)
				$doPage:=WC_DoPage("Error.html"; $jitPageOne)
				vResponse:="Not ItemNum found"
				
			Else 
				//SET TEXT TO CLIPBOARD(vText11)
				vResponse:=""
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				vText8:=""
				Item_GetSpec
				$jitDoContact:=WCapi_GetParameter("jitContact"; "")
				$userEmailSrch:=WCapi_GetParameter("userName"; "")
				If ($userEmailSrch="")
					$userEmailSrch:=WCapi_GetParameter("email"; "")
					If ($userEmailSrch="")
						$userEmailSrch:=WCapi_GetParameter("vtEmailReceiver"; "")
					End if 
				End if 
				vtEmailReceiver:=$userEmailSrch
				$userEmailSrch:=$userEmailSrch
				$password:=WCapi_GetParameter("password"; "")
				//
				
				
				//QUERY([Contact];[Contact]Email=$userEmailSrch)
				$saveSerial:=False:C215
				If (($jitDoContact="true") | ($jitDoContact="1") | ($jitDoContact="t@") | ($jitDoContact="1") | ($jitDoContact="1@"))
					//$theContactUniqueID:=Num(WCapi_GetParameter("_jit_13_28jj";""))
					//If ($theContactUniqueID<10)
					//$theContactUniqueID:=Num(WCapi_GetParameter("ContactUniqueID";""))
					//End if 
					//If ($theContactUniqueID#0)
					//QUERY([Contact];[Contact]UniqueID=$theContactUniqueID)
					If (Records in selection:C76([Contact:13])>0)
						FIRST RECORD:C50([Contact:13])
					Else 
						CREATE RECORD:C68([Contact:13])
					End if 
					$tableNum:=Table:C252(->[Contact:13])
					WC_Parse($tableNum; $2; True:C214)
					vResponse:=vResponse+" Contact Record: "+String:C10([Contact:13]idNum:28)
					SAVE RECORD:C53([Contact:13])
					C_TEXT:C284($userEmailSrch)
					$saveSerial:=True:C214
					
					QUERY:C277([RemoteUser:57]; [RemoteUser:57]email:14=$userEmailSrch)
					If (Records in selection:C76([RemoteUser:57])>0)
						RemoteUser_Create(->[Contact:13]; $userEmailSrch; $password; 1)
					End if 
					
				Else 
					vResponse:=vResponse+"jitContact = false"
				End if 
				
				$theValue:=WCapi_GetParameter("_jit_2_13jj"; "")
				If ($theValue#"")  //try to find a matching customer record for the store
					ParsePhone($theValue; ->vText1; <>tcLocalArea)
					QUERY:C277([Customer:2]; [Customer:2]phone:13=vText1)
					If (Records in selection:C76([Customer:2])=1)
						vResponse:=vResponse+" Contact Record: "+String:C10([Contact:13]idNum:28)
					Else 
						vResponse:=vResponse+" Contact Record: "+String:C10([Contact:13]idNum:28)+", No Customer phone found."
					End if 
				End if 
				
				If (False:C215)  //deactivate this. Do not create the customer record
					$jitDoCustomer:=WCapi_GetParameter("jitCustomer"; "")
					If (($jitDoCustomer="true") | ($jitDoCustomer="1") | ($jitDoCustomer="1"))
						$theCustomerUniqueID:=WCapi_GetParameter("_jit_2_1jj"; "")
						If ($theCustomerUniqueID="")
							$theCustomerUniqueID:=WCapi_GetParameter("customerID"; "")
						End if 
						If ($theContactUniqueID#0)
							QUERY:C277([Customer:2]; [Customer:2]customerID:1=$theCustomerUniqueID)
						Else 
							CREATE RECORD:C68([Customer:2])
						End if 
						$tableNum:=Table:C252(->[Customer:2])
						WC_Parse($tableNum; $2; True:C214)
						If (([Customer:2]nameLast:23#"") & ([Customer:2]phone:13#""))
							SAVE RECORD:C53([Customer:2])
							RemoteUser_Create(->[Customer:2]; [Customer:2]customerID:1; [Customer:2]zip:8+(Num:C11([Customer:2]zip:8="")*"admin"); 1)
							$saveSerial:=True:C214
						Else 
							$doLastPage:=True:C214
						End if 
						vResponse:=vResponse+", customerID = "+[Customer:2]customerID:1
					Else 
						vResponse:=vResponse+"jitCustomer = false"
					End if 
				End if 
				//
				CREATE RECORD:C68([ItemSerial:47])
				
				$tableNum:=Table:C252(->[ItemSerial:47])
				[ItemSerial:47]customerID:9:=[Customer:2]customerID:1
				[ItemSerial:47]contactID:30:=[Contact:13]idNum:28
				WC_Parse($tableNum; $2; True:C214)
				[ItemSerial:47]itemNum:1:=[Item:4]itemNum:1
				[ItemSerial:47]description:2:=[Item:4]description:7
				[ItemSerial:47]contactID:30:=[Contact:13]idNum:28
				[ItemSerial:47]emailCustomer:32:=$userEmail
				If ([ItemSerial:47]dateDocument:13=!00-00-00!)
					[ItemSerial:47]dateDocument:13:=Current date:C33
				End if 
				[ItemSerial:47]dateReceived:12:=Current date:C33
				[ItemSerial:47]warrantyDays:20:=[Item:4]warrantyDays:46
				[ItemSerial:47]dateWarrantyEnd:21:=[ItemSerial:47]dateDocument:13+[Item:4]warrantyDays:46
				[ItemSerial:47]invoiceNum:10:=-5
				[ItemSerial:47]addressText2:47:=[Contact:13]address1:6+"\r"+[Contact:13]address2:7+"\r"+[Contact:13]city:8+", "+[Contact:13]state:9+"  "+[Contact:13]zip:11
				[ItemSerial:47]contactName:45:=[Contact:13]nameLast:4+", "+[Contact:13]nameFirst:2
				[ItemSerial:47]emailContact:49:=[Contact:13]email:35
				[ItemSerial:47]phoneContact:51:=[Contact:13]phone:30
				[ItemSerial:47]profile5:37:=[Contact:13]adSource:44
				[ItemSerial:47]serialNum:4:="SR"+String:C10([ItemSerial:47]idNum:18)
				If ([ItemSerial:47]serialNum:4="SR0")
					[ItemSerial:47]serialNum:4:="Failed Warranty Number, call."
				End if 
				//If ($saveSerial)
				SAVE RECORD:C53([ItemSerial:47])
				$doPage:=WC_DoPage("ItemWarrantyRequestDirect.html"; $jitPageOne)
				//Else 
				//$doPage:=WC_DoPage ("Error.html";"ItemWarrantyRequestDirect.html")
				//End if 
				//
				vResponse:=vResponse+", ItemSerials: "+String:C10([ItemSerial:47]idNum:18)
			End if 
		End if 
		
End case 
If ($sendPage=True:C214)
	$err:=WC_PageSendWithTags($1; $doPage; 0)
End if 

vtEmailSubject:=""
vtEmailBody:=""
vtEmailPath:=""
vtEmailReceiver:=""
vtEmailSender:=""
vText4:=""



