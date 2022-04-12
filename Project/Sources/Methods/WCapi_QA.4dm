//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/09/21, 11:09:42
// ----------------------------------------------------
// Method: WCapi_QA
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($vtURL)
voState.url:=Substring:C12(voState.url; 2)  // clip the leading /
voState.url:=Substring:C12(voState.url; Position:C15("/"; voState.url))  // clip to the next /
WCapi_SetParameter("tableName"; "QA")
Case of 
	: (voState.url="/Get")
		WCapiTask_GetRecordByUUIDKey
	: (voState.url="/Save@")
		WCapi_QASave
		
	: ((voState.url="/Doc@") | (voState.url="/im@"))
		WCapiTask_GetDocPath
		
	: (voState.url="/Add@")
		ajax_QAAddtoRecord
		
	: (voState.url="/Delete@")
		WCapiTask_DeleteRecord
		
	: (voState.url="/GetListCustomer@")
		Init_CustomerQALists
		
	: (voState.url="/GetList@")
		Init_TaskQALists
		
		
	: (voState.url="/GetByCustomer@")
		WCapi_SetParameter("tableName"; "Customer")
		WCapiTask_GetQA
	: (voState.url="/GetByOrder@")
		WCapi_SetParameter("tableName"; "Order")
		WCapiTask_GetQA
	: (voState.url="/GetByInvoice@")
		WCapi_SetParameter("tableName"; "Invoice")
		WCapiTask_GetQA
	: (voState.url="/GetByProposal@")
		WCapi_SetParameter("tableName"; "Proposal")
		WCapiTask_GetQA
		
		
	: (voState.url="/GetKeyTags@")
		WCapiTask_KeyTags
		
		
		
	: (voState.url="/GetChoices@")
		WCapiTask_GetQAChoices
		
	: ((voState.url="/image@") | (voState.url="/document@"))
		// Table=QA&UUIDKeyjj=294998F7C5B744768514A52EEC83CCFC&Thumbnail=true
		$vtPath:=<>webFolder+"images"+Folder separator:K24:12+"noimage.jpg"
		$tableName:=WCapi_GetParameter("tableName"; "")
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
					$vtPath:=<>webFolder+"images"+Folder separator:K24:12+"ImagePathEmpty.jpg"
					If (<>viDebugMode>410)
						If (Test path name:C476($vtPath)#1)
							ConsoleMessage("Critical image missing: "+$vtPath)
							$vtPath:=""
						End if 
					End if 
				Else 
					$vtPath:=PathToSystem($vtPath)
					If (Test path name:C476($vtPath)#1)
						ConsoleMessage("Invalid Path: "+$vtPath)
						$vtPath:=<>webFolder+"images"+Folder separator:K24:12+"ImagePathInvalid.jpg"
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
			ConsoleMessage("Error-Path: WCapi_Docs"+$vtPath)
			vResponse:="Error: pages served only thru vue.js vResponse: "+vResponse
			WC_voStateError("Error: path: "+$vtPath)
			WC_SendServerResponse(vResponse)
		End if 
		$vbSendConsole:=False:C215
		vMimeType:="AlreadySent"
		
		
		
	: (voState.url="/Delete@")
		vResponse:="Error: Delete is not a web function."
	Else 
		WCapiTask_TallyMasters
End case 