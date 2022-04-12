// zzzqqq PopUpWildCard(->[Requisition:83]approvalPur:14; -><>aNameID; ->[Employee:19])
vDate2:=Current date:C33
vTime2:=Current time:C178
[Requisition:83]dtApprPurch:15:=DateTime_Enter
C_TEXT:C284($tempStr)
$tempStr:="Purchasing released  "+[Requisition:83]approvalPur:14+"."
// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)