//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-18T00:00:00, 00:18:31
// ----------------------------------------------------
// Method: Http_OrderAllyAssign
// Description
// Modified: 12/18/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $err; $orderNum; $k)
C_POINTER:C301($2)
$suffix:=""
$doThis:=0
vResponse:=""
//zttp_UserGet 
C_TEXT:C284($doPage)
$suffix:=""
vResponse:="No matching record(s)."
$doPage:=WC_DoPage("Error.html"; "")

//Case of 
//: (voState.url="/Order_AllyAssign@")  //clone cross of last three orders

$allyID:=WCapi_GetParameter("AllyID"; "")
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
If ($allyID#"")
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=$allyID)
	
	If (Records in selection:C76([Customer:2])=1)
		[EventLog:75]allyid:49:=[Customer:2]customerID:1
		//  _jit_75_45jj  
		[EventLog:75]allyTag:51:=TagsToText(<>AllyTagTemplate)
		//  _jit_75_51jj  
		If ([EventLog:75]idNum:5#0)
			SAVE RECORD:C53([EventLog:75])
		End if 
		REDUCE SELECTION:C351([Customer:2]; 0)
		$doPage:=WC_DoPage("AllyOne.html"; $jitPageOne)
		If ($jitPageOne="AllyOne.html")  // only fill out the template if the AllyOne.html Page is called
			AllyFillTemplate(1)  //   _jit_0_vAllyDatajj
		End if 
	Else 
		$doPage:=WC_DoPage("AllyOne.html"; $jitPageOne)
	End if 
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
