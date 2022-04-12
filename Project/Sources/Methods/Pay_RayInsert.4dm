//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
INSERT IN ARRAY:C227(aPayCust; $1)
INSERT IN ARRAY:C227(aPayments; $1)
INSERT IN ARRAY:C227(aPayOrds; $1)
INSERT IN ARRAY:C227(aPayInvs; $1)
INSERT IN ARRAY:C227(aPayOrig; $1)
INSERT IN ARRAY:C227(aPayDate; $1)
INSERT IN ARRAY:C227(aPayType; $1)
INSERT IN ARRAY:C227(aPayCom; $1)
INSERT IN ARRAY:C227(aPayRecs; $1)
aPayments{$1}:=[Payment:28]amountAvailable:19
aPayOrds{$1}:=[Payment:28]orderNum:2
aPayInvs{$1}:=[Payment:28]invoiceNum:3
aPayOrig{$1}:=[Payment:28]amount:1
aPayCom{$1}:=[Payment:28]comment:5
aPayDate{$1}:=[Payment:28]dateReceived:10
aPayType{$1}:=[Payment:28]typePayment:6
aPayRecs{$1}:=Record number:C243([Payment:28])
aPayCust{$1}:=[Payment:28]customerid:4