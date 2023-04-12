//%attributes = {}

// Modified by: Bill James (2022-07-19T05:00:00Z)
// Method: Email_Objects
// Description 
// Parameters
// ----------------------------------------------------


//https://blog.4d.com/microsoft-365-send-emails/

$email:=New object:C1471
$email.from:=New object:C1471
$email.from.emailAddress:=New object:C1471
$email.from.emailAddress.address:=$office365.user.getCurrent().userPrincipalName



/*
If you want to specify a reply-to address different from the address

Then the recipients(using different syntaxes) : 
*/

$addressTo:=New object:C1471
$addressTo.emailAddress:=New object:C1471
$addressTo.emailAddress.email:="address1@mail.com"

$addressCC:=New object:C1471
$addressCC.emailAddress:=New object:C1471
$addressCC.emailAddress.email:="address2@mail.com"
$addressCC.emailAddress.name:="Stephen"

// Originating addresses
$email.toRecipients:=New collection:C1472($addressTo)
// Carbon Copy
$email.ccRecipients:=New collection:C1472($addressCC)

//Next, let’s add a subject:

$email.subject:="Hello world"


//  And the body … You can specify two types, a text:
$email.body:=New object:C1471
$email.body.content:="Test content mail"
$email.body.contentType:="text"

// or HTML:
$email.body:=New object:C1471
$email.body.content:="<html><body><h1>Test content mail </h1></body></html>"
$email.body.contentType:="html"



//a request for a delivery receipt : 
$email.isDeliveryReceiptRequested:=True:C214
//a request for a read receipt : 
$email.isReadReceiptRequested:=True:C214
//a “low”, “normal” or “important” importance : 
$email.importance:="high"


//To add an attachment, you need to create an attachment object : 

var $attachmentText : Text
$attachmentText:="Simple text attachement content"

var $attachment : Object
BASE64 ENCODE:C895($attachmentText)
$attachment:=New object:C1471
$attachment["@odata.type"]:="#microsoft.graph.fileAttachment"
$attachment.contentId:=Generate UUID:C1066
$attachment.isInline:=False:C215
$attachment.name:="attachment.txt"
$attachment.contentType:="text/plain"
$attachment.contentBytes:=$attachmentText
$attachment.size:=Length:C16($attachmentText)

//And add it to your email like this : 

$email.attachments:=New collection:C1472($attachment)

//SEND EMAIL

//Now that the email is ready, we can send it using the mail.send()function of the$office365 object we create befo : 

$status:=$office365.mail.send($email)