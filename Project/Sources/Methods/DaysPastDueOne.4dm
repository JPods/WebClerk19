//%attributes = {"publishedWeb":true}
C_LONGINT:C283($w; $dueDays; $ivcDays; $i; $daysOld)
MESSAGES OFF:C175
QUERY:C277([Payment:28]; [Payment:28]customerid:4=[Customer:2]customerID:1; *)
QUERY:C277([Payment:28];  & [Payment:28]amountAvailable:19#0)
QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1; *)
QUERY:C277([Invoice:26];  & [Invoice:26]balanceDue:44#0)
If (([Customer:2]balanceCurrent:41#0) | ([Customer:2]balanceDue:42#0) | ([Customer:2]balPastPeriod1:43#0) | ([Customer:2]balPastPeriod2:44#0) | ([Customer:2]balPastPeriod3:45#0) | (Records in selection:C76([Invoice:26])#0) | (Records in selection:C76([Payment:28])#0))
	[Customer:2]balanceCurrent:41:=0
	[Customer:2]balanceDue:42:=0
	[Customer:2]balPastPeriod1:43:=0
	[Customer:2]balPastPeriod2:44:=0
	[Customer:2]balPastPeriod3:45:=0
	FIRST RECORD:C50([Payment:28])
	For ($i; 1; Records in selection:C76([Payment:28]))
		$daysOld:=Current date:C33-[Payment:28]dateReceived:10
		Case of 
			: ($daysOld<=30)
				[Customer:2]balanceCurrent:41:=[Customer:2]balanceCurrent:41-[Payment:28]amountAvailable:19
			: ($daysOld<=60)
				[Customer:2]balPastPeriod1:43:=[Customer:2]balPastPeriod1:43-[Payment:28]amountAvailable:19
			: ($daysOld<=90)
				[Customer:2]balPastPeriod2:44:=[Customer:2]balPastPeriod2:44-[Payment:28]amountAvailable:19
			Else 
				[Customer:2]balPastPeriod3:45:=[Customer:2]balPastPeriod3:45-[Payment:28]amountAvailable:19
		End case 
		NEXT RECORD:C51([Payment:28])
	End for 
	FIRST RECORD:C50([Invoice:26])
	For ($i; 1; Records in selection:C76([Invoice:26]))
		$daysOld:=Invc_DaysPastDu
		Case of 
			: ($daysOld<=0)
				[Customer:2]balanceCurrent:41:=[Customer:2]balanceCurrent:41+[Invoice:26]balanceDue:44
			: ($daysOld<=30)
				[Customer:2]balPastPeriod1:43:=[Customer:2]balPastPeriod1:43+[Invoice:26]balanceDue:44
			: ($daysOld<=60)
				[Customer:2]balPastPeriod2:44:=[Customer:2]balPastPeriod2:44+[Invoice:26]balanceDue:44
			Else 
				[Customer:2]balPastPeriod3:45:=[Customer:2]balPastPeriod3:45+[Invoice:26]balanceDue:44
		End case 
		NEXT RECORD:C51([Invoice:26])
	End for 
	[Customer:2]balanceDue:42:=[Customer:2]balanceCurrent:41+[Customer:2]balPastPeriod1:43+[Customer:2]balPastPeriod2:44+[Customer:2]balPastPeriod3:45
	If ([Customer:2]balanceDue:42>[Customer:2]highCredit:38)
		[Customer:2]highCredit:38:=[Customer:2]balanceDue:42
	End if 
End if 
[Customer:2]tallyStatus:74:=False:C215
MESSAGES ON:C181