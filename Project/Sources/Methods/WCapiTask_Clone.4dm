//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/13/21, 22:44:09
// ----------------------------------------------------
// Method: WCapiTask_GetCloneList
// Description
// 
//
// Parameters
// ----------------------------------------------------
ARRAY TEXT:C222($aURL; 0)
TextToArray(voState.url; ->$aURL; "/")
//WCapil_TableFieldvoState
If (Size of array:C274($aURL)<2)
	vResponse:="Error: improper data for GetClone, requires /WCapi/tableName/GetCloneList or Clone"
Else 
	C_OBJECT:C1216($obSel)
	C_TEXT:C284($tableName; $vtQuery)
	$tableName:=STR_FixCaseTableName($aURL{1})
	If ($tableName="")
		vResponse:="Error: tableName invalid in GetBy: "+$aURL{1}
	Else 
		Case of 
			: ($aURL{2}="GetCloneList")
				$vtQuery:="salesNameID = CloneAllowed@"
				$obSel:=ds:C1482[$tableName].query($vtQuery)
				If ($obSel=Null:C1517)
					vResponse:="[]"
				Else 
					$vtRole:="Sales"
					$vtPurpose:="list"
					$vtFieldList:="id,proposalNum,status,comment,lineCount,amount,profile2"
					// $vtFieldList:=API_GetFieldList($vtTableLine; $vtRole; $vtPurpose)
					vResponse:=API_EntityToText($obSel; $vtFieldList)
					voState.result:=$vtTableLine+" records in selection: "+String:C10($obSel.length)
				End if 
			: ($aURL{2}="CloneChoiceList")
				C_COLLECTION:C1488($vcUnique)
				$vtQuery:="salesNameID = CloneAllowed@"
				$vcUnique:=ds:C1482[$tableName].query($vtQuery).distinct("profile2")
				If ($vcUnique=Null:C1517)
					vResponse:="[]"
				Else 
					vResponse:=JSON Stringify array:C1228($vcUnique)
					voState.result:=$vcUnique
				End if 
			Else 
				C_OBJECT:C1216($obRec; $obSel; $obCust; $obCustSel; $ob)
				$vtid:=WCapi_GetParameter("id")
				If ($vtid="")
					$vtid:=WCapi_GetParameter("idProposal")
				End if 
				$vtIDCustomer:=WCapi_GetParameter("idCustomer")
				If (($vtid="") | ($vtIDCustomer=""))
					vResponse:="Error: invalid id "+$vtid+" or idCustomer "+$vtIDCustomer
				Else 
					QUERY:C277([Proposal:42]; [Proposal:42]id:89=$vtid)
					QUERY:C277([Customer:2]; [Customer:2]id:127=$vtIDCustomer)
					If ((Records in selection:C76([Proposal:42])=1) & (Records in selection:C76([Customer:2])=1))
						CloneProposal
						booAccept:=True:C214
						vMod:=True:C214
						vLineMod:=True:C214
						acceptPropsl
						$voSelection:=Create entity selection:C1512([Proposal:42])
						vResponse:=WCapiTask_RecordToObject($tableName; $voSelection.first())
					Else 
						vResponse:="Error: invalid id "+$vtid+" or idCustomer "+$vtIDCustomer
					End if 
					If (False:C215)
						$obSel:=ds:C1482[$tableName].query("id = :1"; $vtid)
						$obRec:=$obSel.first()
						$obCustSel:=ds:C1482.Customer.query("id = :1"; $vtIDCustomer)
						$obCust:=$obCustSel.first()
					End if 
				End if 
		End case 
	End if 
End if 