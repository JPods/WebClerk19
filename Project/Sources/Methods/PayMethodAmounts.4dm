//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PayMethodAmounts
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_POINTER:C301($1)
C_LONGINT:C283($cntParam; $cntPay; $incPay)
$cntParam:=Count parameters:C259
C_TEXT:C284($0; $3; $returnComment; $2; $fillerTxt; $4; $noQuery)
$returnComment:="No payments received"
$noQuery:=""
If ($cntParam>0)
	$fillerTxt:=$2
	If ($cntParam>1)
		$returnComment:=$3
		If ($cntParam>2)
			If ($4="No Query")
				$noQuery:=$4
			End if 
		End if 
	End if 
Else 
	$fillerTxt:=" "
End if 
//
If ($noQuery="")
	REDUCE SELECTION:C351([Payment:28]; 0)
	
	// Modified by: William James (2013-10-23T00:00:00)
	// would searach all payments if there was no order
	// or invoice was stand-a-lone
	Case of 
		: ($1=(->[Invoice:26]))
			If (Record number:C243([Invoice:26])>-1)
				If (([Order:3]orderNum:2#[Invoice:26]orderNum:1) & ([Invoice:26]orderNum:1>1))
					QUERY:C277([Order:3]; [Order:3]orderNum:2=[Invoice:26]orderNum:1)
				End if 
				QUERY:C277([Payment:28]; [Payment:28]invoiceNum:3=[Invoice:26]invoiceNum:2; *)
				If ([Invoice:26]orderNum:1>1)
					QUERY:C277([Payment:28];  | [Payment:28]orderNum:2=[Invoice:26]orderNum:1; *)
				End if 
				QUERY:C277([Payment:28])
			End if 
			pvPayMethod:="Order Total: "+String:C10([Order:3]total:27; "###,##0.00")+"\r"
		: ($1=(->[Order:3]))
			If (Record number:C243([Order:3])>-1)
				QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
			End if 
		: ($1=(->[WorkOrder:66]))
			If ([WorkOrder:66]idNumTask:22>1)
				QUERY:C277([Order:3]; [Order:3]idNumTask:85=[WorkOrder:66]idNumTask:22)
				QUERY:C277([Payment:28]; [Payment:28]orderNum:2=[Order:3]orderNum:2)
			End if 
	End case 
End if 
$cntPay:=Records in selection:C76([Payment:28])
If ($cntPay>0)
	For ($incPay; 1; $cntPay)
		//    
		$payMeth:=txt_FixLength([Payment:28]typePayment:6; $fillerTxt; "Left"; 4; 6)
		$payAmount:=txt_FixLength(String:C10([Payment:28]amount:1; "###,##0.00"); $fillerTxt; "Right"; 10; 12)
		Case of 
			: ([Payment:28]tenderClass:34=3)
				$payCheckLast4:=txt_FixLength([Payment:28]creditCardNum:13; $fillerTxt; "Right"; 6; 8)
			: ([Payment:28]tenderClass:34=4)
				$payCheckLast4:=txt_FixLength([Payment:28]checkNum:12; $fillerTxt; "Right"; 6; 8)
			: ([Payment:28]tenderClass:34=5)
				$payCheckLast4:=txt_FixLength([Payment:28]checkNum:12; $fillerTxt; "Right"; 6; 8)
			: (([Payment:28]tenderClass:34=1) | ([Payment:28]tenderClass:34=2))
				$payCheckLast4:=txt_FixLength([Payment:28]checkNum:12; $fillerTxt; "Right"; 6; 8)
			Else 
				$payCheckLast4:=txt_FixLength([Payment:28]checkNum:12; $fillerTxt; "Right"; 6; 8)
		End case 
		//
		NEXT RECORD:C51([Payment:28])
		$0:=$0+$payMeth+"  "+$payCheckLast4+"  "+$payAmount+"\r"
	End for 
Else 
	$0:=$returnComment
End if 
//