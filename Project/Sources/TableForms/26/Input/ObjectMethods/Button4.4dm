QUERY:C277([Ledger:30]; [Ledger:30]docRefid:4=[Invoice:26]idNum:2; *)
QUERY:C277([Ledger:30];  & [Ledger:30]tableNum:3=Table:C252(->[Invoice:26]))
ProcessTableOpen(Table:C252(->[Ledger:30])*-1)

//DELAY PROCESS(Current process;10)
//QUERY([LoadTag];[LoadTag]OrderNum=[Order]OrderNum)
////  CHOPPED  AL_UpdateFields (eLoadTagsOrders;2)

