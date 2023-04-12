//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/15/21, 20:56:43
// ----------------------------------------------------
// Method: WCapiTask_GetDocPath
// Description
// 
//
// Parameters
// ----------------------------------------------------

// tableName=QACustomers&UUIDKeyjj=EA5E271B809C6B4C80AF8B5531982202&Thumbnail=true
$vtPath:=Storage:C1525.wc.webFolder+"images"+Folder separator:K24:12+"noimage.jpg"
$tableName:=WCapi_GetParameter("tableName"; "")
$vtUUIDKey:=WCapi_GetParameter("id"; "")
$vtThumbnail:=WCapi_GetParameter("Thumbnail"; "")
C_POINTER:C301($ptTable; $ptUUIDKey)
C_LONGINT:C283($viTableNum)
$ptTable:=STR_GetTablePointer($tableName)
If (Is nil pointer:C315($ptTable))
	vResponse:="Error: Invalid tableName: "+$tableName
Else 
	$viTableNum:=Table:C252($ptTable)
	$ptUUIDKey:=STR_GetFieldPointer($tableName; "id")
	// Sometimes it seems not to dereference the pointer
	QUERY:C277($ptTable->; $ptUUIDKey->=$vtUUIDKey)
	If (Records in selection:C76($ptTable->)#1)
		vResponse:="Error: Invalid id for tableName: "+$tableName+", "+$vtUUIDKey
	Else 
		$vtPath:=PathOrTN($tableName; $vtThumbnail)
		If ($vtPath="")
			$vtPath:=Storage:C1525.wc.webFolder+"images"+Folder separator:K24:12+"ImagePathEmpty.jpg"
			vResponse:="Error: No valid DocPath for tableName: "+$tableName+", "+$vtUUIDKey
		Else 
			$vtPath:=PathToSystem($vtPath)
			If (Test path name:C476($vtPath)=1)
				WC_SendServerResponsePath($vtPath)
			Else 
				ConsoleLog("Error-Path: WCapi_Docs"+$vtPath)
				vResponse:="Error: pages served only thru vue.js vResponse: "+vResponse
				WC_voStateError("Error: path: "+$vtPath)
				WC_SendServerResponse(vResponse)
			End if 
		End if 
	End if 
End if 

