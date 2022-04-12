// zzzqqq PopUpWildCard(->[Requisition:83]approvalSales:11; -><>aNameID; ->[Employee:19])
vDate1:=Current date:C33
vTime1:=Current time:C178
C_TEXT:C284($tempStr)
[Requisition:83]dtApprSales:12:=DateTime_Enter
$tempStr:="Sales released "+[Requisition:83]approvalSales:11+"."
// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)