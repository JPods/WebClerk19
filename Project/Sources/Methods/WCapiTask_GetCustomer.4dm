//%attributes = {}
C_TEXT:C284($tableName; $vtTableNameLC; $vtUUIDkey)
C_POINTER:C301($ptTable; $ptUUIDKey)
$tableName:=WCapi_GetParameter("tableName")
$vtUUIDkey:=WCapi_GetParameter("id")
If (($tableName="") | (Length:C16($vtUUIDkey)<20))
	vResponse:="Error: Missing tableName: "+$tableName+" or invalid id: "+$vtUUIDkey
Else 
	$ptTable:=STR_GetTablePointer($tableName)
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: Table not valid: "+$tableName
	Else 
		$ptUUIDKey:=STR_GetFieldPointer($tableName; "id")
		$tableName:=Table name:C256($ptTable)
		QUERY:C277($ptTable->; $ptUUIDKey->=$vtUUIDkey)
		If (Records in selection:C76($ptTable->)#1)
			vResponse:="Error: id "+$vtUUIDkey+" not valid for "+$tableName
		Else 
			vResponse:="[]"
			C_POINTER:C301($ptCustID)
			$ptCustID:=STR_GetFieldPointer($tableName; "customerID")
			If (Is nil pointer:C315($ptCustID))
				vResponse:="Error: no customerID field for tableName "+$tableName
			Else 
				C_TEXT:C284($vtFieldName)
				C_TEXT:C284($vtFieldNameLC; $vtRole)
				C_OBJECT:C1216($voRecord)
				C_OBJECT:C1216($voField)
				C_OBJECT:C1216($voFieldList)
				C_TEXT:C284($vtcustomerID)
				$vtcustomerID:=$ptCustID->
				$voSelection:=New object:C1471
				$voSelection:=ds:C1482.Customer.query("customerID = :1"; $vtcustomerID)
				If ($voSelection.length=0)
					vResponse:="Error: No record for [Customer]customerID: "+$vtcustomerID
				Else 
					vResponse:=WCapiTask_RecordToObject("Customer"; $voSelection[0])
				End if 
			End if 
		End if 
	End if 
End if 

