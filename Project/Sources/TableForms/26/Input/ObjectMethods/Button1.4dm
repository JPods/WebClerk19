QUERY:C277([LoadTag:88]; [LoadTag:88]idNumInvoice:19=[Invoice:26]idNum:2)
ProcessTableOpen(Table:C252(->[LoadTag:88])*-1)

//DELAY PROCESS(Current process;10)
//QUERY([LoadTag];[LoadTag]OrderNum=[Order]OrderNum)
////  CHOPPED  AL_UpdateFields (eLoadTagsOrders;2)

