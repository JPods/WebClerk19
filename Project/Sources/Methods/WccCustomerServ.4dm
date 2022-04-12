//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-02-10T00:00:00, 23:48:54
// ----------------------------------------------------
// Method: WccCustomerServ
// Description
// Modified: 02/10/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1)
C_POINTER:C301($2)
//    
vResponse:="Table is not available."
//
C_TEXT:C284($doPage; $tableName; $jitPageList; $jitPageOne)
// ### bj ### 20200309_2208 fix error
$doPage:="Error.html"
$tableName:=WCapi_GetParameter("TableName"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
Case of 
	: (voState.url="/WCC_CustomerFill@")
		$doPage:=Wcc_CustomerFill
	: (voState.url="/WCC_CustomerReceivable@")
		QUERY:C277([Customer:2]; [Customer:2]balanceDue:42#0)
		ORDER BY:C49([Customer:2]; [Customer:2]balPastPeriod3:45; <; [Customer:2]balPastPeriod2:44; <; [Customer:2]balPastPeriod1:43; <)
		$doPage:=WC_DoPage("WccL"+$tableName+".html"; $jitPageList)
	: (voState.url="/WCC_CustomerReceivable@")
		QUERY:C277([Customer:2]; [Customer:2]balanceDue:42#0)
		ORDER BY:C49([Customer:2]; [Customer:2]balPastPeriod3:45; <; [Customer:2]balPastPeriod2:44; <; [Customer:2]balPastPeriod1:43; <)
		$doPage:=WC_DoPage("WccL"+$tableName+".html"; $jitPageList)
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)
//