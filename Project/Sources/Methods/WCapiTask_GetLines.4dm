//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/12/21, 02:59:56
// ----------------------------------------------------
// Method: WCapiTask_GetLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tableName; $vtTableNameLC; $vtUUIDkey)
C_POINTER:C301($ptTable; $ptUUIDKey)
C_TEXT:C284($vtTableLine)
$tableName:=WCapi_GetParameter("tableName")
$vtUUIDkey:=WCapi_GetParameter("id")

If (False:C215)  // 1020
	$tableName:="Order"
	$vtUUIDkey:="B037D70D521AE041A7C9A848D06AD1CF"
	
	// 2017
	$tableName:="Order"
	$vtUUIDkey:="C51B9C3D7EF948C7A64E3F0E554FBA1E"
	
End if 

If (($tableName="") | (Length:C16($vtUUIDkey)<20))
	vResponse:="Error: Missing tableName: "+$tableName+" or invalid id: "+$vtUUIDkey
Else 
	$ptTable:=STR_GetTablePointer($tableName)
	$tableName:=Table name:C256($ptTable)
	If (Is nil pointer:C315($ptTable))
		vResponse:="Error: Table not valid: "+$tableName
	Else 
		C_OBJECT:C1216($recPrimary_ent)
		C_OBJECT:C1216($lines_ent)
		C_TEXT:C284($vtQuery)
		C_LONGINT:C283($viUniqueID)
		$recPrimary_ent:=ds:C1482[$tableName].query("id = :1 "; $vtUUIDkey).first()
		If ($recPrimary_ent=Null:C1517)
			vResponse:="Error: id not valid for "+$tableName+": "+$vtUUIDkey
		Else 
			vResponse:="[]"
			Case of 
				: ($tableName="Proposal")
					$vtQuery:="proposalNum = :1"
					$viUniqueID:=$recPrimary_ent.proposalNum
					$vtTableLine:="ProposalLine"
					$vbDoArray:=True:C214
				: ($tableName="Order")
					$vtQuery:="orderNum = :1"
					$viUniqueID:=$recPrimary_ent.orderNum
					$vtTableLine:="OrderLine"
					$vbDoArray:=True:C214
				: ($tableName="Invoice")
					$vtQuery:="invoiceNum = :1"
					$viUniqueID:=$recPrimary_ent.invoiceNum
					$vtTableLine:="InvoiceLine"
					$vbDoArray:=True:C214
			End case 
			If ($vbDoArray)
				$lines_ent:=ds:C1482[$vtTableLine].query($vtQuery; $viUniqueID)
				If ($lines_ent=Null:C1517)
					vResponse:="[]"
				Else 
					$vtRole:="Sales"
					$vtPurpose:="list"
					$vtFieldList:=API_GetFieldList($vtTableLine; $vtRole; $vtPurpose)
					vResponse:=API_EntityToText($lines_ent; $vtFieldList; $vtTableLine)
					voState.result:=$vtTableLine+" records in selection: "+String:C10($lines_ent.length)
				End if 
			End if 
		End if 
	End if 
End if 