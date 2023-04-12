//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/08/20, 23:46:22
// ----------------------------------------------------
// Method: DemoResetDatesDaily("A26AAB05BEBB4AFB9CE531FBADD0657B")
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($vtUUIDKey)
$vtUUIDKey:=""
If (Count parameters:C259=1)
	If ($1="A26AAB05BEBB4AFB9CE531FBADD0657B")
		$vtUUIDKey:="passAll"
	End if 
End if 

If (False:C215)
	$obSel:=ds:C1482.Customer.all()
	If ($obSel.length<100)
		// testing
		$vtUUIDKey:="passAll"
	End if 
End if 

If ($vtUUIDKey="passAll")
	
Else 
	CONFIRM:C162("Reset Demo Date")
	If (OK=1)
		$vtPassword:=Request:C163("Enter password.")
		If ((OK=1) & ($vtPassword="coffeeReset"))
			$vtUUIDKey:="pass"
		End if 
	End if 
End if 

ARRAY TEXT:C222($aNameRotate; 0)
COPY ARRAY:C226(<>aNameID; $aNameRotate)
DELETE FROM ARRAY:C228($aNameRotate; 1; 1)
$w:=Find in array:C230($aNameRotate; "Admin")
If ($w>0)
	DELETE FROM ARRAY:C228($aNameRotate; $w; 1)
End if 
$w:=Find in array:C230($aNameRotate; "All Users")
If ($w>0)
	DELETE FROM ARRAY:C228($aNameRotate; $w; 1)
End if 
$w:=Find in array:C230($aNameRotate; "Dale")
If ($w>0)
	DELETE FROM ARRAY:C228($aNameRotate; $w; 1)
End if 
ARRAY LONGINT:C221($aLongCnt; Size of array:C274($aNameRotate))
C_TEXT:C284($vtName)
C_LONGINT:C283($viName)

If ($vtUUIDKey="pass@")
	C_LONGINT:C283($viCountEmployees; $incEmployee; $cntAssigned)
	$viCountEmployees:=Size of array:C274($aNameRotate)
	C_DATE:C307($vdSetDate)
	C_OBJECT:C1216($obRec; $obSel)
	$obSel:=ds:C1482.Customer.all()
	$vdSetDate:=Current date:C33-1
	$incEmployee:=1
	$cntAssigned:=0
	For each ($obRec; $obSel)
		
		If ($incEmployee=$viCountEmployees)
			$incEmployee:=1
			$vdSetDate:=$vdSetDate+1
		Else 
			$incEmployee:=$incEmployee+1
		End if 
		
		$obRec.actionBy:=$aNameRotate{$incEmployee}
		$obRec.actionDate:=$vdSetDate
		If ($obRec.actionTime<?03:00:00?)
			$obRec.actionTime:=?08:15:00?
		End if 
		If ($obRec.actionDuration<60)
			$obRec.actionDuration:=60
		End if 
		$result_o:=$obRec.save()
	End for each 
	
	$obSel:=ds:C1482.Customer.query("customerID = 002002 ")
	If ($obSel.first()=Null:C1517)
		ConsoleLog("customerID = 002002 is missing")
	Else 
		$obRec:=$obSel.first()
		$obRec.actionBy:="Dale"
		$obRec.actionDate:=Current date:C33
		$result_o:=$obRec.save()
	End if 
	
	$obSel:=ds:C1482.Order.query("complete < 2")
	$vdSetDate:=Current date:C33-1
	$incEmployee:=1
	$cntAssigned:=1
	For each ($obRec; $obSel)
		
		If ($incEmployee=$viCountEmployees)
			$incEmployee:=1
			$vdSetDate:=$vdSetDate+1
		Else 
			$incEmployee:=$incEmployee+1
		End if 
		
		$obRec.actionBy:=$aNameRotate{$incEmployee}
		$obRec.actionDate:=$vdSetDate
		If ($obRec.actionTime<?03:00:00?)
			$obRec.actionTime:=?08:15:00?
		End if 
		If ($obRec.actionDuration<60)
			$obRec.actionDuration:=60
		End if 
		$result_o:=$obRec.save()
	End for each 
	var $orders_t; $queryStr_t : Text
	var $orders_c : Collection
	$orders_t:="1020,3019,3020,3021"
	$orders_c:=Split string:C1554($orders_t; ";")
	For each ($queryStr_t; $orders_c)
		$obRec:=ds:C1482.Order.query("orderNum = :1 "; $queryStr_t).first()
		If ($obRec=Null:C1517)
			ConsoleLog("Set to Dale: orderNum is missing; "+$queryStr_t)
		Else 
			ConsoleLog("Set to Dale: orderNum "+$queryStr_t)
			$obRec.actionBy:="Dale"
			$obRec.actionDate:=Current date:C33
			$result_o:=$obRec.save()
		End if 
	End for each 
	
	$obSel:=ds:C1482.Service.all()
	$vdSetDate:=Current date:C33-1
	$incEmployee:=1
	$cntAssigned:=1
	For each ($obRec; $obSel)
		
		$cntAssigned:=$cntAssigned+1
		If ($cntAssigned>2)
			$cntAssigned:=1
			If ($incEmployee=$viCountEmployees)
				$incEmployee:=1
				$vdSetDate:=$vdSetDate+1
			Else 
				$incEmployee:=$incEmployee+1
			End if 
		End if 
		
		$obRec.actionBy:=$aNameRotate{$incEmployee}
		$obRec.actionDate:=$vdSetDate
		If ($obRec.actionTime<?03:00:00?)
			$obRec.actionTime:=?11:00:00?
		End if 
		If ($obRec.actionDuration<60)
			$obRec.actionDuration:=60
		End if 
		$result_o:=$obRec.save()
	End for each 
	
	
	$obSel:=ds:C1482.Invoice.query("balanceDue#0")
	$vdSetDate:=Current date:C33-1
	$incEmployee:=1
	$cntAssigned:=1
	For each ($obRec; $obSel)
		
		
		$cntAssigned:=$cntAssigned+1
		If ($cntAssigned>2)
			$cntAssigned:=1
			If ($incEmployee=$viCountEmployees)
				$incEmployee:=1
				$vdSetDate:=$vdSetDate+1
			Else 
				$incEmployee:=$incEmployee+1
			End if 
		End if 
		
		
		$obRec.actionBy:=$aNameRotate{$incEmployee}
		$obRec.actionDate:=$vdSetDate
		If ($obRec.actionTime<?03:00:00?)
			$obRec.actionTime:=?13:15:00?
		End if 
		If ($obRec.actionDuration<60)
			$obRec.actionDuration:=60
		End if 
		$result_o:=$obRec.save()
	End for each 
	
	$obSel:=ds:C1482.Invoice.query("invoiceNum = 3010 ")
	If ($obSel.first()=Null:C1517)
		ConsoleLog("Invoice 3010 is missing")
	Else 
		ConsoleLog("Invoice 3010 set to Dale")
		$obRec:=$obSel.first()
		$obRec.actionBy:="Dale"
		$obRec.actionDate:=Current date:C33
		$result_o:=$obRec.save()
	End if 
	$obSel:=ds:C1482.Invoice.query("invoiceNum = 2010 ")
	If ($obSel.first()=Null:C1517)
		ConsoleLog("Invoice 2010 is missing")
	Else 
		ConsoleLog("Invoice 2010 set to Dale")
		$obRec:=$obSel.first()
		$obRec.actionBy:="Dale"
		$obRec.actionDate:=Current date:C33
		$result_o:=$obRec.save()
	End if 
	
	$obSel:=ds:C1482.Proposal.query("status =  Open")
	$vdSetDate:=Current date:C33-1
	$incEmployee:=1
	$cntAssigned:=1
	For each ($obRec; $obSel)
		If ($cntAssigned=2)
			$vdSetDate:=$vdSetDate+1
			If ($incEmployee=$viCountEmployees)
				$incEmployee:=1
			Else 
				$incEmployee:=$incEmployee+1
			End if 
		End if 
		$obRec.actionBy:=$aNameRotate{$incEmployee}
		$obRec.actionDate:=$vdSetDate
		If ($obRec.actionTime<?03:00:00?)
			$obRec.actionTime:=?16:15:00?
		End if 
		If ($obRec.actionDuration<60)
			$obRec.actionDuration:=60
		End if 
		$result_o:=$obRec.save()
	End for each 
	
	$obSel:=ds:C1482.Proposal.query("proposalNum = 1006 ")
	If ($obSel.first()=Null:C1517)
		ConsoleLog("Proposal 1006 is missing")
	Else 
		ConsoleLog("Proposal 1006 set to Dale")
		$obRec:=$obSel.first()
		$obRec.actionBy:="Dale"
		$obRec.actionDate:=Current date:C33
		$result_o:=$obRec.save()
	End if 
	
End if 

ReduceSelectAll


