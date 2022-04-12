//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/30/20, 16:42:56
// ----------------------------------------------------
// Method: WCapiTask_GetByCustomer
// Description
C_TEXT:C284($tableName; $vtTableNameLC; $vtUUIDkey; $vtcustomerID)
C_POINTER:C301($ptTable)
C_OBJECT:C1216($voSelCustomer; $voSelTable)
$tableName:=WCapi_GetParameter("tableName")
If ($tableName="")
	vResponse:="Error: Missing tableName"
Else 
	$ptTable:=STR_GetTablePointer($tableName)
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: Table not valid: "+$tableName
	Else 
		Case of 
			: (voState.url="/GetBycustomerID")
				$vtcustomerID:=WCapi_GetParameter("customerID")
				If ($vtcustomerID="")
					vResponse:="Error: Empty customerID"
				Else 
					$voSelCustomer:=ds:C1482.Customer.query("customerID = :1"; $vtcustomerID)
				End if 
			: (voState.url="/GetByCustomer@")
				$vtUUIDkey:=WCapi_GetParameter("id")
				If (Length:C16($vtUUIDkey)<20)
					vResponse:="Error: Invalid id: "+$vtUUIDkey
				Else 
					$voSelCustomer:=ds:C1482.Customer.query("id = :1"; $vtUUIDkey)
				End if 
		End case 
	End if 
End if 

If ($voSelCustomer.length=1)
	$vtcustomerID:=$voSelCustomer.first().customerID
	$voSelTable:=ds:C1482[$tableName].query("customerID = :1 "; $vtcustomerID)
	$vtRole:="Sales"
	$vtPurpose:="list"
	$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
	vResponse:=API_EntityToText($voSelTable; $vtFieldList)
	voState.result:=$tableName+" records in selection: "+String:C10($voSelTable.length)
End if 