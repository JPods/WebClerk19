//%attributes = {"publishedWeb":true}
C_LONGINT:C283($inc; $ris; $ttlCnt)
ARRAY TEXT:C222(aText1; 0)
ARRAY TEXT:C222(aText2; 0)
ARRAY TEXT:C222(aText3; 0)
ARRAY TEXT:C222(aText4; 0)
ARRAY TEXT:C222(aText5; 0)
ARRAY TEXT:C222(aText6; 0)
ARRAY TEXT:C222(aText7; 0)
ARRAY TEXT:C222(aText8; 0)
ARRAY TEXT:C222(aText9; 0)
$ttlCnt:=0
QUERY:C277([Proposal:42]; [Proposal:42]projectNum:22=[Project:24]projectNum:1)
$ris:=Records in selection:C76([Proposal:42])
FIRST RECORD:C50([Proposal:42])
For ($inc; 1; $ris)
	$ttlCnt:=$ttlCnt+1
	INSERT IN ARRAY:C227(aText1; $ttlCnt)
	INSERT IN ARRAY:C227(aText2; $ttlCnt)
	INSERT IN ARRAY:C227(aText3; $ttlCnt)
	INSERT IN ARRAY:C227(aText4; $ttlCnt)
	INSERT IN ARRAY:C227(aText5; $ttlCnt)
	INSERT IN ARRAY:C227(aText6; $ttlCnt)
	INSERT IN ARRAY:C227(aText7; $ttlCnt)
	INSERT IN ARRAY:C227(aText8; $ttlCnt)
	INSERT IN ARRAY:C227(aText9; $ttlCnt)
	aText1{$ttlCnt}:="Proposal"
	aText2{$ttlCnt}:=String:C10([Proposal:42]proposalNum:5; "0000-0000")
	aText3{$ttlCnt}:=[Proposal:42]customerid:1
	aText4{$ttlCnt}:=[Proposal:42]company:11
	aText5{$ttlCnt}:=String:C10([Proposal:42]dateExpected:42; 1)
	aText6{$ttlCnt}:=[Proposal:42]status:2
	aText7{$ttlCnt}:=String:C10([Proposal:42]amount:26; "###,###,###,##0.00")
	aText8{$ttlCnt}:=String:C10([Proposal:42]totalCost:23; "###,###,###,##0.00")
	aText9{$ttlCnt}:=[Proposal:42]profile1:51
	NEXT RECORD:C51([Proposal:42])
End for 
//
QUERY:C277([Order:3]; [Order:3]projectNum:50=[Project:24]projectNum:1)
FIRST RECORD:C50([Order:3])
$ris:=Records in selection:C76([Order:3])
$lastCnt:=$ris+$ttlCnt
$startCnt:=$ttlCnt
For ($inc; $startCnt; $lastCnt)
	$ttlCnt:=$ttlCnt+1
	INSERT IN ARRAY:C227(aText1; $ttlCnt)
	INSERT IN ARRAY:C227(aText2; $ttlCnt)
	INSERT IN ARRAY:C227(aText3; $ttlCnt)
	INSERT IN ARRAY:C227(aText4; $ttlCnt)
	INSERT IN ARRAY:C227(aText5; $ttlCnt)
	INSERT IN ARRAY:C227(aText6; $ttlCnt)
	INSERT IN ARRAY:C227(aText7; $ttlCnt)
	INSERT IN ARRAY:C227(aText8; $ttlCnt)
	INSERT IN ARRAY:C227(aText9; $ttlCnt)
	aText1{$ttlCnt}:="Order"
	aText2{$ttlCnt}:=String:C10([Order:3]orderNum:2; "0000-0000")
	aText3{$ttlCnt}:=[Order:3]customerid:1
	aText4{$ttlCnt}:=[Order:3]company:15
	aText5{$ttlCnt}:=String:C10([Order:3]dateOrdered:4; 1)
	aText6{$ttlCnt}:=[Order:3]status:59
	aText7{$ttlCnt}:=String:C10([Order:3]amount:24; "###,###,###,##0.00")
	aText8{$ttlCnt}:=String:C10([Order:3]totalCost:42; "###,###,###,##0.00")
	aText9{$ttlCnt}:=[Order:3]profile1:61
	NEXT RECORD:C51([Order:3])
End for 
//
QUERY:C277([Invoice:26]; [Invoice:26]projectNum:50=[Project:24]projectNum:1)
$ris:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])
$lastCnt:=$ris+$ttlCnt
$startCnt:=$ttlCnt
For ($inc; $startCnt; $lastCnt)
	$ttlCnt:=$ttlCnt+1
	INSERT IN ARRAY:C227(aText1; $ttlCnt)
	INSERT IN ARRAY:C227(aText2; $ttlCnt)
	INSERT IN ARRAY:C227(aText3; $ttlCnt)
	INSERT IN ARRAY:C227(aText4; $ttlCnt)
	INSERT IN ARRAY:C227(aText5; $ttlCnt)
	INSERT IN ARRAY:C227(aText6; $ttlCnt)
	INSERT IN ARRAY:C227(aText7; $ttlCnt)
	INSERT IN ARRAY:C227(aText8; $ttlCnt)
	INSERT IN ARRAY:C227(aText9; $ttlCnt)
	aText1{$ttlCnt}:="Invoice"
	aText2{$ttlCnt}:=String:C10([Invoice:26]invoiceNum:2; "0000-0000")
	aText3{$ttlCnt}:=[Invoice:26]customerid:3
	aText4{$ttlCnt}:=[Invoice:26]company:7
	aText5{$ttlCnt}:=String:C10(Invc_PrimeDate; 1)
	aText6{$ttlCnt}:=String:C10([Invoice:26]balanceDue:44; "###,###,###,##0.00")
	aText7{$ttlCnt}:=String:C10([Invoice:26]amount:14; "###,###,###,##0.00")
	aText8{$ttlCnt}:=String:C10([Invoice:26]totalCost:37; "###,###,###,##0.00")
	aText9{$ttlCnt}:=[Invoice:26]profile1:53
	NEXT RECORD:C51([Invoice:26])
End for 
//
QUERY:C277([PO:39]; [PO:39]projectNum:6=[Project:24]projectNum:1)
$ris:=Records in selection:C76([PO:39])
FIRST RECORD:C50([PO:39])
$lastCnt:=$ris+$ttlCnt
$startCnt:=$ttlCnt
For ($inc; $startCnt; $lastCnt)
	$ttlCnt:=$ttlCnt+1
	INSERT IN ARRAY:C227(aText1; $ttlCnt)
	INSERT IN ARRAY:C227(aText2; $ttlCnt)
	INSERT IN ARRAY:C227(aText3; $ttlCnt)
	INSERT IN ARRAY:C227(aText4; $ttlCnt)
	INSERT IN ARRAY:C227(aText5; $ttlCnt)
	INSERT IN ARRAY:C227(aText6; $ttlCnt)
	INSERT IN ARRAY:C227(aText7; $ttlCnt)
	INSERT IN ARRAY:C227(aText8; $ttlCnt)
	INSERT IN ARRAY:C227(aText9; $ttlCnt)
	aText1{$ttlCnt}:="PO"
	aText2{$ttlCnt}:=String:C10([PO:39]poNum:5; "0000-0000")
	aText3{$ttlCnt}:=[PO:39]vendorid:1
	aText4{$ttlCnt}:=[PO:39]shipToCompany:8
	aText5{$ttlCnt}:=String:C10([PO:39]dateOrdered:2; 1)
	aText6{$ttlCnt}:=String:C10([PO:39]orderNum:18; "0000-0000")
	aText7{$ttlCnt}:=String:C10([PO:39]amount:19; "###,###,###,##0.00")
	aText8{$ttlCnt}:=String:C10([PO:39]amountBackLog:25; "###,###,###,##0.00")
	aText9{$ttlCnt}:=[PO:39]shipInstruct:31
	NEXT RECORD:C51([PO:39])
End for 
//
QUERY:C277([Service:6]; [Service:6]projectNum:28=[Project:24]projectNum:1)
$ris:=Records in selection:C76([Service:6])
FIRST RECORD:C50([Service:6])
$lastCnt:=$ris+$ttlCnt
$startCnt:=$ttlCnt
For ($inc; $startCnt; $lastCnt)
	$ttlCnt:=$ttlCnt+1
	INSERT IN ARRAY:C227(aText1; $ttlCnt)
	INSERT IN ARRAY:C227(aText2; $ttlCnt)
	INSERT IN ARRAY:C227(aText3; $ttlCnt)
	INSERT IN ARRAY:C227(aText4; $ttlCnt)
	INSERT IN ARRAY:C227(aText5; $ttlCnt)
	INSERT IN ARRAY:C227(aText6; $ttlCnt)
	INSERT IN ARRAY:C227(aText7; $ttlCnt)
	INSERT IN ARRAY:C227(aText8; $ttlCnt)
	INSERT IN ARRAY:C227(aText9; $ttlCnt)
	aText1{$ttlCnt}:="Service"
	aText2{$ttlCnt}:=String:C10([Service:6]idNum:26; "0000-0000")
	aText3{$ttlCnt}:=[Service:6]customerid:1
	aText4{$ttlCnt}:=[Service:6]actionBy:12
	aText5{$ttlCnt}:=String:C10(jDateTimeRDate([Service:6]dtAction:35); 1)
	aText6{$ttlCnt}:=Num:C11([Service:6]complete:17)*"Completed"
	aText7{$ttlCnt}:=[Service:6]action:20
	aText8{$ttlCnt}:=[Service:6]noteType:21
	aText9{$ttlCnt}:=String:C10([Service:6]costToCustomer:8; "###,###,###,##0.00")
	NEXT RECORD:C51([Service:6])
End for 