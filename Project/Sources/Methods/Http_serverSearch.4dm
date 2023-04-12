//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/05/13, 15:24:33
// ----------------------------------------------------
// Method: Http_serverSearch
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $socket; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse; $pagePath)
C_POINTER:C301($2)
$socket:=voState.socket
$suffix:=""
$doThis:=0
vResponse:=""
$thePage:=""
//SET TEXT TO CLIPBOARD(vText11)
//TRACE
//zttp_UserGet 
Case of 
	: (voState.url="/Search_QueryField@")  //pay the order
		// ### bj ### 20181229_1627 test this for holes. Should be restriced by id
		$tableNum:=WccQuery3Fields
		If ($tableNum>0)
			$tableName:=WCapi_GetParameter("tableName"; "")
			$tableName:=Table name:C256($tableNum)
			$recCount:=Records in selection:C76(Table:C252($tableNum)->)
			If ($recCount=1)
				pvRecordNum:=Record number:C243(Table:C252($tableNum)->)
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageOne)
			Else 
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("Wcc"+$tableName+"One.html"; $jitPageList)
			End if 
		End if 
		$err:=WC_PageSendWithTags($1; $doPage; 0)
		
	: (voState.url="/Search_Custom@")
		//HTTP_Query($socket; ->vText11)
		
	: (voState.url="/Search_Table@")
		//Http_SrchGeneral($socket; ->vText11)
		
	: (voState.url="/Search_Source@")  //
		//Http_SrchGeneral($socket; ->vText11)
	: (voState.url="/Search_PO@")  //get /user
		Http_SearchPO($socket; $2)
		//: (voState.url="/Search_Password@")
		//  HTTP_passwordForget ($socket;->vText11)
	: (voState.url="/Search_ChangePass@")
		//HTTP_PasswordChange ($socket;->vText11)  removed this
		// ### bj ### 20181229_2122  changed the process to email based confirm
		voState.url:="Password_Reset"
		http_Password($socket; ->vText11)
		
	: (voState.url="/Search_OptOut@")
		Http_OptOut($socket; ->vText11)
	: (voState.url="/Search_SignInAs@")  //get /user
		Http_SignInAs($socket; ->vText11)
	: (voState.url="/Search_QAAnswers@")  //get /user    
		
		
	: (voState.url="/Search_Zip@")  //get /user
		Http_ItemByZip($1; $2)
		//WccReports ($1;$2)
		///user
		//HTTP_SearchQA ($socket;->vText11)
	Else 
		vResponse:="Improper Search request."
		$err:=WC_PageSendWithTags($socket; WC_DoPage("Error.html"; ""); 0)
End case 