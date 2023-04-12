//%attributes = {"publishedWeb":true}
//  List_FlowOnHand (eItemOrd;aOItemNum{aoLineAction})
//November 19, 1995  3:13 PM
MESSAGES OFF:C175
C_LONGINT:C283($1; $e; $k; $i; $cntAll; $currCnt)
C_POINTER:C301($2)
C_TEXT:C284($theItem)

READ ONLY:C145([Item:4])
QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->)
$theItem:=$2->
QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=$2->; *)
QUERY:C277([OrderLine:49];  & [OrderLine:49]qtyBackLogged:8#0)
QUERY:C277([POLine:40]; [POLine:40]itemNum:2=$2->; *)
QUERY:C277([POLine:40];  & [POLine:40]qtyBackLogged:5#0)
QUERY:C277([WorkOrder:66]; [WorkOrder:66]itemNum:12=$2->; *)
QUERY:C277([WorkOrder:66];  & [WorkOrder:66]dtComplete:6=0)
$cntAll:=Records in selection:C76([OrderLine:49])+Records in selection:C76([POLine:40])+Records in selection:C76([WorkOrder:66])
If (($cntAll=0) & (Records in selection:C76([Item:4])=0))
	jAlertMessage(9201)
Else 
	List_RaySize($cntAll)
	$k:=Records in selection:C76([OrderLine:49])
	FIRST RECORD:C50([OrderLine:49])
	For ($i; 1; $k)
		aLsDocType{$i}:="ol"
		aLsItemNum{$i}:=String:C10([OrderLine:49]idNumOrder:1; "0000-0000")
		aLsItemDesc{$i}:=[OrderLine:49]customerID:2
		aLsQtyOH{$i}:=-[OrderLine:49]qtyBackLogged:8
		aLsQtyPO{$i}:=DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP)
		aLsDate{$i}:=[OrderLine:49]dateShipOn:38
		aLsText1{$i}:=[OrderLine:49]company:41
		aLsSrRec{$i}:=-1  //Record number([Item])
		//
		aLsQtySO{$i}:=0
		aLsPrice{$i}:=0
		aLsCost{$i}:=0
		aLsMargin{$i}:=0
		aLsLeadTime{$i}:=0
		aLsText2{$i}:=""
		aLsDiscount{$i}:=0
		aLsDiscountPrice{$i}:=0
		NEXT RECORD:C51([OrderLine:49])
	End for 
	$currCnt:=$k
	REDUCE SELECTION:C351([OrderLine:49]; 0)
	//
	$e:=$currCnt  //Records in selection([OrdLine])
	$k:=Records in selection:C76([POLine:40])
	$currCnt:=$currCnt+$k
	$i:=0
	FIRST RECORD:C50([POLine:40])
	While ($i<$k)
		$i:=$i+1
		$e:=$e+1
		aLsDocType{$e}:="pl"
		aLsItemNum{$e}:=String:C10([POLine:40]idNumPO:1; "0000-0000")
		aLsItemDesc{$e}:=[POLine:40]refVendor:23  //vendor
		aLsQtyOH{$e}:=[POLine:40]qtyBackLogged:5
		aLsQtyPO{$e}:=DiscountApply([POLine:40]unitCost:7; [POLine:40]discount:8; <>tcDecimalUP)
		aLsDate{$e}:=[POLine:40]dateExpected:15  //date expected
		aLsText1{$e}:=[POLine:40]refCustomer:22  //ref cust
		aLsSrRec{$e}:=-1  //Record number([Item])
		//
		aLsQtySO{$e}:=0
		aLsPrice{$e}:=0
		aLsCost{$e}:=0
		aLsMargin{$e}:=0
		aLsLeadTime{$e}:=0
		aLsText2{$e}:=""
		aLsDiscount{$e}:=0
		aLsDiscountPrice{$e}:=0
		NEXT RECORD:C51([POLine:40])
	End while 
	REDUCE SELECTION:C351([POLine:40]; 0)
	//
	$e:=$currCnt
	$k:=Records in selection:C76([WorkOrder:66])
	$i:=0
	FIRST RECORD:C50([WorkOrder:66])
	While ($i<$k)
		$i:=$i+1
		$e:=$e+1
		aLsDocType{$e}:="WO"
		aLsItemNum{$e}:=String:C10([WorkOrder:66]idNum:29; "0000-0000")
		aLsItemDesc{$e}:=[WorkOrder:66]activity:7  //vendor
		aLsQtyOH{$e}:=[WorkOrder:66]qtyOrdered:13
		aLsQtyPO{$e}:=Round:C94([WorkOrder:66]unitCost:19; <>tcDecimalUP)
		DateTime_DTFrom([WorkOrder:66]dtAction:5; ->aLsDate{$e})
		aLsText1{$e}:=[WorkOrder:66]actionBy:8  //ref cust
		aLsSrRec{$e}:=-1  //Record number([Item])
		//
		aLsQtySO{$e}:=0
		aLsPrice{$e}:=0
		aLsCost{$e}:=0
		aLsMargin{$e}:=0
		aLsLeadTime{$e}:=0
		aLsText2{$e}:=""
		aLsDiscount{$e}:=0
		aLsDiscountPrice{$e}:=0
		NEXT RECORD:C51([WorkOrder:66])
	End while 
	REDUCE SELECTION:C351([WorkOrder:66]; 0)
	//sort before filling in the item info
	SORT ARRAY:C229(aLsDate; aLsDocType; aLsItemNum; aLsItemDesc; aLsQtyOH; aLsQtySO; aLsQtyPO; aLsLeadTime; aLsText1; aLsText2; aLsMargin; aLsCost; aLsPrice; aLsSrRec)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$theItem)
	List_RaySize(1; 1)
	$e:=1
	aLsDocType{$e}:="Itm"
	aLsItemNum{$e}:=[Item:4]itemNum:1
	aLsItemDesc{$e}:=[Item:4]description:7
	aLsQtyOH{$e}:=[Item:4]qtyOnHand:14
	aLsQtySO{$e}:=[Item:4]qtyOnHand:14
	aLsLeadTime{$e}:=[Item:4]leadTimePo:55
	aLsDate{$e}:=!00-00-00!
	aLsText1{$e}:=[Item:4]alertMessage:52
	aLsSrRec{$e}:=Record number:C243([Item:4])
	//
	aLsPrice{$i}:=0
	aLsCost{$i}:=0
	aLsMargin{$i}:=0
	aLsText2{$i}:=""
	aLsDiscount{$i}:=0
	aLsDiscountPrice{$i}:=0
	//
	$last:=0
	$cntAll:=$cntAll+1
	For ($i; 2; $cntAll)
		$last:=$last+1
		aLsQtySO{$i}:=aLsQtySO{$last}+aLsQtyOH{$i}  //running
	End for 
	// -- AL_SetHeaders($1; 1; 8; "T"; "Ref"; "Desc/Cust/Vend"; "Qty"; "Balance"; ""; ""; "")
	// -- AL_SetHeaders($1; 9; 8; ""; ""; ""; ""; "Date"; "Alert/Ref Cust"; ""; "")
	// -- AL_SetWidths($1; 1; 8; 25; <>wAlAcctNum; 69; 38; 38; 32; 3; 3)
	// -- AL_SetWidths($1; 9; 8; 3; 3; 3; 3; <>wAlDate; 200; 200; 3)
	//// -- AL_SetSort ($1;-11)//sorted before it is filled
	//// -- AL_SetRowColor ($1;0;"Black";0;"white";0)
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
	MESSAGES ON:C181
End if 
//
If ((ptCurTable=(->[PO:39])) & (Record number:C243([PO:39])>-1))
	QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
End if 
If ((ptCurTable=(->[Order:3])) & (Record number:C243([Order:3])>-1))
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
End if 
//Temp_RayInit 
READ WRITE:C146([Item:4])

If ($1>0)
	//  --  CHOPPED  AL_UpdateArrays($1; -2)
End if 