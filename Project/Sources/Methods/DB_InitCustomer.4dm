//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-06-28T05:00:00Z)
// Method: DB_InitCustomer
// Description 
// Parameters
// ----------------------------------------------------

#DECLARE($action : Text; $toClone : Object)->$rec_o : Object
Case of 
	: ($action="new")
		$rec_o:=ds:C1482.Customer.new()
		If ($rec_o.customerID="")
			$rec_o.customerID:=Storage:C1525.default.idPrefix+String:C10(CounterNew(->[Customer:2]))
		End if 
		$rec_o.phone:=""
		$rec_o.zip:=""
		$rec_o.company:=""
		$rec_o.dateOpened:=Current date:C33
		$rec_o.terms:=Storage:C1525.default.terms
		$rec_o.shipVia:=Storage:C1525.default.shipVia
		$rec_o.typeSale:=Storage:C1525.default.typeSale
		$rec_o.prospect:="Lead"
		$rec_o.division:=Storage:C1525.default.division
		$rec_o.zone:=-1
		$rec_o.mfrLocationid:=0
		$rec_o.country:=Storage:C1525.default.country
		$rec_o.upsBillingOption:="Prepaid & Add"
		$rec_o.upsInsureShipping:=True:C214
		$rec_o.save()
		
		$0:=process_o.cur.toObject()
	: ($action="clone")
		$rec_o:=ds:C1482.Customer.new()
		
		
		$rec_o.actionDate:=!00-00-00!
		$rec_o.actionDuration:=0
		$rec_o.actionTime:=0
		$rec_o.alertMessage:=""
		$rec_o.badCheck:=False:C215
		$rec_o.badCheckDate:=!00-00-00!
		$rec_o.balanceAvailablePayments:=0
		$rec_o.balanceCurrent:=0
		$rec_o.balanceDue:=0
		$rec_o.balanceOpenOrders:=0
		$rec_o.balanceTotalExposure:=0
		$rec_o.balPastPeriod1:=0
		$rec_o.balPastPeriod2:=0
		$rec_o.balPastPeriod3:=0
		$rec_o.contactBillTo:=0
		$rec_o.contactShipTo:=0
		$rec_o.costsAllTime:=0
		$rec_o.costsMTD:=0
		$rec_o.costsYTD:=0
		$rec_o.creditApproval:=""
		var $b : Blob
		$rec_o.creditCardBlob:=$b
		$rec_o.creditCardCVV:=""
		$rec_o.creditCardEncode:=""
		$rec_o.creditCardExpir:=!00-00-00!
		$rec_o.creditCardNum:=""
		$rec_o.creditLimit:=0
		$rec_o.customerID2nd:=""
		$rec_o.dateConverted:=!00-00-00!
		$rec_o.dateLastUpdated:=!00-00-00!
		$rec_o.dateOpened:=!00-00-00!
		$rec_o.dateRetired:=!00-00-00!
		$rec_o.dateService:=!00-00-00!
		$rec_o.daysAvgPaid:=0
		
		
		
End case 