//%attributes = {"publishedWeb":true}
C_TEXT:C284($4)
C_LONGINT:C283(bPayment; $1; $2; $thePrec)  //$1 in an invoice, $2 in order
C_REAL:C285($temBalDue; $3; rUExchRate)
C_LONGINT:C283($5; $testWindow; pPayRecordAuth)
$testWindow:=0
If (Count parameters:C259=2)
	$testWindow:=$2
End if 
//C_BOOLEAN($doAdjust)
vDiaCom:="Enter Payment"
READ WRITE:C146([Payment:28])
$applyInv:=0
pPayment:=0
pDiffCurr:=0
$thePrec:=<>tcDecimalTt
pDiff:=0
pvProcessorTransID:=""
pvError:=""
pCardApprv:=""
vsReferNum:=""
vsRspnText:=""
pvCardExpire:=""
pCkNum:=""
pvStatus:=""
pCVV:=""
If (($3=0) | ($3=1) | ($4="") | ($4=<>tcMONEYCHAR))
	rExchRate:=1
	rUExchRate:=1
Else 
	rExchRate:=$3
	QUERY:C277([Currency:61]; [Currency:61]currencyid:3=$4; *)
	QUERY:C277([Currency:61];  & [Currency:61]active:2=True:C214)
	$thePrec:=[Currency:61]convertPrec:7
	If (Records in selection:C76([Currency:61])=1)
		rUExchRate:=[Currency:61]exchangeRate:4
	Else 
		rUExchRate:=1
	End if 
End if 
//strCurrency:=$4
sExchCurr:=$4

If (False:C215)
	Case of 
		: (<>tcCcDevice=<>ciCCDevZjMd)  //Zon in Modem Port
			CC_ZonSetPort(1)
		: (<>tcCcDevice=<>ciCCDevZjPr)  //Zon in Printer Port
			CC_ZonSetPort(0)
	End case 
	//Else 
	//ALERT("ZonJr is no longer automated."+"\r"+"Other more modern methods
	// are recommended.")
End if 
If (Record number:C243([Invoice:26])>=0)
	vlInvoiceNum:=[Invoice:26]invoiceNum:2
	vscustomerID:=[Invoice:26]customerID:3
	vrSalesTax:=[Invoice:26]salesTax:19
	vsCustPONum:=[Invoice:26]customerPO:29
Else 
	If (Record number:C243([Order:3])>=0)
		vlInvoiceNum:=[Order:3]orderNum:2
		vscustomerID:=[Order:3]customerID:1
		vrSalesTax:=[Order:3]salesTax:28
		vsCustPONum:=[Order:3]customerPO:3
	Else 
		//I don't think there will ever be an existing payment here     
		If (Record number:C243([Payment:28])>=0)
			If ([Payment:28]invoiceNum:3>0)
				vlInvoiceNum:=[Payment:28]invoiceNum:3
			Else 
				vlInvoiceNum:=[Payment:28]orderNum:2
			End if 
			vscustomerID:=[Payment:28]customerID:4
			vrSalesTax:=[Payment:28]salesTax:32
			vsCustPONum:=[Payment:28]customerPO:33
		Else 
			vlInvoiceNum:=0
			vscustomerID:=""
			vrSalesTax:=0
			vsCustPONum:=""
		End if 
	End if 
End if 
C_LONGINT:C283(viPayAddWin)
viPayAddWin:=2  //Inital Value, clears the Layout Vars
pvPayResponseCode:=-1
Repeat 
	Open window:C153(150; 100; 625+150; 425+100)  //551
	DIALOG:C40([Payment:28]; "diaMakePay")
	CLOSE WINDOW:C154
	// TRACE
	If (viPayAddWin=1)
		vOrdNum:=vOrdNum
		pPayment:=pPayment
		prntAttn:=prntAttn
		pvCity:=pvCity
		pPayment:=pPayment
		Auth_PrepMacAth(False:C215)
		//TRACE
		Case of 
			: (pvPayResponseCode=1)
				viPayAddWin:=0
				myOK:=1
			: ($testWindow=1)
				viPayAddWin:=0
			: ((pvCardAction#"Sale@") & (pvCardAction#"") & (pvCardAction#"Credit@") & (pvCardAction#"Auth@"))
				myOK:=0
		End case 
	End if 
Until (viPayAddWin=0)
If ((<>tcCcDevice=<>ciCCDevZjMd) | (<>tcCcDevice=<>ciCCDevZjPr))  //Zon process running
	CC_ZonClearPort
End if 
vDiaCom:=""
If (myOK=1)
	myOK:=0
	$madePay:=False:C215
	$discount:=Round:C94(pDiff*bCredit; <>tcDecimalTt)  ///
	If ((pPayment#0) | (pPayRecordAuth>0))
		C_LONGINT:C283(pPayRecordAuth)
		pPayRecordAuth:=0
		Case of 
			: (myCycle=22)  // coming from multiple records in applyPayment window
				$available:=pPayment
				$applyInv:=0
			: (($1#1) | (Locked:C147([Invoice:26])))
				$available:=pPayment
				$applyInv:=0
			: ((Round:C94([Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)>=pPayment) & ([Invoice:26]balanceDue:44>=0))
				$available:=0
				$applyInv:=pPayment
			: ((Round:C94([Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)<=pPayment) & ([Invoice:26]balanceDue:44<0))
				$available:=0
				$applyInv:=pPayment
			: ((Round:C94([Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)<pPayment) & ([Invoice:26]balanceDue:44>=0))
				$available:=Round:C94(pPayment-[Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)
				$applyInv:=Round:C94([Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)
			: ((Round:C94([Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)>=pPayment) & ([Invoice:26]balanceDue:44<0))
				$available:=Round:C94(pPayment-[Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)
				$applyInv:=Round:C94([Invoice:26]balanceDue:44-$discount; <>tcDecimalTt)
		End case 
		Pay_Main($1; $2; pPayment; $available)
		$madePay:=True:C214
		PUSH RECORD:C176([Payment:28])
	End if 
	If (pDiffCurr#0)  //discount currency difference ((rExchRate#1)&(rExchRate#0)) not needed
		Pay_AddCredit(pDiffCurr; 3; vOrdNum; vInvNum; [Customer:2]customerID:1; "Currency"; rExchRate; strCurrency)
		$madePay:=True:C214
		$myAmount:=pPayment
	End if 
	If ($discount#0)
		Pay_AddCredit($discount; $1; vOrdNum; vInvNum; [Customer:2]customerID:1; "AR Credit"; rExchRate; strCurrency)
		[Customer:2]balanceCurrent:41:=Round:C94([Customer:2]balanceCurrent:41-[Payment:28]amount:1; <>tcDecimalTt)  //apply credit to cust.  
		$madePay:=True:C214
	End if 
	If ($madePay)
		POP RECORD:C177([Payment:28])
		If ($1=1)  //from an invoice or ApplyPay window
			//LOAD RECORD([Invoice])  This will cause currency problems
			If (Locked:C147([Invoice:26]))
				ALERT:C41("Invoice locked, apply payment later.")
			Else 
				If (myCycle#22)
					[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46+$applyInv; $thePrec)
					[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45+$discount; $thePrec)
					[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]total:18-[Invoice:26]appliedAmount:46-[Invoice:26]appliedDiscount:45; $thePrec)
					PaidDaysCalc
					vMod:=True:C214
					If ((<>tcMONEYCHAR#strCurrency) & ([Invoice:26]exchangeRate:61#1) & ([Invoice:26]exchangeRate:61#0))
						$applyInv:=Round:C94($applyInv/[Invoice:26]exchangeRate:61; $thePrec)
					End if 
					TransAct_Create(1; -$applyInv)
					acceptInvoice(vMod)
					Case of 
						: ($2=1)  //from Apply Pay Window
							aUnPaid{aInvoices}:=[Invoice:26]balanceDue:44
							aInvDisApp{aInvoices}:=[Invoice:26]appliedDiscount:45
						: (($2=2) & (vHere>1))
							If ((([Invoice:26]exchangeRate:61#0) | ([Invoice:26]exchangeRate:61#1)) & ([Invoice:26]currency:62#""))
								Exch_FillRays
								vMod:=calcInvoice(True:C214)
							End if 
					End case 
				End if 
			End if 
			SAVE RECORD:C53([Customer:2])
		End if 
		If (<>doCCShowPayOnApprove)
			DB_ShowCurrentSelection(->[Payment:28]; ""; 1; "")  //tablePt, script, flowBranch, Title
		End if 
	End if 
Else 
	pPayment:=0
	pDiff:=0
	pDiffCurr:=0
End if 
pDateRcd:=!00-00-00!
bCredit:=0  //must reset or other actions in pay window will duplicate
P_PayHeaderVars(-1)