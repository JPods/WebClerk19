//%attributes = {"publishedWeb":true}
//Method: Ord_FromProposal
C_LONGINT:C283($theRec)
$theRec:=Record number:C243([QQQCustomer:2])
OrdLnRays(0)
createOrderProp  //must follow OrdLnFillRays
booWarn:=False:C215
setCustFinance
If ((Record number:C243([QQQCustomer:2])<0) & ($theRec>-1))
	GOTO RECORD:C242([QQQCustomer:2]; $theRec)
End if 