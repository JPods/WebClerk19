C_LONGINT:C283($Status)
$doSecond:=False:C215
$doFirst:=False:C215
C_REAL:C285($changeValue)
$changeValue:=pPayment
If (Abs:C99(pTotal)<Abs:C99(pPayment))
	$Change:=Abs:C99(pTotal)
	If (bCredit=1)
		$doSecond:=True:C214
	End if 
Else 
	$Change:=Abs:C99(pPayment)
	pPayment:=0
	If (bCredit=1)
		$doFirst:=True:C214
	End if 
End if 
If (pTotal<0)
	$Change:=-$Change
End if 
TRACE:C157

If ($Change#0)
	If ($changeValue<0)
		$comStr:="***Invoice Credit Memo of "+String:C10($Change)+" applied from Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+" to "+String:C10(vi9; "0000-0000")
	Else 
		$comStr:="***Invoice transfer of "+String:C10($Change)+" from Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")+" to "+String:C10(vi6; "0000-0000")
	End if 
	[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]balanceDue:44+$Change; <>tcDecimalTt)
	[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46-$Change; <>tcDecimalTt)
	If ($doSecond)
		[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45+Round:C94(pDiff; <>tcDecimalTt); <>tcDecimalTt)
		[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]total:18-[Invoice:26]appliedAmount:46-[Invoice:26]appliedDiscount:45; <>tcDecimalTt)
		[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]total:18-[Invoice:26]balanceDue:44-[Invoice:26]appliedDiscount:45; <>tcDecimalTt)
	End if 
	PaidDaysCalc
	[Invoice:26]commentProcess:73:=[Invoice:26]commentProcess:73+"\r"+$comStr
	SAVE RECORD:C53([Invoice:26])
	C_LONGINT:C283($Inv1; $Inv2)
	C_TEXT:C284($CustID1; $CustID2)
	$Inv1:=[Invoice:26]invoiceNum:2
	$CustID1:=[Invoice:26]customerID:3
	Ledger_InvSave
	$i:=Find in array:C230(aInvoices; [Invoice:26]invoiceNum:2)
	aCredUnPaid{aCredIvc}:=[Invoice:26]balanceDue:44
	aCredDscAmt{aCredIvc}:=[Invoice:26]appliedDiscount:45
	aUnPaid{$i}:=[Invoice:26]balanceDue:44
	aInvDisApp{$i}:=[Invoice:26]appliedDiscount:45
	C_LONGINT:C283(viRecordPushed)
	POP RECORD:C177([Invoice:26])
	viRecordPushed:=-1
	//GOTO RECORD([Invoice];aInvRecs{aInvSelRec{1}})
	$Inv2:=[Invoice:26]invoiceNum:2
	$CustID2:=[Invoice:26]customerID:3
	TransAct_Create(2; $Change; ""; $Inv1; $CustID1)
	[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]balanceDue:44-$Change; <>tcDecimalTt)
	[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]appliedAmount:46+$Change; <>tcDecimalTt)
	If ($doFirst)
		[Invoice:26]appliedDiscount:45:=Round:C94([Invoice:26]appliedDiscount:45+Round:C94(pDiff; <>tcDecimalTt); <>tcDecimalTt)
		[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]total:18-[Invoice:26]appliedAmount:46-[Invoice:26]appliedDiscount:45; <>tcDecimalTt)
		[Invoice:26]appliedAmount:46:=Round:C94([Invoice:26]total:18-[Invoice:26]balanceDue:44-[Invoice:26]appliedDiscount:45; <>tcDecimalTt)
	End if 
	PaidDaysCalc
	//  ********
	[Invoice:26]commentProcess:73:=[Invoice:26]commentProcess:73+"\r"+$comStr
	SAVE RECORD:C53([Invoice:26])
	Ledger_InvSave
	aUnpaid{vi6}:=[Invoice:26]balanceDue:44
	aInvDisApp{vi6}:=[Invoice:26]appliedDiscount:45
End if 
If (bCredit=1)
	CREATE RECORD:C68([Payment:28])
	
	[Payment:28]amount:1:=Round:C94(pDiff; <>tcDecimalTt)
	[Payment:28]orderNum:2:=[Payment:28]orderNum:2
	[Payment:28]invoiceNum:3:=[Payment:28]invoiceNum:3
	[Payment:28]customerID:4:=[Payment:28]customerID:4
	[Payment:28]complete:17:=False:C215
	[Payment:28]dateReceived:10:=Current date:C33
	[Payment:28]timeReceived:52:=Current time:C178
	[Payment:28]typePayment:6:="AR Credit"
	[Payment:28]checkNum:12:=""
	[Payment:28]creditCardNum:13:=""
	[Payment:28]dateExpires:14:=!00-00-00!
	[Payment:28]cardApproval:15:=""
	[Payment:28]bankFrom:9:="Credit"
	[Payment:28]nameOnAcct:11:=prntAttn
	[Payment:28]comment:5:="Credit equal to Dif"
	[Payment:28]amountAvailable:19:=0
	If (pDiff>0)
		GOTO RECORD:C242([Invoice:26]; vDebitInv)
	End if 
	SAVE RECORD:C53([Payment:28])
	Ledger_PaySave
	TransAct_Create(1; [Payment:28]amount:1; "AR Credit")
	aUnPaid{aInvoices}:=[Invoice:26]balanceDue:44
End if 
pPayment:=0
pTotal:=0
pDiff:=0
CANCEL:C270