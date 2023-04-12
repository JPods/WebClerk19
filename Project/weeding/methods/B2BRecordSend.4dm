//%attributes = {"publishedWeb":true}
If (False:C215)
	TCMod_606_67_03_04_Trans
	If (False:C215)
		//Method: B2BRecordGet
		//Date: 01/05/05
		//Who: Bill
		//Description: 
		//zzzz Check this and clean up
	End if 
	//
End if 

C_LONGINT:C283($1; $err; $orderNum; $k; $err)
C_POINTER:C301($2)
vResponse:="Table is not available."
$doPage:=WC_DoPage("Error.html"; "")
If ((viEndUserSecurityLevel>1) | (vWccSecurity>1))
	$tableName:=WCapi_GetParameter("TableName")
	$fieldName:=WCapi_GetParameter("FieldName")
	$fieldValue:=WCapi_GetParameter("FieldValue")
	$synRecID:=Num:C11(WCapi_GetParameter("SyncRecID"))
	//
	$syncAction:=WCapi_GetParameter("SyncAction")
	$eventID:=WCapi_GetParameter("SynceventID")
	//
	$tableNum:=STR_GetTableNumber($tableName)
	$fieldNum:=STR_GetFieldNumber($tableName; $fieldName)
	If (($tableNum>0) & ($fieldNum>0) & ($fieldValue#"") & ($synRecID>0))
		C_POINTER:C301($ptTable; $ptField)
		$ptField:=Field:C253($tableNum; $fieldNum)
		$ptTable:=Table:C252($tableNum)
		C_LONGINT:C283($theType)
		$theType:=Type:C295($ptField)
		Case of 
			: ($theType=Is alpha field:K8:1)  //string
				QUERY:C277($ptTable->; $ptField->=$fieldValue)
			: ($theType=Is longint:K8:6)
				QUERY:C277($ptTable->; $ptField->=Num:C11($fieldValue))
		End case 
		//add some record and id checking     
		If (Records in selection:C76($ptTable->)=1)
			C_TIME:C306($myDoc)
			$theDoc:=Storage:C1525.folder.jitF+"zzzDeleteMe"+String:C10(Milliseconds:C459)
			If (Is macOS:C1572)  //see 4D LangRef
				$myDoc:=Create document:C266($theDoc+".txt")
			Else 
				$myDoc:=Create document:C266($theDoc; "txt")  //Windows extension requirment
			End if 
			CLOSE DOCUMENT:C267($myDoc)
			SET CHANNEL:C77(10; document)
			SEND RECORD:C78($ptFile->)
			SET CHANNEL:C77(11)
			C_BLOB:C604($myBlob)
			DOCUMENT TO BLOB:C525(document; $myBlob)
			DELETE DOCUMENT:C159(document)
			$err:=TCP Send Blob($1; $myBlob)
		Else 
			//send error message
		End if 
	End if 
End if 


