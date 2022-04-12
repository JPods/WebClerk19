//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
ARRAY REAL:C219(aReal1; $1)
aInvoices{$1}:=[Invoice:26]invoiceNum:2
aUnPaid{$1}:=[Invoice:26]balanceDue:44
aInvTotals{$1}:=[Invoice:26]total:18
aInvTerms{$1}:=[Invoice:26]terms:24
aInvDate{$1}:=Invc_PrimeDate
aIvcProfile{$1}:=[Invoice:26]profile1:53
aCustPO{$1}:=[Invoice:26]customerPO:29
aInvDisApp{$1}:=[Invoice:26]appliedDiscount:45
aOrders{$1}:=[Invoice:26]orderNum:1
aInvCust{$1}:=[Invoice:26]customerid:3
aReal1{$1}:=[Invoice:26]amount:14
Ivc_RayAdjust($1; $1)  //start element, end element
ARRAY REAL:C219(aReal1; 0)