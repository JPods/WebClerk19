QUERY:C277([Payment:28]; [Payment:28]idNum:8=srSO)
QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerid:4)
//find dCash Applied By Payments and Invoices
QUERY:C277([DCash:62]; [DCash:62]docApply:3=srSO; *)
QUERY:C277([DCash:62];  & [DCash:62]tableApply:2=Table:C252(->[Payment:28]))

//Received By Invoices
//CREATE EMPTY SET([Invoice];"Current")
//ARRAY LONGINT($aRecieveID;0)
//ARRAY LONGINT($aReceiveTableNum;0)

//SELECTION TO ARRAY([dCash]DocReceive;$aRecieveID;[dCash]TableReceive;$aReceiveTableNum)
dCashArrayManage(Records in selection:C76([DCash:62]); 0; 0; eCashLedger)
