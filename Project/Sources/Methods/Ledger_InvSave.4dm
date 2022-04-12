//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-25T06:00:00Z)
// Method: Ledger_InvSave
// Description 
// Parameters
// ----------------------------------------------------
var $1; ent; $selLedger : Object
ent:=$1
C_BOOLEAN:C305(<>keepAllLedgers)  //??? work out something different, I do not think these save legers
C_BOOLEAN:C305($doDelete)

$selLedger:=ds:C1482.Ledger.query("idInvoice = :1"; ent.id)
Data_GarbageMake($selLedger.drop())

Case of 
	: ((ent.balanceDue=0) & (ent.datePaid+120<Current date:C33) & (<>keepAllLedgers))  //clear old
		$doDelete:=True:C214
	: ((Storage:C1525.default.linkedOnly=True:C214) & (ent.jrnlComplete=False:C215))  //process only linked invoices
		$doDelete:=True:C214
	: ((ent.consignment#"") & (ent.consignment#"complete@"))  //process no consigned invoices
		$doDelete:=True:C214
	Else 
		If ((<>tcMONEYCHAR#strCurrency) & (strCurrency#"") & (rUExchRate#1) & (rUExchRate#0))
			//should no longer be able to get to this point  9/9/98
			$myTotal:=Round:C94(ent.total/rUExchRate; <>tcDecimalTt)
			$myBalance:=Round:C94(ent.balanceDue/rUExchRate; <>tcDecimalTt)
		Else 
			$myTotal:=ent.total
			$myBalance:=ent.balanceDue
		End if 
		
		C_LONGINT:C283($cntPeriods; $incPeriods; $fiaTerm)
		$fiaTerm:=Find in array:C230(<>aTerms; ent.terms)
		If ($fiaTerm=-1)
			Ledger_RayInit(1)
			//
			aLdgAcct{1}:=ent.customerID
			aLdgidForeign{1}:=ent.id
			aLdgDocType{1}:=26
			aLdgDocId{1}:=ent.idNum
			aLdgDue{1}:=Invc_PrimeDate
			aLdgDocDt{1}:=Invc_PrimeDate
			aLdgExpire{1}:=!00-00-00!
			aLdgDscPot{1}:=0
			aLdgValue{1}:=$myBalance
			aLdgJrnl{1}:=""  //[SalesJrnl]Source
			aLdgTerms{1}:=ent.terms
			aLdgOrig{1}:=$myTotal
			aLdgTableName{1}:="Invoice"
			//
		Else 
			C_BOOLEAN:C305($doDiscnt)
			$doDiscnt:=((<>aTermDctDay{$fiaTerm}#0) & (<>aTermDctRt{$fiaTerm}#0))
			If ((<>aTermPrdCnt{$fiaTerm}=0) | ($myBalance<0))
				$cntPeriods:=1
			Else 
				$cntPeriods:=<>aTermPrdCnt{$fiaTerm}
			End if 
			Ledger_RayInit($cntPeriods)
			//    
			C_REAL:C285($origSplit; $origDiff; $paid; $splitTtl)
			$origSplit:=Round:C94($myTotal/$cntPeriods; <>tcDecimalTt)
			$origDiff:=Round:C94($myTotal-Round:C94(($origSplit*$cntPeriods); <>tcDecimalTt); <>tcDecimalTt)
			$paid:=$myTotal-$myBalance
			//
			C_DATE:C307($dueDate)
			C_TEXT:C284($dayStr)
			$dueDate:=Invc_DateDue(->vText1)
			$dayStr:=vText1
			
			For ($incPeriods; 1; $cntPeriods)
				aLdgAcct{$incPeriods}:=ent.customerID
				aLdgidForeign{1}:=ent.id
				aLdgDocType{$incPeriods}:=26
				aLdgDocId{$incPeriods}:=ent.idNum
				aLdgDue{$incPeriods}:=$dueDate
				aLdgDocDt{$incPeriods}:=Invc_PrimeDate
				If ($dayStr="")
					$dueDate:=$dueDate+<>aTermPrdLen{$fiaTerm}
				Else 
					$dueDate:=Date:C102(String:C10(Month of:C24($dueDate+31))+"/"+$dayStr+"/"+String:C10(Year of:C25($dueDate+31)))
				End if 
				
				If ($incPeriods<$cntPeriods)
					$splitTtl:=$origSplit
				Else 
					$splitTtl:=$origSplit+$origDiff
				End if 
				Case of 
					: ($myBalance<0)
						$amount:=$myBalance
						$splitTtl:=$myTotal
						$doDiscnt:=False:C215
					: ($splitTtl<$paid)
						$amount:=0
						$paid:=$paid-$splitTtl
					Else 
						$amount:=$splitTtl-$paid
						$paid:=0
				End case 
				aLdgValue{$incPeriods}:=$amount
				aLdgJrnl{$incPeriods}:=""  //[SalesJrnl]Source
				aLdgTerms{$incPeriods}:=ent.terms
				aLdgOrig{$incPeriods}:=$splitTtl
				If ($doDiscnt)
					aLdgDscPot{$incPeriods}:=Round:C94($amount*0.01*<>aTermDctRt{$fiaTerm}; <>tcDecimalTt)
					aLdgExpire{$incPeriods}:=$dueDate+<>aTermDctDay{$fiaTerm}-30
				Else 
					aLdgExpire{$incPeriods}:=!00-00-00!
				End if 
				aLdgTableName{$incPeriods}:="Invoice"
			End for 
			//      
		End if 
		$cntPeriods:=Size of array:C274(aLdgAcct)
		If ($cntPeriods>0)
			Ledger_RayInit(-3)
		End if 
End case 

