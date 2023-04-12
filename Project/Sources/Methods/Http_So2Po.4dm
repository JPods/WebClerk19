//%attributes = {"publishedWeb":true}

// $1 -> SMTP server address
// $2 -> sender email address
// $3 -> recipient address
// $4 -> message subject
// $5 -> message text
// $6 -> attachment pathname (may be empty)

ARRAY TEXT:C222(aText1; 6)
SMTP_SentBy([Customer:2]salesNameID:59; "email")
vtEmailReceiver:=[RemoteUser:57]email:14  // $3 -> recipient address
vtEmailSubject:="Order: "+String:C10([Order:3]idNum:2; "0000-0000")  //  -> Subject
vtEmailBody:="Thank you for your order received via webClerk."+"\r"+"Check status at:  http://"+Storage:C1525.default.domain+"\r"+aText1{4}
vtEmailBody:=vtEmailBody+"\r"+"Total:  "+<>tcMONEYCHAR+String:C10([Order:3]total:27; "###,###,##0.00")+"\r"+"Ordered by:  "+[Order:3]orderedBy:66
//vtEmailPath:=Http_POConfirm(0)
SMTP_SendMsg
ARRAY TEXT:C222(aText1; 0)