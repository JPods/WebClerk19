//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 08/18/15, 10:44:55
// ----------------------------------------------------
// Method: Http_SearchPO
// Description
// voState.url="/Search_PO@"
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
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
If (Record number:C243([Vendor:38])>-1)
	$orderNum:=Num:C11(WCapi_GetParameter("PONum"; ""))
	If ($orderNum>0)
		QUERY:C277([PO:39]; [PO:39]poNum:5=$orderNum; *)
		QUERY:C277([PO:39];  & [PO:39]vendorID:1=[Vendor:38]vendorID:1)
		If (Records in selection:C76([PO:39])=1)
			QUERY:C277([POLine:40]; [POLine:40]poNum:1=[PO:39]poNum:5)
			$doPage:=WC_DoPage("POsOne"+$suffix+".html"; "")
		Else 
			vResponse:="No valid PO by you for "+String:C10($orderNum)
		End if 
	Else 
		vResponse:="You must submit a valid PO Number."
	End if 
Else 
	vResponse:=vResponse+"Must be a vendor to check PO status, remote user relates to :"+Table name:C256([EventLog:75]tableNum:9)+"\r"
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
