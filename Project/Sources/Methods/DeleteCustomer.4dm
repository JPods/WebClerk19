//%attributes = {"publishedWeb":true}
C_REAL:C285($openOrds; $openInvoice; $openPay)
C_LONGINT:C283($i; $k)
MESSAGES OFF:C175
QUERY:C277([ItemSerial:47]; [ItemSerial:47]customerid:9=[Customer:2]customerID:1)
QUERY:C277([Order:3]; [Order:3]customerid:1=[Customer:2]customerID:1)
QUERY:C277([Invoice:26]; [Invoice:26]customerid:3=[Customer:2]customerID:1)
QUERY:C277([Payment:28]; [Payment:28]customerid:4=[Customer:2]customerID:1)
//
ARRAY REAL:C219($aValue; 0)
SELECTION TO ARRAY:C260([Order:3]amountBackLog:54; $aValue)
$k:=Size of array:C274($aValue)
For ($i; 1; $k)
	$openOrds:=$openOrds+Abs:C99($aValue{$i})
End for 
//
SELECTION TO ARRAY:C260([Invoice:26]balanceDue:44; $aValue)
$k:=Size of array:C274($aValue)
For ($i; 1; $k)
	$openInvoice:=$openInvoice+Abs:C99($aValue{$i})
End for 
//
SELECTION TO ARRAY:C260([Payment:28]amountAvailable:19; $aValue)
$k:=Size of array:C274($aValue)
FIRST RECORD:C50([Payment:28])
For ($i; 1; $k)
	$openPay:=$openPay+Abs:C99($aValue{$i})
End for 
//
If (([Customer:2]balanceDue:42=0) & ($openPay=0) & ($openInvoice=0) & ($openOrds=0))
	QUERY:C277([DCash:62]; [DCash:62]customerIDApply:1=[Customer:2]customerID:1)
	DELETE SELECTION:C66([DCash:62])
	QUERY:C277([DCash:62]; [DCash:62]customerIDReceive:7=[Customer:2]customerID:1)
	DELETE SELECTION:C66([DCash:62])
	//    RELATE MANY([Customer]AccountCode)
	QUERY:C277([CallReport:34]; [CallReport:34]tableNum:2=2; *)  //customer file number
	QUERY:C277([CallReport:34];  & [CallReport:34]customerID:1=[Customer:2]customerID:1)
	//SEARCH([ItemSerial];[ItemSerial]customerID=[Customer]customerID)
	QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
	
	QUERY:C277([Service:6]; [Service:6]customerid:1=[Customer:2]customerID:1)
	QUERY:C277([Reference:7]; [Reference:7]customerid:1=[Customer:2]customerID:1)
	//SEARCH([Proposal];[Proposal]customerID=[Customer]customerID)
	QUERY:C277([Payment:28]; [Payment:28]customerid:4=[Customer:2]customerID:1)
	QUERY:C277([QA:70]; [QA:70]tableNum:11=2; *)
	QUERY:C277([QA:70];  & [QA:70]customerid:1=[Customer:2]customerID:1)
	QUERY:C277([RemoteUser:57]; [RemoteUser:57]tableNum:9=2; *)
	QUERY:C277([RemoteUser:57];  & [RemoteUser:57]customerid:10=[Customer:2]customerID:1)
	//
	//SEARCH([InvLine];[InvLine]customerID=[Customer]customerID)
	//SEARCH([OrdLine];[OrdLine]customerID=[Customer]customerID)
	//SEARCH([PrpLine];[PrpLine]customerID=[Customer]customerID)
	
	DELETE SELECTION:C66([Service:6])
	DELETE SELECTION:C66([Reference:7])
	DELETE SELECTION:C66([Contact:13])
	DELETE SELECTION:C66([CallReport:34])
	DELETE SELECTION:C66([Payment:28])
	DELETE SELECTION:C66([QA:70])
	DELETE SELECTION:C66([RemoteUser:57])
	DELETE SELECTION:C66([Payment:28])
	//DELETE SELECTION([InvLine])
	//DELETE SELECTION([PrpLine])
	//DELETE RECORD([PrpLine])
	DELETE RECORD:C58([Customer:2])
Else   // ### jwm ### 20170324_1358
	ALERT:C41("ERROR: Customer Not Voided - Check Open Balance")
End if 
MESSAGES ON:C181