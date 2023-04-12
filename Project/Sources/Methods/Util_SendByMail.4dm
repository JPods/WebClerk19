//%attributes = {}
C_OBJECT:C1216($smtp; $status; $smtpInfos; $invoiceInfo; $settings; $smtp; $smtpInfos; $invoice; $client)
C_TEXT:C284($user; $attachment; $host; $from; $password; $to; $pdf)

$invoiceInfo:=$1  //We receive the invoice information
$settings:=$2


$invoice:=ds:C1482.Invoice.get($invoiceInfo.invoiceID)

$client:=$invoice.Invoices_to_Clients

$pdf:=$invoiceInfo.invoicePath

$host:=$settings.smtp.host
$user:=$settings.smtp.user
$password:=$settings.smtp.password
$from:=$settings.Company.from
$to:=$client.eAddresses.eMail
$subject:=Util_SendByMail_Parse($settings.Company.Subject; $invoice; $client; $settings)
$textBody:=Util_SendByMail_Parse($settings.Company.Body; $invoice; $client; $settings)
$attachment:=$pdf

// creation of the transporter SMTP object with the information on the Company
$smtpInfos:=New object:C1471
$smtpInfos.host:=$settings.smtp.host  //We can simply copy the Object, but in this way, it can be more useful for debugging
$smtpInfos.user:=$settings.smtp.user
$smtpInfos.password:=$settings.smtp.password
$smtpInfos.port:=$settings.smtp.port
$smtpInfos.acceptUnsecureConnection:=Not:C34(Bool:C1537($settings.smtp.acceptUnsecureConnection))

$smtp:=SMTP New transporter:C1608($smtpInfos)

$mail:=New object:C1471
$mail.from:=$from
$mail.to:=$to
$mail.subject:=$subject
$mail.textBody:=$textBody
$mail.htmlBody:=Replace string:C233($textBody; Char:C90(Carriage return:K15:38); "</BR>")
$mail.attachment:=$attachment
$mail.attachments:=New collection:C1472(MAIL New attachment:C1644($attachment))

ON ERR CALL:C155("Error_Handler")
// Send the mail according to the mail information entered in the form
$status:=$smtp.send($mail)
ON ERR CALL:C155("")

// Verification if send mail is a success or not and display a message
If ($status.success)
	//ALERT("Mail has been sent")
Else 
	If ($status.status=0)
		ARRAY LONGINT:C221($tcodes; 0)
		ARRAY LONGINT:C221($tcmps; 0)
		ARRAY TEXT:C222($tmess; 0)
		GET LAST ERROR STACK:C1015($tcodes; $tcmps; $tmess)
		ALERT:C41(Util_Get_LocalizedMessage("CheckNo"; $tmess{1}))  //"an error occurred: "+$tmess{1})
	Else 
		ALERT:C41(Util_Get_LocalizedMessage("CheckNo"; $status.statusText))
	End if 
End if 

