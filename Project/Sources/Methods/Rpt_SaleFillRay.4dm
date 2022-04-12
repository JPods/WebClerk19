//%attributes = {"publishedWeb":true}
//Procedure: Rpt_SaleFillRay
//from the sales evaluation window
C_POINTER:C301($1; $2; $3; $4; $5)  //array;date1;date2;account value;acctFldPp;acctFldOrd;acctFldInv
C_TEXT:C284($format)
MESSAGES OFF:C175
$format:="###,###,###.00"
C_REAL:C285($amount; $amountPC; $amountWon; $gmWonDol; $gmWonPC; $gmOthDol; $gmDolPC; $gmAll)
C_REAL:C285($amount; $cost; $amountBL; $cntBL; $cancel)

READ ONLY:C145([Order:3])
READ ONLY:C145([Service:6])
READ ONLY:C145([Rep:8])
READ ONLY:C145([Employee:19])
READ ONLY:C145([Invoice:26])
READ ONLY:C145([CallReport:34])
READ ONLY:C145([Proposal:42])
READ ONLY:C145([Lead:48])
READ ONLY:C145([Time:56])
If (b1=1)
	$amount:=0
	$amountPC:=0
	$amountWon:=0
	$gmWonDol:=0
	$gmWonPC:=0
	$gmOthDol:=0
	$gmDolPC:=0
	$gmAll:=0
	QUERY:C277([Proposal:42]; [Proposal:42]dateProposed:3>=$2->; *)
	QUERY:C277([Proposal:42];  & [Proposal:42]dateProposed:3<=$3->; *)
	If (Count parameters:C259>3)
		QUERY:C277(Table:C252(Table:C252($5))->;  & $5->=$4->; *)
	End if 
	TRACE:C157
	QUERY:C277([Proposal:42])
	$k:=Records in selection:C76([Proposal:42])
	FIRST RECORD:C50([Proposal:42])
	For ($i; 1; Records in selection:C76([Proposal:42]))
		$amount:=$amount+[Proposal:42]amount:26
		//     $gmAll:=$gmAll+[Proposal]AmountCost
		If ([Proposal:42]status:2="Won")
			$amountWon:=$amountWon+[Proposal:42]amount:26
			$gmWonDol:=$gmWonDol+([Proposal:42]amount:26-[Proposal:42]totalCost:23)
		Else 
			$amountPC:=$amountPC+([Proposal:42]amount:26*[Proposal:42]probability:43*0.01)
			$gmDolPC:=$gmWonDol+([Proposal:42]amount:26-[Proposal:42]totalCost:23)
		End if 
		NEXT RECORD:C51([Proposal:42])
	End for 
	$1->{11}:=String:C10($k; $format)  //"Pp Count"
	$1->{12}:=String:C10($amount; $format)  //"Pp Value"
	If ($k>0)
		$1->{13}:=String:C10(($amount\$k); $format)  //"Pp Avg"
	Else 
		$1->{13}:=String:C10(0; $format)  //"Pp Avg"
	End if 
	$1->{14}:=String:C10(($amountPC+$amountWon); $format)  //"Pp x %"
	$1->{15}:=String:C10($amountWon; $format)  //"Pp 'Won'"
	$1->{16}:=String:C10($gmWonDol; $format)  //"Pp Gross $ 'Won'"
	If ($amountWon#0)
		$1->{17}:=String:C10($gmWonDol/$amountWon*100; $format)  //"Pp Gross % 'Won'"
	Else 
		$1->{17}:=String:C10(0; $format)
	End if 
	$1->{18}:=String:C10($amountPC; $format)
	If ($amountPC#0)
		$1->{19}:=String:C10($gmDolPC/$amountPC*100; $format)  //"Pp Gross % other"
	Else 
		$1->{19}:=String:C10(0; $format)
	End if 
	//
	QUERY:C277([Proposal:42]; [Proposal:42]dateExpected:42>=$2->; *)
	QUERY:C277([Proposal:42];  & [Proposal:42]dateExpected:42<=$3->)
	$1->{20}:=String:C10(Records in selection:C76([Proposal:42]); $format)
	$1->{21}:=String:C10(Sum:C1([Proposal:42]amount:26); $format)
	//
	QUERY:C277([Proposal:42]; [Proposal:42]dateOrdered:66>=$2->; *)
	QUERY:C277([Proposal:42];  & [Proposal:42]dateOrdered:66<=$3->)
	$1->{22}:=String:C10(Records in selection:C76([Proposal:42]); $format)
	$1->{23}:=String:C10(Sum:C1([Proposal:42]amount:26); $format)
	//
	$amount:=0
	$cost:=0
	$amountBL:=0
	$cntBL:=0
	$cancel:=0
	QUERY:C277([Order:3]; [Order:3]dateOrdered:4>=$2->; *)
	QUERY:C277([Order:3];  & [Order:3]dateOrdered:4<=$3->; *)
	If (Count parameters:C259>3)
		QUERY:C277([Order:3];  & $6->=$4->; *)
	End if 
	QUERY:C277([Order:3])
	$k:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	For ($i; 1; Records in selection:C76([Order:3]))
		$amount:=$amount+[Order:3]amount:24
		$cost:=$cost+[Order:3]totalCost:42
		If ([Order:3]amountBackLog:54#0)
			$amountBL:=$amountBL+[Order:3]amountBackLog:54
			$cntBL:=$cntBL+1
		End if 
		$cancel:=$cancel+[Order:3]amountCancel:60
		NEXT RECORD:C51([Order:3])
	End for 
	$1->{24}:=String:C10($k; $format)  //"Ord Count"
	$1->{25}:=String:C10($amount; $format)  //"Ord Value"
	If ($k>0)
		$1->{26}:=String:C10(($amount\$k); $format)  //"Ord Avg"
	Else 
		$1->{26}:=String:C10(0; $format)  //"Ord Avg"
	End if 
	$1->{27}:=String:C10($cost; $format)  //"Ord"
	$1->{28}:=String:C10($amount-$cost; $format)  //Ord Gross $ "
	If ($amount#0)
		$1->{29}:=String:C10(($amount-$cost)/$amount*100; $format)  //"Ord Gross %'"
	Else 
		$1->{29}:=String:C10(0; $format)
	End if 
	$1->{30}:=String:C10($cntBL; $format)  //Cnt BL
	$1->{31}:=String:C10($amountBL; $format)  //Ord Value BL"
	$1->{32}:=String:C10($cancel; $format)  //"Ord Cancel $
	//   
	$amount:=0
	$cost:=0
	$amountBL:=0
	$cntBL:=0
	//If (OptKey=0)
	QUERY:C277([Invoice:26]; <>ptInvoiceDateFld->>=$2->; *)
	QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=$3->; *)
	//Else 
	//QUERY([Invoice];<>ptInvoiceDateFld->>=$2->;*)
	//QUERY([Invoice];&<>ptInvoiceDateFld-><=$3->;*)
	//End if 
	If (Count parameters:C259>3)
		QUERY:C277([Invoice:26];  & $7->=$4->; *)
	End if 
	QUERY:C277([Invoice:26])
	$k:=Records in selection:C76([Invoice:26])
	FIRST RECORD:C50([Invoice:26])
	For ($i; 1; Records in selection:C76([Invoice:26]))
		$amount:=$amount+[Invoice:26]amount:14
		$cost:=$cost+[Invoice:26]totalCost:37
		If ([Order:3]amountBackLog:54#0)
			$amountBL:=$amountBL+[Invoice:26]balanceDue:44
			$cntBL:=$cntBL+1
		End if 
		NEXT RECORD:C51([Invoice:26])
	End for 
	$1->{33}:=String:C10($k; $format)  //"Inv Count"
	$1->{34}:=String:C10($amount; $format)  //"Inv Value"
	If ($k>0)
		$1->{35}:=String:C10(($amount\$k); $format)  //"Inv Avg"
	Else 
		$1->{35}:=String:C10(0; $format)  //"Inv Avg"
	End if 
	$1->{36}:=String:C10($cost; $format)  //"Inv"
	$1->{37}:=String:C10($amount-$cost; $format)  //Inv Gross $ "
	If ($amount#0)
		$1->{38}:=String:C10(($amount-$cost)/$amount*100; $format)  //"Inv Gross %'"
	Else 
		$1->{38}:=String:C10(0; $format)
	End if 
	$1->{39}:=String:C10($cntBL; $format)  //receivables
	$1->{40}:=String:C10($amountBL; $format)  //Ord Value BL"
	//        
	QUERY:C277([Customer:2]; [Customer:2]dateOpened:14>=$2->; *)
	QUERY:C277([Customer:2];  & [Customer:2]dateOpened:14<=$3->; *)
	If (Count parameters:C259>3)
		QUERY:C277([Customer:2];  & $8->=$4->; *)
	End if 
	QUERY:C277([Customer:2])
	$1->{3}:=String:C10(Records in selection:C76([Customer:2]); $format)
	If ((aBullets{4}#"") | (aBullets{5}#""))
		$total:=0
		$period:=0
		$days:=0
		$calls:=0
		$letters:=0
		$visits:=0
		$cntInAvg:=0
		FIRST RECORD:C50([Customer:2])
		For ($i; 1; Records in selection:C76([Customer:2]))
			If (aBullets{5}#"")
				QUERY:C277([Order:3]; [Order:3]customerid:1=[Customer:2]customerID:1)
				$total:=$total+Sum:C1([Order:3]amount:24)
			End if 
			If (aBullets{4}#"")
				QUERY:C277([Order:3]; [Order:3]customerid:1=[Customer:2]customerID:1; *)
				QUERY:C277([Order:3]; [Order:3]dateOrdered:4>=$2->; *)
				QUERY:C277([Order:3];  & [Order:3]dateOrdered:4<=$3->)
				$period:=$period+Sum:C1([Order:3]amount:24)
			End if 
			If (aBullets{6}#"")
				QUERY:C277([Order:3]; [Order:3]customerid:1=[Customer:2]customerID:1)
				ORDER BY:C49([Order:3]; [Order:3]dateOrdered:4)
				If (Records in selection:C76([Order:3])>0)
					FIRST RECORD:C50([Order:3])
					$days:=$days+[Order:3]dateOrdered:4-[Customer:2]dateOpened:14
					$cntInAvg:=$cntInAvg+1
				End if 
			End if 
			If ((aCustSales{7}#"") | (aCustSales{8}#"") | (aCustSales{9}#""))
				QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=2; *)
				QUERY:C277([CallReport:34]; [CallReport:34]customerID:1=[Customer:2]customerID:1)
				FIRST RECORD:C50([CallReport:34])
				For ($incRec; 1; Records in selection:C76([CallReport:34]))
					$calls:=$calls+Num:C11([CallReport:34]phoneBoolean:8)
					$letters:=$letters+Num:C11([CallReport:34]letter:9)
					$visits:=$visits+Num:C11([CallReport:34]visit:13)
					NEXT RECORD:C51([CallReport:34])
				End for 
			End if 
			
			NEXT RECORD:C51([Customer:2])
		End for 
		
		$1->{4}:=String:C10($period; $format)
		$1->{5}:=String:C10($total; $format)
		If ($cntInAvg>0)
			$1->{6}:=String:C10($days\$cntInAvg; $format)
		Else 
			$1->{6}:="No data"
		End if 
		$1->{7}:=String:C10($calls; $format)
		$1->{8}:=String:C10($letters; $format)
		$1->{9}:=String:C10($visits; $format)
		If (aBullets{10}#"")  //time
			QUERY:C277([Time:56]; [Time:56]dateIn:6>=$2->; *)
			QUERY:C277([Time:56];  & [Time:56]dateIn:6<=$3->; *)
			If (Count parameters:C259>3)
				QUERY:C277([Time:56];  & $9->=$4->; *)
			End if 
			QUERY:C277([Time:56])
			$1->{10}:=String:C10(Sum:C1([Time:56]lapseTime:8); $format)
		End if 
		If (aBullets{2}#"")
			QUERY:C277([Lead:48]; [Lead:48]dateEntered:21>=$2->; *)
			QUERY:C277([Lead:48];  & [Lead:48]dateEntered:21<=$3->; *)
			If (Count parameters:C259>3)
				QUERY:C277([Lead:48];  & $10->=$4->; *)
			End if 
			QUERY:C277([Lead:48])
			$1->{2}:=String:C10(Records in selection:C76([Lead:48]); $format)
		End if 
	End if 
End if 
READ WRITE:C146([Customer:2])
READ WRITE:C146([Order:3])
READ WRITE:C146([Service:6])
READ WRITE:C146([Rep:8])
READ WRITE:C146([Employee:19])
READ WRITE:C146([Invoice:26])
READ WRITE:C146([CallReport:34])
READ WRITE:C146([Proposal:42])
READ WRITE:C146([Lead:48])
READ WRITE:C146([Time:56])
MESSAGES ON:C181