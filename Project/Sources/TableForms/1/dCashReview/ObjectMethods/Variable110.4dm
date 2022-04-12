QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=srIv)
QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerid:3)
//find dCash Applied By Payments and Invoices
QUERY:C277([DCash:62]; [DCash:62]docApply:3=srIv; *)
QUERY:C277([DCash:62];  & [DCash:62]tableApply:2=Table:C252(->[Invoice:26]))

//Received By Invoices
//CREATE EMPTY SET([Invoice];"Current")
//ARRAY LONGINT($aRecieveID;0)
//ARRAY LONGINT($aReceiveTableNum;0)

//SELECTION TO ARRAY([dCash]DocReceive;$aRecieveID;[dCash]TableReceive;$aReceiveTableNum)
dCashArrayManage(Records in selection:C76([DCash:62]); eCashLedger)
