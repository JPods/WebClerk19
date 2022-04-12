//%attributes = {"publishedWeb":true}
//Method: Contact_PrntSetVar
C_LONGINT:C283($k)
prntTypeDoc:="Raw Lead Sheet"
AddressOnly:=PVar_AddressOnly(process_o.cur)
AddressFull:=jConcat(process_o.cur.nameFirst; " ")+jConcat([Contact:13]nameLast:4; "")+"\r"+jConcat([Contact:13]company:23; "\r")+CustAddress
prntAcct:=process_o.cur.customerID
pvPhone:=Format_Phone(process_o.cur.phone)
pvFAX:=Format_Phone(process_o.cur.fax)
prntDateOut:="No sale"
prntDateIn:=String:C10(Current date:C33+<>tcLeadDue)  //[Contact]ResponseDate)
prntTypeSal:=""  //[Contact]TypeSale
prntAmt:=""  //est yearly sales
prntTax:=""  //Sales last year
prntTotal:=""  //Sales YTD



