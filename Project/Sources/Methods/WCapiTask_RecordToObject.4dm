//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/12/21, 23:51:46
// ----------------------------------------------------
// Method: WCapiTask_RecordToObject
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($vtFieldName)
C_TEXT:C284($vtFieldNameLC; $vtRole)
C_OBJECT:C1216($voRecord; $voOutput)
C_OBJECT:C1216($voField)
C_OBJECT:C1216($voFieldList)
C_POINTER:C301($ptFieldNames)

C_TEXT:C284($0; $1; $tableName)
$tableName:=$1
C_OBJECT:C1216($2; $voRecord; $selOther_ent)
$voRecord:=$2
C_BOOLEAN:C305($vbWasTouched)
$vbWasTouched:=$voRecord.touched()
$voOutput:=New object:C1471
$voOutput:=$voRecord.toObject()
var $sel_ent : Object
var $openPay; $openInvoice : Real
var $doBalance; $doContractDetail : Boolean
$doBalance:=False:C215
$doContractDetail:=False:C215
Case of 
	: ($tableName="Payment")
		$doBalance:=True:C214
	: ($tableName="Customer")
		$doBalance:=True:C214
	: ($tableName="Order")
		$doBalance:=True:C214
		$doContractDetail:=True:C214
	: ($tableName="Invoice")
		$doBalance:=True:C214
		$doContractDetail:=True:C214
	: ($tableName="Proposal")
		$doBalance:=True:C214
		$doContractDetail:=True:C214
End case 
If ($doContractDetail)
	If ($voOutput.contractDetail="")
		If ($voOutput.contractDetailTag#"")
			$selOther_ent:=ds:C1482.ContractDetail.query("name = :1"; $voOutput.contractDetailTag).first()
			If ($selOther_ent#Null:C1517)
				$voOutput.contractDetail:=$selOther_ent.details
				$voRecord.contractDetail:=$selOther_ent.details
				$voRecord.save()
			End if 
		End if 
	End if 
End if 
If ($doBalance)
	$openPay:=ds:C1482.Payment.query("customerID = :1 AND amountAvailable # 0 "; $voRecord.customerID).sum(amountAvailable)
	$openInvoice:=ds:C1482.Invoice.query("customerID = :1 AND balanceDue # 0 "; $voRecord.customerID).sum(balanceDue)
	$voOutput.openPayments:=$openPay
	$voOutput.openInvoices:=$openInvoice
	$voOutput.balance:=$openInvoice-$openPay
End if 

$voOutput.isLocked:=False:C215
If (voState.errors.length>0)
	$voOutput.errors:=New collection:C1472
	$voOutput.errors.push(voState.errors)
End if 
$0:=JSON Stringify:C1217($voOutput)


