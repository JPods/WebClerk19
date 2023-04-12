//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/13/21, 20:14:35
// ----------------------------------------------------
// Method: WCapi_Docs
// Description
// 
// Parameters
// ----------------------------------------------------



vResponse:="Error: WCapi_Docs defined"


If (False:C215)
	
	
	$vtPath:=Storage:C1525.wc.webFolder+"images"+Folder separator:K24:12+"noimage.jpg"
	$tableName:=WCapi_GetParameter("Table"; "")
	$vtUUIDKey:=WCapi_GetParameter("id"; "")
	$vtThumbnail:=WCapi_GetParameter("Thumbnail"; "")
	C_POINTER:C301($ptTable; $ptUUIDKey)
	C_LONGINT:C283($viTableNum)
	$ptTable:=STR_GetTablePointer($tableName)
	If (Not:C34(Is nil pointer:C315($ptTable)))
		$viTableNum:=Table:C252($ptTable)
		$ptUUIDKey:=STR_GetFieldPointer($tableName; "id")
		
		// Sometimes it seems not to dereference the pointer
		QUERY:C277($ptTable->; $ptUUIDKey->=$vtUUIDKey)
		
		If (Records in selection:C76($ptTable->)=1)
			$vtPath:=PathOrTN($tableName; $vtThumbnail)
			If ($vtPath="")
				$vtPath:=Storage:C1525.wc.webFolder+"images"+Folder separator:K24:12+"ImagePathEmpty.jpg"
				If (<>viDebugMode>410)
					If (Test path name:C476($vtPath)#1)
						ConsoleLog("Critical image missing: "+$vtPath)
						$vtPath:=""
					End if 
				End if 
			Else 
				$vtPath:=PathToSystem($vtPath)
				If (Test path name:C476($vtPath)#1)
					ConsoleLog("Invalid Path: "+$vtPath)
					$vtPath:=Storage:C1525.wc.webFolder+"images"+Folder separator:K24:12+"ImagePathInvalid.jpg"
				End if 
			End if 
			
		End if 
		C_TEXT:C284($contentType)
	End if 
	// ### bj ### 20200111_1822
	// add the ability to forward to another server to send the image.
	
	If (Test path name:C476($vtPath)=1)
		WC_SendServerResponsePath($vtPath)
	Else 
		ConsoleLog("Error-Path: WCapi_Docs"+$vtPath)
		vResponse:="Error: pages served only thru vue.js vResponse: "+vResponse
		WC_voStateError("Error: path: "+$vtPath)
		WC_SendServerResponse(vResponse)
	End if 
	
	$vbSendConsole:=False:C215
	vMimeType:="AlreadySent"
End if 