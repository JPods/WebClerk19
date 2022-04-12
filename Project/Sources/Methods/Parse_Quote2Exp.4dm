//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2)
C_TEXT:C284($working)
C_LONGINT:C283($lenText; $start; $end)
$lenText:=Length:C16($1->)
If ($lenText>0)
	$working:=Replace string:C233($1->; Char:C90(34); "+Char(34)+")
End if 



SEND PACKET:C103(myDoc; [QQQCustomer:2]nameFirst:73+" "+[QQQCustomer:2]nameLast:23+"<\\n>"+[QQQCustomer:2]title:3+"<\\n>")
SEND PACKET:C103(myDoc; [QQQCustomer:2]company:2+"<\\n>"+[QQQCustomer:2]address1:4+"<\\n>")
SEND PACKET:C103(myDoc; [QQQCustomer:2]address2:5+("<\\n>"*Num:C11([QQQCustomer:2]address2:5#"")))
SEND PACKET:C103(myDoc; [QQQCustomer:2]city:6+", "+[QQQCustomer:2]state:7+" "+[QQQCustomer:2]zip:8+"<\\n>")

SEND PACKET:C103(myDoc; "<$>Dear "+[QQQCustomer:2]nameFirst:73)
SEND PACKET:C103(myDoc; [QQQCustomer:2]city:6+", "+[QQQCustomer:2]state:7+" "+[QQQCustomer:2]zip:8+"<\\n>")

SEND PACKET:C103(myDoc; "<$>Thank you for the opportunity to bid on creative services for ")
SEND PACKET:C103(myDoc; [QQQCustomer:2]company:2+" <I>"+[Proposal:42]inquiryCode:6+"<$>")
SEND PACKET:C103(myDoc; [TechNote:58]Summary:3)