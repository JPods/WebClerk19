If (False:C215)
	//Date: 09/20/02
	//Who: Dan Bentson, Arkware
	//Description: Added prntAttn variable
End if 
TRACE:C157

// Modified by: Bill James (creditcard, alert removed for greater flexibility using xml)
//  confirm 170119

If (([Payment:28]CardApproval:15="Pend") | ([Payment:28]CardApproval:15="Web@") | ([Payment:28]CardApproval:15="SSL@"))
	If (pvCardAction="")
		ALERT:C41("PayAction must be selected'")
	Else 
		CONFIRM:C162("Process credit card transactions??")
		If (OK=1)
			PayProcessCreditCard
		End if 
	End if 
Else 
	jAlertMessage(9201)
End if 
ARRAY TEXT:C222(aPayAuthFields; 0)