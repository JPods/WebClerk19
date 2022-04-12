//%attributes = {"publishedWeb":true}
If (False:C215)
	//07/30/02:janani
	// added array a25Str2 to include [Payment]Comment in report  
End if 
//Procedure: SRpt_StatLines
C_LONGINT:C283($1)
C_REAL:C285(<>vrFinanceChargePC)
If (<>vrFinanceChargePC=0)
	<>vrFinanceChargePC:=1.5
End if 
aLongInt1{$1}:=[Ledger:30]idNum:2  //Ledger ID
aLongInt2{$1}:=[Ledger:30]docRefid:4  //InvoiceKey/Payment Key
Case of 
	: ([Ledger:30]tableNum:3=26)
		QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[Ledger:30]docRefid:4)
		aTmp20Str1{$1}:=String:C10([Ledger:30]docRefid:4; "0000-0000")
		a25Str1{$1}:=[Invoice:26]customerPO:29
		a25Str2{$1}:=""
		aDate3{$1}:=Invc_AlterDate
		UNLOAD RECORD:C212([Invoice:26])
		a3Str1{$1}:="Inv"
		
	: (Abs:C99([Ledger:30]tableNum:3)=28)
		QUERY:C277([Payment:28]; [Payment:28]idNum:8=[Ledger:30]docRefid:4)
		aDate3{$1}:=[Ledger:30]dateDue:5  //[Payment]DateReceived
		aTmp20Str1{$1}:=""
		Case of 
			: ([Payment:28]checkNum:12#"")
				a25Str1{$1}:=[Payment:28]checkNum:12
			: (Num:C11([Payment:28]cardApproval:15)>0)
				a25Str1{$1}:=[Payment:28]cardApproval:15
			: ([Payment:28]comment:5#"")
				a25Str1{$1}:=[Payment:28]comment:5
		End case 
		a25Str2{$1}:=[Payment:28]comment:5
		UNLOAD RECORD:C212([Payment:28])
		a3Str1{$1}:="Pay"
		
	Else 
		a3Str1{$1}:="???"
End case 
aTmp20Str2{$1}:=[Ledger:30]terms:10
If ([Ledger:30]tableName:13="")
	Case of 
		: (a3Str1{$1}="Pay")
			[Ledger:30]tableName:13:="Payment"
			SAVE RECORD:C53([Ledger:30])
		: (a3Str1{$1}="Inv")
			[Ledger:30]tableName:13:="Invoice"
			SAVE RECORD:C53([Ledger:30])
	End case 
End if 
aTmp20Str3{$1}:=[Ledger:30]tableName:13
aDate1{$1}:=[Ledger:30]dateDocument:14  //DateShip/Date Pay
aDate2{$1}:=[Ledger:30]dateDue:5  //DateShip/Date Pay
aLongInt3{$1}:=Current date:C33-aDate2{$1}
aTmpInt1{$1}:=[Ledger:30]tableNum:3
aReal1{$1}:=[Ledger:30]origValue:11  //Total/PayAmount
aReal2{$1}:=[Ledger:30]unAppliedValue:6  //Balance/Amount Avail
C_DATE:C307($curDate)
$curDate:=Current date:C33
aReal3{$1}:=0
aReal4{$1}:=0
aReal5{$1}:=0
aReal6{$1}:=0
aReal7{$1}:=0
If ((aLongInt3{$1}>0) & ([Ledger:30]unAppliedValue:6>0) & ([Ledger:30]tableNum:3=26))
	aReal8{$1}:=Round:C94(Round:C94(aLongInt3{$1}/30; 1)*[Ledger:30]unAppliedValue:6*<>vrFinanceChargePC*0.01; 2)
	vrFinanceCharge:=vrFinanceCharge+aReal8{$1}
Else 
	aReal8{$1}:=0
End if 
Case of 
	: (($curDate+30)<[Ledger:30]dateDue:5)  //future
		aReal3{$1}:=[Ledger:30]unAppliedValue:6
	: ($curDate<[Ledger:30]dateDue:5)  //current
		aReal4{$1}:=[Ledger:30]unAppliedValue:6
	: (($curDate-30)<[Ledger:30]dateDue:5)  //over 30
		aReal5{$1}:=[Ledger:30]unAppliedValue:6
	: (($curDate-60)<[Ledger:30]dateDue:5)  //over 60
		aReal6{$1}:=[Ledger:30]unAppliedValue:6
	Else   //: (($curDate-90)>[Ledger]DateDue)//over 90
		aReal7{$1}:=[Ledger:30]unAppliedValue:6
End case 