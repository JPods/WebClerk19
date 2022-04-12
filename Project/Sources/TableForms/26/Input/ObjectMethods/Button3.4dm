QUERY:C277([Service:6]; [Service:6]idNumInvoice:23=[Invoice:26]idNum:2)
ProcessTableOpen(Table:C252(->[Service:6])*-1)

//DELAY PROCESS(Current process;10)
//QUERY([LoadTag];[LoadTag]OrderNum=[Order]OrderNum)
////  CHOPPED  AL_UpdateFields (eLoadTagsOrders;2)

