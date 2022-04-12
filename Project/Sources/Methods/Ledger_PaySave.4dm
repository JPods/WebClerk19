//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-26T06:00:00Z)
// Method: Ledger_PaySave
// Description
// Parameters
// ----------------------------------------------------
var $1; ent; $selLedger; $summary : Object
//var <>keepAllLedgers : Boolean
ent:=$1
$selLedger:=ds:C1482.Ledger.query("tableNum = :1 | tableNum = :2 & docRefid =  :3"; 28; -28; ent.idNum)
$summary:=$selLedger.drop()


Case of 
	: ((Storage:C1525.default.linkedOnly) & (ent.jrnlComplete=False:C215))
		//drop out
	: ((ent.amountAvailable=0) & (ent.dateDocument<(Current date:C33-140)) & (<>keepAllLedgers))
		//drop out
	Else 
		
		Ledger_RayInit(0)
		
		Ledger_RayInit(1)
		aLdgidForeign{1}:=ent.id
		aLdgAcct{1}:=ent.customerID
		If (ent.typePayment="Late")
			aLdgDocType{1}:=-28
			aLdgDue{1}:=ent.dateDocument
		Else 
			aLdgDocType{1}:=28
			aLdgDue{1}:=ent.dateDocument+30
		End if 
		aLdgTableName{1}:="Payment"
		aLdgDocId{1}:=ent.idNum
		aLdgDocDt{1}:=ent.dateDocument
		aLdgExpire{1}:=!00-00-00!
		aLdgValue{1}:=-ent.amountAvailable
		//    aLdgJrnl{1}:=[SalesJrnl]Source
		aLdgOrig{1}:=-ent.amount
		
		Ledger_RayInit(-3)
		
End case 

