//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Http_ServerService
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($1; $c; $doThis; $skipMore)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$skipMore:=1
$c:=$1
$suffix:=""
$doThis:=0
//zttp_UserGet 
C_TEXT:C284($jitPageList; $jitPageOne; $jitPageError; $serviceRecID)
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$serviceRecID:=WCapi_GetParameter("RecordID"; "")

//
C_BOOLEAN:C305($pageDo)
TRACE:C157
C_LONGINT:C283($testCnt; $DTitem)
$morePageAction:=True:C214
vResponse:="No Service Record matches"
TRACE:C157
Case of 
	: (voState.url="/Service_Public@")
		vURLQueryScript:=vURLQueryScript+"QUERY([Service];[Service]customerID="+Txt_Quoted("Public")+";*)"+"\r"
		vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]DTCompleted=0)"+"\r"
		ExecuteText(0; vURLQueryScript)
	: (voState.url="/Service_ItemNew@")
		If (($reference#"") & (vWccSecurity>0))
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$reference)
			If (Records in selection:C76([Item:4])=1)
				CREATE RECORD:C68([Service:6])
				WC_Parse(Table:C252(->[Service:6]); $2)
				If (Record number:C243([Service:6])>-1)
					[Service:6]reference:37:=[Item:4]itemNum:1
					[Service:6]actionCreatedBy:40:=[RemoteUser:57]customerID:10
					If ([Service:6]idNum:26=0)
						
					End if 
					SAVE RECORD:C53([Service:6])
				End if 
			Else 
				vResponse:="Not authorized"
			End if 
		End if 
	: (voState.url="/Service_Manage@")
		C_LONGINT:C283($uniqueID)
		$uniqueID:=Num:C11(WCapi_GetParameter("id"; ""))
		$initiatedBy:=WCapi_GetParameter("InitiatedBy"; "")
		$openService:=WCapi_GetParameter("Open"; "")
		$actionBy:=WCapi_GetParameter("ActionBy"; "")
		$customerID:=WCapi_GetParameter("customerID"; "")
		$repID:=WCapi_GetParameter("RepID"; "")
		$process:=WCapi_GetParameter("Process"; "")
		$attribute:=WCapi_GetParameter("Attribute"; "")
		$cause:=WCapi_GetParameter("Cause"; "")
		$action:=WCapi_GetParameter("Action"; "")
		$noteType:=WCapi_GetParameter("NoteType"; "")
		$reference:=WCapi_GetParameter("Reference"; "")
		$dateRangeAction:=WCapi_GetParameter("DateRangeAction"; "")  //"01/01/03;02/15/03"
		$dateComplete:=WCapi_GetParameter("DateRangeEnd"; "")  //"01/01/03;02/15/03"
		$ppNum:=WCapi_GetParameter("PpNum"; "")
		$soNum:=WCapi_GetParameter("SONum"; "")
		$jobNum:=WCapi_GetParameter("JobNum"; "")
		
		
		
		Case of 
			: (($uniqueID>10) & ($customerID#""))
				QUERY:C277([Service:6]; [Service:6]idNum:26=$uniqueID)
				If ((Records in selection:C76([Service:6])=1) & ($customerID=[Service:6]customerID:1))
					// let the record pass if the customer matches.
				Else 
					vResponse:="Service Record UniqueID does not match customerID"
					REDUCE SELECTION:C351([Service:6]; 0)
				End if 
			: (vWccSecurity<1)
				//QUERY([Service];[Service]Publish>0;*)
				//QUERY([Service];&[Service]Publish<=viEndUserSecurityLevel;*)
				vURLQueryScript:=vURLQueryScript+"QUERY([Service];[Service]Publish>0)"+"\r"
				vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Publish<="+String:C10(viEndUserSecurityLevel)+";*)"+"\r"
			Else 
				If (vWccSecurity<5000)  //in as an employee or rep
					//QUERY([Service];[Service]RepID=[RemoteUser]customerID;*)
					//QUERY([Service];|[Service]actionName=[RemoteUser]customerID;*)
					//QUERY([Service];|[Service]ActionCreatedBy=[RemoteUser]customerID;*)
					//QUERY([Service];&[Service]Publish>0;*)
					//QUERY([Service];&[Service]Publish<=vWccSecurity;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];[Service]RepID="+Txt_Quoted([RemoteUser:57]customerID:10)+";*)"+"\r"
					vURLQueryScript:=vURLQueryScript+"QUERY([Service]; | [Service]actionName="+Txt_Quoted([RemoteUser:57]customerID:10)+";*)"+"\r"
					vURLQueryScript:=vURLQueryScript+"QUERY([Service]; | [Service]ActionCreatedBy="+Txt_Quoted([RemoteUser:57]customerID:10)+";*)"+"\r"
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Publish>0)"+"\r"
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Publish<="+String:C10(vWccSecurity)+";*)"+"\r"
				Else   //see everything
					//QUERY([Service];[Service]Publish>-100;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];[Service]Publish>-100;*)"+"\r"
				End if 
				If ($customerID#"")
					//QUERY([Service];&[Service]customerID=$customerID;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]customerID="+Txt_Quoted($customerID)+";*)"+"\r"
				End if 
				If ($serviceRecID#"")
					//QUERY([Service];&[Service]UniqueID=Num($serviceRecID);*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]UniqueID="+$serviceRecID+";*)"+"\r"
				End if 
				If ($reference#"")
					//QUERY([Service];&[Service]Reference=$reference;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Reference="+Txt_Quoted($reference)+";*)"+"\r"
				End if 
				If ($initiatedBy#"")
					//QUERY([Service];&[Service]ActionCreatedBy=$initiatedBy;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]ActionCreatedBy="+Txt_Quoted($initiatedBy)+";*)"+"\r"
				End if 
				If ($actionBy#"")
					//QUERY([Service];&[Service]actionName=$actionBy;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]actionName="+Txt_Quoted($actionBy)+";*)"+"\r"
				End if 
				If ($repID#"")
					//QUERY([Service];&[Service]RepID=$repID;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]RepID="+Txt_Quoted($repID)+";*)"+"\r"
				End if 
				If ($process#"")
					//QUERY([Service];&[Service]Process=$process;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Process="+Txt_Quoted($process)+";*)"+"\r"
				End if 
				If ($attribute#"")
					//QUERY([Service];&[Service]Attribute=$attribute;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Attribute="+Txt_Quoted($attribute)+";*)"+"\r"
				End if 
				If ($cause#"")
					//QUERY([Service];&[Service]Cause=$cause;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Cause="+Txt_Quoted($cause)+";*)"+"\r"
				End if 
				If ($action#"")
					//QUERY([Service];&[Service]Action=$action;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Action="+Txt_Quoted($action)+";*)"+"\r"
				End if 
				If ($jobNum#"")
					//QUERY([Service];&[Service]JobNum=Num($jobNum);*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]JobNum="+$jobNum+";*)"+"\r"
				End if 
				If ($ppNum#"")
					//QUERY([Service];&[Service]PpNum=Num($ppNum);*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]PpNum="+$ppNum+";*)"+"\r"
				End if 
				If ($soNum#"")
					//QUERY([Service];&[Service]OrderNum=Num($soNum);*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]OrderNum="+$soNum+";*)"+"\r"
				End if 
				If ($dateComplete#"")
					$testCnt:=txtDateFrom($dateComplete; 1; 1; ->[Service:6]dtComplete:18)
				End if 
				If ($dateRangeAction#"")
					$testCnt:=txtDateFrom($dateRangeAction; 1; 1; ->[Service:6]dtAction:35)
				End if 
				//If ($dateEnd#"")
				//$testCnt:=txtDateFrom ($dateEnd;1;1;->[Service]DTAction)
				//End if 
				If ($openService="False")
					//QUERY([Service];&[Service]Completed=True;*)
					vURLQueryScript:=vURLQueryScript+"QUERY([Service];&[Service]Completed=true;*)"+"\r"
				End if 
				//QUERY([Service])
				vURLQueryScript:=vURLQueryScript+"QUERY([Service])"+"\r"
				[EventLog:75]lastQueryScript:31:=vURLQueryScript
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
				ExecuteText(0; vURLQueryScript)
		End case 
	: (voState.url="/Service_Add@")
		If ((Records in selection:C76([Customer:2])=1) | (Records in selection:C76([Employee:19])=1) | (Records in selection:C76([Rep:8])=1) | (Records in selection:C76([Vendor:38])=1))
			$morePageAction:=False:C215
			CREATE RECORD:C68([Service:6])
			WC_Parse(Table:C252(->[Service:6]); $2)
			If (Record number:C243([Service:6])>-1)
				[Service:6]customerID:1:=[Customer:2]customerID:1
				[Service:6]dtDocument:16:=DateTime_DTTo
				[Service:6]dtBegin:15:=[Service:6]dtDocument:16
				
				If ([Service:6]idNum:26=0)
					
				End if 
				SAVE RECORD:C53([Service:6])
			End if 
		Else 
			vResponse:="Must be signed is as a customer, vendor, employee or rep"
		End if 
	: (voState.url="/Service_Save@")
		QUERY:C277([Service:6]; [Service:6]idNum:26=Num:C11($serviceRecID))
		$doSave:=False:C215
		Case of 
			: ([Service:6]customerID:1=[Customer:2]customerID:1)
				$doSave:=True:C214
			: ([Service:6]customerID:1="public")
				$doSave:=True:C214
			: (([Service:6]actionBy:12=[RemoteUser:57]customerID:10) | ([Service:6]repID:2=[RemoteUser:57]customerID:10) | ([Service:6]actionCreatedBy:40=[RemoteUser:57]customerID:10))
				$doSave:=True:C214
		End case 
		If ((Records in selection:C76([Service:6])=1) & ($doSave))
			WC_Parse(Table:C252(->[Service:6]); $2)
			$doPage:="ServiceOne.html"
			$skipMore:=1
			vResponse:="Changes Posted"
		End if 
	Else 
		QUERY:C277([Service:6];  & [Service:6]idNum:26=-12346723; *)
End case 
Case of 
	: (Records in selection:C76([Service:6])=0)
		$doPage:="Error.html"
	: (Records in selection:C76([Service:6])=1)
		If ($jitPageOne="")
			$doPage:="ServiceOne.html"
		Else 
			$doPage:=$jitPageOne
		End if 
	: (Records in selection:C76([Service:6])>1)
		If ($jitPageList="")
			$doPage:="ServiceList.html"
		Else 
			$doPage:=$jitPageList
		End if 
End case 
$err:=WC_PageSendWithTags($1; WC_DoPage($doPage; ""); 0)