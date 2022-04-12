//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: WccNewRecordEmptyForm
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//

C_LONGINT:C283($1)
C_POINTER:C301($2)
//
vResponse:="Table is not available."

//
C_LONGINT:C283($tableNum; $fieldNum; $relatedtableNum)

Wcc_ReduceSelection
WC_VariablesRead
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")  //look for a missing quote if page does cannot be found
$pageDo:=WC_DoPage("Error.html"; $jitPageOne)
$err:=WC_PageSendWithTags($1; $pageDo; 0)