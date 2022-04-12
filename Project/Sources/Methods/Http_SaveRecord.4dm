//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/29/08, 19:01:39
// ----------------------------------------------------
// Method: Http_SaveRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($2)
C_LONGINT:C283($1; $p; $theFile; $theField; $testFile; $pEnd; <>wcbCustomerMods)
C_TEXT:C284(<>UnixExclaim; <>UnixSemi)
C_TEXT:C284($startStr; $endStr)
C_BOOLEAN:C305($postToWeb; $3)
$postToWeb:=$3

C_TEXT:C284($doPage)

ARRAY TEXT:C222($aAllowedTables; 15)
$aAllowedTables{1}:="Customer"
$aAllowedTables{2}:="Proposal"
$aAllowedTables{3}:="CallReport"
$aAllowedTables{4}:="ServiceRecord"
$aAllowedTables{5}:="Contact"
$aAllowedTables{6}:="Document"
$aAllowedTables{7}:="CommunicationDevice"
$aAllowedTables{8}:="LoadItems"
$aAllowedTables{9}:="LoadTag"
$aAllowedTables{10}:="Payment"
$aAllowedTables{11}:="Service"
$aAllowedTables{12}:="WorkOrderEvents"
$aAllowedTables{13}:="QACustomer"
$aAllowedTables{14}:="ItemSerial"
$aAllowedTables{15}:="ItemSerialAction"

$suffix:=""
$jitPageError:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150916_1059
$doPage:=WC_DoPage("Error.html"; $jitPageError)  // ### jwm ### 20150916_1104
// vResponse:="Table name not correctly stated."
$tableName:=WCapi_GetParameter("TableName"; "")
If ($tableName="")  // ### jwm ### 20150916_1106
	vResponse:=vResponse+"Error: Missing TableName"
End if 
$recordStr:=WCapi_GetParameter("RecordNum"; "")
If ($recordStr="")  // ### jwm ### 20150916_1106
	vResponse:=vResponse+"Error: Missing RecordNum"
End if 
$tableNum:=STR_GetTableNumber($tableName)
$fia:=Find in array:C230($aAllowedTables; $tableName)
If ($fia=-1)  // ### jwm ### 20150916_1106
	vResponse:=vResponse+"Error: Unauthorized TableName "+$tableName
End if 
If ($fia>0)
	If ($tableNum>0)
		If (Num:C11($recordStr)>-1)
			GOTO RECORD:C242(Table:C252($tableNum)->; Num:C11($recordStr))
			$tableName:=Http_UniqueIDMatch($tableName)
		Else 
			CREATE RECORD:C68(Table:C252($tableNum)->)
		End if 
		$tableNum:=STR_GetTableNumber($tableName)
		If ($tableNum>0)
			$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
			$doPage:=WC_DoPage($tableName+"One.html"; $jitPageOne)
			WC_Parse($tableNum; $2)
			If (False:C215)
				Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
				Tt_FindByZip(->[Customer:2]zip:8; ->[Customer:2]salesNameID:59; ->[Customer:2]repID:58)
				Zip_LoadCitySt_New(->[Customer:2]zip:8; ->[Customer:2]city:6; ->[Customer:2]state:7; False:C215)
				ParsePhone([Customer:2]phone:13; ->[Customer:2]phone:13; <>tcLocalArea)
				ParsePhone([Customer:2]fax:66; ->[Customer:2]fax:66; <>tcLocalArea)
				SAVE RECORD:C53([Customer:2])
			End if 
		Else 
			vResponse:="Must be signed in as a customer the change your record."
		End if 
	End if 
End if 
If ($postToWeb)
	$err:=WC_PageSendWithTags($1; $doPage; 0)
End if 