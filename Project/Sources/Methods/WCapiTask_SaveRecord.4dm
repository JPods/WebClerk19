//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/30/20, 16:38:30
// ----------------------------------------------------
// Method: WCapiTask_SaveRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tableName; $vtTableNameLC; $vtUUIDkey)
C_LONGINT:C283($viTableNum; $viFieldNum)
C_POINTER:C301($ptTable; $ptUUIDKey)
C_OBJECT:C1216($voRec; $voRec)
$tableName:=WCapi_GetParameter("tableName")
$vtUUIDkey:=WCapi_GetParameter("id")
$ptTable:=STR_GetTablePointer($tableName)
C_BOOLEAN:C305($vbSave)
$vbSave:=False:C215
If (Is nil pointer:C315($ptTable))
	vResponse:="Error: tableName not valid: "+$tableName
Else 
	Case of 
		: (($vtUUIDkey="new") | ($vtUUIDkey=""))
			$voRec:=ds:C1482[$tableName].new()
			$voRec.save()
			$vtUUIDKey:=$voRec.id
			$vbSave:=True:C214
		: (Length:C16($vtUUIDkey)<20)
			vResponse:="Error: Invalid id: "+$vtUUIDkey+" for tableName: "+$tableName
		Else 
			$tableName:=Table name:C256($ptTable)
			C_OBJECT:C1216($voRec; $voRec; $voField; $outPut_o)
			$voRec:=New object:C1471
			$voRec:=ds:C1482[$tableName].query("id = :1"; $vtUUIDKey).first()
			$vbSave:=True:C214
	End case 
End if 
If ($vbSave)
	var $original_ent : Object
	//$original_ent:=$voRec.copy()
	//If ($original_ent=Null)
	$original_ent:=ds:C1482[$tableName].query("id = :1"; $vtUUIDKey).first()
	//End if 
	
	vResponse:="{}"
	C_TEXT:C284($vtFieldName; $vtFieldNameLC)
	C_OBJECT:C1216($voFieldsInTable)
	C_OBJECT:C1216($voIncoming)
	C_COLLECTION:C1488($cBadFieldNames)
	$cBadFieldNames:=New collection:C1472
	$voIncoming:=voState.request.parameters
	//$voFieldsInTable:=STR_GetTableDefinition($tableName)
	//C_TEXT($vtFieldNameUnique)
	var $err_c : Collection
	$vtFieldNameUnique:=STR_GetUniqueFieldName($tableName)
	For each ($vtFieldName; $voIncoming)
		If ($voRec[$vtFieldName]=Null:C1517)
			ConsoleLog("Err: bad field name: "+$vtFieldName+": WCapiSave_"+$tableName)
			$cBadFieldNames.push($vtFieldName)
		Else 
			// if type string, add to keyTags
			// dORDA
			
			Case of 
				: ($vtFieldName="idUser")
					// cannot write to it
					
					// ignor any
					
				: ($vtFieldName="id")
					// cannot write to it
				: ($vtFieldName="idNum")
					// cannot write to it
				: ($vtFieldName=$vtFieldNameUnique)
					// cannot write to it
				Else 
					// check permissiona here QQQZZZQQQ
					$voRec[$vtFieldName]:=$voIncoming[$vtFieldName]
			End case 
		End if 
	End for each 
	// must initialize to save keyTags
	If ($voRec.obGeneral=Null:C1517)
		$voRec.obGeneral:=New object:C1471
	End if 
	
	var $temp_o : Object
	
	$doContractDetail:=False:C215
	Case of 
		: ($tableName="Customer")
			
			
		: ($tableName="Proposal")
			$doContractDetail:=True:C214
			
		: ($tableName="Order")
			$doContractDetail:=True:C214
			
		: ($tableName="Invoice")
			$doContractDetail:=True:C214
			
		: ($tableName="Customer")
	End case 
	
	Case of   // same code multiple tables
		: ($doContractDetail)
			If ($original_ent.contractDetailTag#$voRec.contractDetailTag)
				$temp_o:=ds:C1482.ContractDetail.query("name = :1"; $voRec.contractDetailTag).first()
				If ($temp_o#Null:C1517)
					$voRec.contractDetail:=$temp_o.details
				End if 
			End if 
	End case 
	
	$voRec.obGeneral.keyTags:=KeyTagsFromAlphaFields($voRec)
	
	$result_o:=$voRec.save()
	
	
	
	C_OBJECT:C1216($outPut_o)
	$outPut_o:=$voRec.toObject()
	
	var $sel_ent : Object
	var $openPay; $openInvoice : Real
	Case of 
		: ($tableName="Customer")
			$openPay:=ds:C1482.Payment.query("customerID = :1 AND amountAvailable # 0 "; $voRecord.customerID).sum(amountAvailable)
			$openInvoice:=ds:C1482.Invoice.query("customerID = :1 AND calcDue # 0 "; $voRecord.customerID).sum(calcDue)
			$outPut_o.calcPayments:=$openPay
			$outPut_o.calcDue:=$openInvoice
		: ($tableName="Order")
			$openPay:=ds:C1482.Payment.query("customerID = :1 AND amountAvailable # 0 "; $voRecord.customerID).sum(amountAvailable)
			$openInvoice:=ds:C1482.Invoice.query("customerID = :1 AND calcDue # 0 "; $voRecord.customerID).sum(calcDue)
			$outPut_o.calcPayments:=$openPay
			$outPut_o.calccalcDue:=$openInvoice
		: ($tableName="Invoice")
			$openPay:=ds:C1482.Payment.query("customerID = :1 AND amountAvailable # 0 "; $voRecord.customerID).sum(amountAvailable)
			$openInvoice:=ds:C1482.Invoice.query("customerID = :1 AND calcDue # 0 "; $voRecord.customerID).sum(calcDue)-$voRecord.calcDue
			$outPut_o.calcPayments:=$openPay
			$outPut_o.calcDue:=$openInvoice
		: ($tableName="Payment")
			$openPay:=ds:C1482.Payment.query("customerID = :1 AND amountAvailable # 0 "; $voRecord.customerID).sum(amountAvailable)-$voRecord.amountAvailable
			$openInvoice:=ds:C1482.Invoice.query("customerID = :1 AND calcDue # 0 "; $voRecord.customerID).sum(calcDue)
			$outPut_o.calcPayments:=$openPay
			$outPut_o.calcDue:=$openInvoice
		: ($tableName="Proposal")
			$openPay:=ds:C1482.Payment.query("customerID = :1 AND amountAvailable # 0 "; $voRecord.customerID).sum(amountAvailable)-$voRecord.amountAvailable
			$openInvoice:=ds:C1482.Invoice.query("customerID = :1 AND calcDue # 0 "; $voRecord.customerID).sum(calcDue)
			$outPut_o.calcPayments:=$openPay
			$outPut_o.calcDue:=$openInvoice
	End case 
	
	
	
	If ($cBadFieldNames.length>0)
		voState.badFieldNames:=$cBadFieldNames.join(";")
		ConsoleLog("Error: fieldNames from "+voState.request.URL.pathNameTrimmed+": "+voState.badFieldNames)
		$outPut_o.badFieldNames:=voState.badFieldNames
	End if 
	
	vResponse:=JSON Stringify:C1217($outPut_o)
	WCapi_TallyMasterCall  // make changes to vResponse
End if 