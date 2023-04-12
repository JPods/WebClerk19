//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; bCalcOrders)
C_REAL:C285($value; $cost)
If (Not:C34(Locked:C147([AdSource:35])))
	READ ONLY:C145([Invoice:26])
	If (([AdSource:35]dateCalcBegin:5=!00-00-00!) | ([AdSource:35]dateCalcEnd:6=!00-00-00!))
		QUERY:C277([Invoice:26]; [Invoice:26]adSource:52=[AdSource:35]marketEffort:2)
	Else 
		QUERY:C277([Invoice:26]; [Invoice:26]adSource:52=[AdSource:35]marketEffort:2; *)
		QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld->>=[AdSource:35]dateCalcBegin:5; *)
		QUERY:C277([Invoice:26];  & <>ptInvoiceDateFld-><=[AdSource:35]dateCalcEnd:6)
	End if 
	//
	CREATE EMPTY SET:C140([Customer:2]; "Current")
	ORDER BY:C49([Invoice:26]; [Invoice:26]customerID:3)
	FIRST RECORD:C50([Invoice:26])
	$k:=Records in selection:C76([Invoice:26])
	$theAcct:=""
	For ($i; 1; $k)
		If ([Invoice:26]customerID:3#$theAcct)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
			ADD TO SET:C119([Customer:2]; "Current")
			$theAcct:=[Invoice:26]customerID:3
		End if 
		NEXT RECORD:C51([Invoice:26])
	End for 
	//
	[AdSource:35]valueInvAct:9:=Round:C94(Sum:C1([Invoice:26]amount:14); 0)
	[AdSource:35]numInvAct:8:=Records in selection:C76([Invoice:26])
	//
	READ ONLY:C145([Order:3])
	If (([AdSource:35]dateCalcBegin:5=!00-00-00!) | ([AdSource:35]dateCalcEnd:6=!00-00-00!))
		QUERY:C277([Order:3]; [Order:3]adSource:41=[AdSource:35]marketEffort:2)
	Else 
		QUERY:C277([Order:3]; [Order:3]adSource:41=[AdSource:35]marketEffort:2; *)
		QUERY:C277([Order:3];  & [Order:3]dateDocument:4>=[AdSource:35]dateCalcBegin:5; *)
		QUERY:C277([Order:3];  & [Order:3]dateDocument:4<=[AdSource:35]dateCalcEnd:6)
	End if 
	
	RELATE ONE SELECTION:C349([Order:3]; [Customer:2])
	CREATE SET:C116([Customer:2]; "Original")
	UNION:C120("Original"; "Current"; "Current")
	[AdSource:35]numCustAct:16:=Records in set:C195("Current")
	CLEAR SET:C117("Current")
	CLEAR SET:C117("Original")
	//
	ARRAY REAL:C219($aSales; 5)
	ARRAY REAL:C219($aMarg; 5)
	$cost:=0
	$value:=0
	$k:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	For ($i; 1; $k)
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
		FIRST RECORD:C50([Order:3])
		$cntLn:=Records in selection:C76([OrderLine:49])
		For ($incLn; 1; $cntLn)
			Case of 
				: ([OrderLine:49]itemNum:4=[AdSource:35]paceItem1:32)
					$aSales{1}:=$aSales{1}+[OrderLine:49]extendedPrice:11
					$aMarg{1}:=$aMarg{1}+[OrderLine:49]extendedCost:13
				: ([OrderLine:49]itemNum:4=[AdSource:35]paceItem2:33)
					$aSales{2}:=$aSales{2}+[OrderLine:49]extendedPrice:11
					$aMarg{2}:=$aMarg{2}+[OrderLine:49]extendedCost:13
				: ([OrderLine:49]itemNum:4=[AdSource:35]paceItem3:34)
					$aSales{3}:=$aSales{3}+[OrderLine:49]extendedPrice:11
					$aMarg{3}:=$aMarg{3}+[OrderLine:49]extendedCost:13
				: ([OrderLine:49]itemNum:4=[AdSource:35]paceItem4:35)
					$aSales{4}:=$aSales{4}+[OrderLine:49]extendedPrice:11
					$aMarg{4}:=$aMarg{4}+[OrderLine:49]extendedCost:13
				: ([OrderLine:49]itemNum:4=[AdSource:35]paceItem5:36)
					$aSales{5}:=$aSales{5}+[OrderLine:49]extendedPrice:11
					$aMarg{5}:=$aMarg{5}+[OrderLine:49]extendedCost:13
			End case 
			NEXT RECORD:C51([OrderLine:49])
		End for 
		$value:=$value+[Order:3]amount:24
		$cost:=$cost+[Order:3]totalCost:42
		NEXT RECORD:C51([Order:3])
	End for 
	REDUCE SELECTION:C351([OrderLine:49]; 0)
	[AdSource:35]paceSales1:42:=Round:C94($aSales{1}; 0)
	[AdSource:35]paceSales2:43:=Round:C94($aSales{2}; 0)
	[AdSource:35]paceSales3:44:=Round:C94($aSales{3}; 0)
	[AdSource:35]paceSales4:45:=Round:C94($aSales{4}; 0)
	[AdSource:35]paceSales5:46:=Round:C94($aSales{5}; 0)
	[AdSource:35]paceMargin1:47:=Round:C94($aSales{1}-$aMarg{1}; 0)
	[AdSource:35]paceMargin2:48:=Round:C94($aSales{2}-$aMarg{2}; 0)
	[AdSource:35]paceMargin3:49:=Round:C94($aSales{3}-$aMarg{3}; 0)
	[AdSource:35]paceMargin4:50:=Round:C94($aSales{4}-$aMarg{4}; 0)
	[AdSource:35]paceMargin5:51:=Round:C94($aSales{5}-$aMarg{5}; 0)
	READ WRITE:C146([Order:3])
	ARRAY REAL:C219($aSales; 0)
	ARRAY REAL:C219($aMarg; 0)
	[AdSource:35]valueOrdAct:13:=Round:C94($value; 0)
	[AdSource:35]costofSales:26:=Round:C94($cost; 0)
	[AdSource:35]numOrdAct:12:=Records in selection:C76([Order:3])
	//
	READ WRITE:C146([Order:3])
	//
	QUERY:C277([TallyChange:65]; [TallyChange:65]complete:6=False:C215; *)
	QUERY:C277([TallyChange:65];  & [TallyChange:65]idAlpha:1=Table:C252(->[AdSource:35]); *)
	QUERY:C277([TallyChange:65];  & [TallyChange:65]idKey:3=[AdSource:35]marketEffort:2; *)
	If ([AdSource:35]dateCalcEnd:6#!00-00-00!)
		C_LONGINT:C283($beforeDT)
		$beforeDT:=DateTime_DTTo([AdSource:35]dateCalcEnd:6; ?23:59:59?)
		QUERY:C277([TallyChange:65];  & [TallyChange:65]dtCreated:7<=$beforeDT; *)
	End if 
	If ([AdSource:35]dateCalcBegin:5#!00-00-00!)
		C_LONGINT:C283($afterDT)
		$afterDT:=DateTime_DTTo([AdSource:35]dateCalcBegin:5; ?23:59:59?)
		QUERY:C277([TallyChange:65];  & [TallyChange:65]dtCreated:7>=$afterDT; *)
	End if 
	QUERY:C277([TallyChange:65])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([TallyChange:65])
	[AdSource:35]value1stOrd:27:=0
	[AdSource:35]num1stOrd:25:=0
	//FIRST RECORD([TallyChange])
	//For ($i; 1; $k)
	//Field([TallyChange]idAlpha; [TallyChange]fieldNum)->:=Field([TallyChange]idAlpha; [TallyChange]fieldNum)->+[TallyChange]obEntity
	//If (Field([TallyChange]idAlpha; [TallyChange]fieldNum)=(->[AdSource]value1stOrd))
	//[AdSource]num1stOrd:=[AdSource]num1stOrd+1
	//End if 
	//[TallyChange]complete:=True
	//SAVE RECORD([TallyChange])
	//NEXT RECORD([TallyChange])
	//End for 
	UNLOAD RECORD:C212([TallyChange:65])
	[AdSource:35]dateofCalc:4:=Current date:C33
	SAVE RECORD:C53([AdSource:35])
Else 
	jAlertMessage(10004)
End if 