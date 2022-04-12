//%attributes = {"publishedWeb":true}


// Modified by: Bill James (2022-01-29T06:00:00Z)
// Method: SRpt_StRayFill
// Description 
// Parameters
// ----------------------------------------------------
// MustFixQQQZZZ: Bill James (2022-01-30T06:00:00Z)
// clean this all up some time

//Procedure: SRpt_StRayFill
C_LONGINT:C283($i; $k)
C_TEXT:C284(prntTimes; prntTypeSal; $payType)
C_TEXT:C284($crStr)
C_TEXT:C284($payStr)
C_LONGINT:C283($i; $daysOld)
C_DATE:C307($monBeg)
C_REAL:C285($total)
C_LONGINT:C283($1)
If (Count parameters:C259=0)
	$doAllMon:=True:C214
Else 
	$doAllMon:=($1=1)
End if 
READ ONLY:C145([Default:15])
QUERY:C277([Default:15]; [Default:15]primeDefault:176=1)
SRpt_StRayClr(0)
$crStr:="###,###,##0.00  ;###,###,##0.00cr"
If ([Customer:2]contactBillTo:92>0)
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Customer:2]contactBillTo:92)
Else 
	REDUCE SELECTION:C351([Contact:13]; 0)
End if 
CustAddress:=PVars_AddressFull("Customer")
MainAddress:=PVars_AddressFull("Customer")
Case of 
	: (Record number:C243([Contact:13])>-1)
		BillAddress:=PVars_AddressFull("Contact")
	: ([Customer:2]addrAltBillTo:77#"")
		BillAddress:=[Customer:2]addrAltBillTo:77
	Else 
		BillAddress:=MainAddress
End case 
MESSAGES OFF:C175
$monBeg:=Date_ThisMon(Current date:C33; 0)



//Ledger_TallyBal(ds.Customer.query("id = :1";)
//DaysPastDueOne 
If ([Customer:2]repID:58#[Rep:8]repID:1)
	QUERY:C277([Rep:8]; [Rep:8]repID:1=[Customer:2]repID:58)
	prntRep:=[Rep:8]company:2
	prntPhone:=Format_Phone([Rep:8]phone:10)
End if 
//
SORT ARRAY:C229(aDate1; aDate2; aDate3; a25Str1; a25Str2; aTmp20Str1; aTmp20Str2; aLongInt1; aLongInt2; aLongInt3; a3Str1; aReal1; aReal2; aReal3; aReal4; aReal5; aReal6; aReal7; aReal8)
UNLOAD RECORD:C212([Payment:28])
UNLOAD RECORD:C212([Invoice:26])
$k:=Size of array:C274(aReal2)
For ($i; 1; $k)
	$total:=$total+aReal2{$i}
End for 
prntTotal:=String:C10($total; $crStr)
Case of 
	: (([Customer:2]balPastPeriod3:45>0) & ($total>0))
		If (vOverDueBy#"Over 90 Days")
			vHeading:=[Default:15]headingPrd3:38
			vClosing:=[Default:15]closingPrd3:39
			vOverDueBy:="Over Due 90 Days"
		End if 
	: (([Customer:2]balPastPeriod2:44>0) & ($total>0))
		If (vOverDueBy#"Over 60 Days")
			vHeading:=[Default:15]headingPrd2:36
			vClosing:=[Default:15]closingPrd2:37
			vOverDueBy:="Over Due 60 Days"
		End if 
	: (([Customer:2]balPastPeriod1:43>0) & ($total>0))
		If (vOverDueBy#"Over 30 Days")
			vHeading:=[Default:15]headingPrd1:34
			vClosing:=[Default:15]closingPrd1:35
			vOverDueBy:="Over Due 30 Days"
		End if 
	Else 
		QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="No Due"; *)
		QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="Statement Comments")
		vOverDueBy:="Currently Open"
		If (Records in selection:C76([TallyResult:73])=1)
			vHeading:=[TallyResult:73]textBlk1:5
			vClosing:=[TallyResult:73]textBlk2:6
		Else 
			vHeading:="Thank you for keeping your account current, list of unpaid Invoices and "+"unapplied payments."
			vClosing:="Please contact us if there are questions."
		End if 
End case 
[Customer:2]lateNotice:64:=Current date:C33
SAVE RECORD:C53([Customer:2])
UNLOAD RECORD:C212([Default:15])