//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 02/27/02
	//Who: Bill James, JIT
	//Description:
	VERSION_960
End if 


//Method: Http_OrderConfirm
C_LONGINT:C283($1)
C_TEXT:C284($2; $moreComments)
C_TEXT:C284($eventID)
$eventID:=obEventLog.id
If (Count parameters:C259<2)
	$moreComments:=""
Else 
	$moreComments:=$2
End if 
C_TEXT:C284($theVar; $thePad)

SMTP_SentBy([Order:3]salesNameID:10; [Customer:2]salesNameID:59; "email")
If ([RemoteUser:57]email:14#"")
	vtEmailReceiver:=[RemoteUser:57]email:14
Else 
	vtEmailReceiver:=[Customer:2]email:81
End if 
vtEmailSubject:="Web Order "+String:C10([Order:3]orderNum:2; "0000-0000")

READ ONLY:C145([TallyMaster:60])
QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$moreComments; *)  //"WebClerk_NewOrder"
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="WebClerk_Auto")
If (Records in selection:C76([TallyMaster:60])=0)
	vtEmailBody:=vtEmailSubject+"\r"+"\r"+"Placed   "+String:C10(Current date:C33)+":  "+String:C10(Current time:C178)
	$theVar:=<>tcMONEYCHAR+String:C10([Order:3]amount:24; "###,###,##0.00")
	$thePad:=" "*(20-Length:C16($theVar))
	vtEmailBody:=vtEmailBody+"\r"+"\r"+"Amount   "+$thePad+$theVar
	$theVar:=<>tcMONEYCHAR+String:C10([Order:3]salesTax:28; "###,###,##0.00")
	$thePad:=" "*(20-Length:C16($theVar))
	vtEmailBody:=vtEmailBody+"\r"+"Tax      "+$thePad+$theVar
	$theVar:=<>tcMONEYCHAR+String:C10([Order:3]shipTotal:30; "###,###,##0.00")
	$thePad:=" "*(20-Length:C16($theVar))
	vtEmailBody:=vtEmailBody+"\r"+"Shipping "+$thePad+$theVar
	$theVar:=<>tcMONEYCHAR+String:C10([Order:3]total:27; "###,###,##0.00")
	$thePad:=" "*(20-Length:C16($theVar))
	vtEmailBody:=vtEmailBody+"\r"+"Total    "+$thePad+$theVar
	vtEmailBody:=vtEmailBody+"\r"+"\r"+"Thank you.  Visit us again:  http://"+Storage:C1525.default.domain
	vtEmailPath:=""
Else 
	vtEmailBody:=[TallyMaster:60]build:6
	If ([TallyMaster:60]script:9#"")
		ExecuteText(0; [TallyMaster:60]script:9)
		theText:=""
	End if   //TallyMaster will be released in the execute of script
	//  vtEmailBody:=[TallyMaster]Build
	
	vtEmailBody:=TagsToText(vtEmailBody)
	REDUCE SELECTION:C351([TallyMaster:60]; 0)
	READ WRITE:C146([TallyMaster:60])
End if 
SMTP_SendMsg  //primary send
eMail_Notices($moreComments)  //send copy emails
vtEmailSubject:=""
vtEmailBody:=""
vtEmailPath:=""
//
vText4:=""
