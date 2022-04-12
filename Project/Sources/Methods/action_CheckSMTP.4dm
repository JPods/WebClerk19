//%attributes = {}



// 4D_25Invoice - 2022-01-15
C_OBJECT:C1216($smtp;$status;$smtpInfos)
C_TEXT:C284($message)

  // creation of the transporter SMTP object with the information entered in the form
$smtpInfos:=New object:C1471
$smtpInfos.host:=Form:C1466.settings.smtp.host
$smtpInfos.user:=Form:C1466.settings.smtp.user
$smtpInfos.password:=Form:C1466.settings.smtp.password
$smtpInfos.port:=Form:C1466.settings.smtp.port
$smtpInfos.acceptUnsecureConnection:=Not:C34(Bool:C1537(Form:C1466.settings.smtp.acceptUnsecureConnection))
$smtp:=SMTP New transporter:C1608($smtpInfos)

  // Connection check, to verify if  the information intered are OK
$status:=$smtp.checkConnection()

If ($status.success)
	$message:="OK"
Else 
	$message:=$status.statusText
End if 

$0:=$message