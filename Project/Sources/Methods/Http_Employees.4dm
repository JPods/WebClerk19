//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/05/09, 01:12:33
// ----------------------------------------------------
// Method: Http_Employees
// Description
// 
//
// Parameters
// ----------------------------------------------------

//
READ ONLY:C145([Employee:19])
C_LONGINT:C283($w; $h; $t; $1; $thisLibrary)
C_TEXT:C284($cat; $ser; $val)
C_POINTER:C301($2)
$recNum:=WCapi_GetParameter("RecordID"; "")
//If ($recNum="")
//$recNum:=WCapi_GetParameter("RecNum";"")
//End if 
//$subject:=WCapi_GetParameter("subject";"")
$keyword:=WCapi_GetParameter("Keyword"; "")
//$who:=WCapi_GetParameter("who";"")
//$topic:=WCapi_GetParameter("topic";"")
//$name:=WCapi_GetParameter("name";"")
//$purpose:=WCapi_GetParameter("purpose";"")
//$dateBegin:=WCapi_GetParameter("dateBegin";"")
//$dateEnd:=WCapi_GetParameter("dateEnd";"")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
//$jitPageSrch:=WCapi_GetParameter("jitPageSrch";"")
//
If ($recNum#"")
	GOTO RECORD:C242([Employee:19]; Num:C11($recNum))
	If (([Employee:19]publish:39=0) | ([Employee:19]publish:39>viEndUserSecurityLevel))
		REDUCE SELECTION:C351([Employee:19]; 0)
	End if 
Else 
	QUERY:C277([Employee:19]; [Employee:19]publish:39>0; *)
	QUERY:C277([Employee:19];  & [Employee:19]publish:39<=viEndUserSecurityLevel; *)
	If ($keyword#"")
		QUERY:C277([Employee:19]; [Employee:19]KeyText:40=$keyword; *)
	End if 
	QUERY:C277([Employee:19])
End if 
$num:=Records in selection:C76([Employee:19])
If (Records in selection:C76([Employee:19])><>viMaxShow)
	REDUCE SELECTION:C351([Employee:19]; <>viMaxShow)
	$num:=Records in selection:C76([Employee:19])
End if 
If (Records in selection:C76([Employee:19])>1)
	ORDER BY:C49([Employee:19]; [Employee:19]nameLast:2)
End if 
//
C_TEXT:C284($doPage)
$suffix:=""
$insert:=[Employee:19]webPage:43
Case of 
	: ($num>1)
		$doPage:=WC_DoPage("EmployeesList.html"; $jitPageList)
		$err:=WC_PageSendWithTags($1; $doPage; 0)
	: ($num=1)
		$doPage:=WC_DoPage("EmployeesOne"+$insert+".html"; $jitPageOne)
		$err:=WC_PageSendWithTags($1; $doPage; 0)
	Else 
		vResponse:="No Employees found"
		$err:=WC_PageSendWithTags($1; WC_DoPage("Error.html"; ""); 0)
End case 
REDUCE SELECTION:C351([Employee:19]; 0)
READ WRITE:C146([Employee:19])