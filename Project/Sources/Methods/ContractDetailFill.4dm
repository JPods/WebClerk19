//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 07/27/21, 14:47:12
// ----------------------------------------------------
// Method: ContractDetailFill
// Description
// 
//
// Parameters
// ----------------------------------------------------

var $1; $0; $value_t : Text
$value_t:=$1

C_POINTER:C301($2; $ptTerms)
$ptTerms:=$2
C_BOOLEAN:C305($doFill)
$doFill:=False:C215
If ($ptTerms->="")
	$doFill:=True:C214
Else 
	CONFIRM:C162("Reload ContractTerm details.")
	$doFill:=(OK=1)
End if 
If ($doFill)
	var $rec_ent : Object
	$rec_ent:=ds:C1482.ContractDetail.query("name = :1"; $value_t).first()
	If ($rec_ent=Null:C1517)
		ALERT:C41("No matching ContractDetail record")
	Else 
		$ptTerms->:=$rec_ent.details
	End if 
End if 

//var Ob : Object
//Ob:=ds.ContractDetail.query("approvedBy = TransactionType")
