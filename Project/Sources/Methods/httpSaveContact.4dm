//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/29/08, 15:49:00
// ----------------------------------------------------
// Method: httpSaveContact
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($2)
C_LONGINT:C283($1; $p; $theFile; $theField; $testFile; $pEnd; <>wcbCustomerMods)
C_TEXT:C284(<>UnixExclaim; <>UnixSemi)
C_TEXT:C284($startStr; $endStr)

C_TEXT:C284($doPage)
$suffix:=""
$doPage:=WC_DoPage("Error.html"; "")

If (([EventLog:75]tableNum:9=2) & ([EventLog:75]customerRecNum:8>-1) & (Record number:C243([Customer:2])>-1))
	$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
	$doPage:=WC_DoPage("CustomersOne"+[Customer:2]webPage:94+".html"; $jitPageOne)
	//C_TEXT($custID)
	//$custID:=[Customer]customerID
	WC_Parse(13; $2)
	//[Customer]customerID:=$custID
	//
	Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteid:106)
	Tt_FindByZip(->[Customer:2]zip:8; ->[Customer:2]salesNameID:59; ->[Customer:2]repID:58)
	Zip_LoadCitySt_New(->[Customer:2]zip:8; ->[Customer:2]city:6; ->[Customer:2]state:7; False:C215)
	ParsePhone([Customer:2]phone:13; ->[Customer:2]phone:13; <>tcLocalArea)
	ParsePhone([Customer:2]fax:66; ->[Customer:2]fax:66; <>tcLocalArea)
	SAVE RECORD:C53([Customer:2])
Else 
	vResponse:="Must be signed in as a customer the change your record."
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)