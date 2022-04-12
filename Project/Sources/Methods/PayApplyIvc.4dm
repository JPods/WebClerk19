//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:41:22
// ----------------------------------------------------
// Method: PayApplyIvc
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("MakePayment"))
	C_LONGINT:C283($i; $k; $e; $f)
	C_BOOLEAN:C305($1)
	If ((vHere>1) & (BooAccept))
		If ((strCurrency="") | (strCurrency=<>tcMONEYCHAR))
			If (Locked:C147([Invoice:26]))
				If (allowAlerts_boo)
					ALERT:C41("Invoice is Locked.  You must have Read/Write privileges.")
				Else 
					OK:=0
				End if 
			Else 
				If (allowAlerts_boo)
					CONFIRM:C162("Apply available payments.")
				Else 
					OK:=1
				End if 
				If (OK=1)
					$k:=Records in selection:C76([Payment:28])
					FIRST RECORD:C50([Payment:28])
					For ($i; 1; $k)
						LOAD RECORD:C52([Payment:28])
						If (Not:C34(Locked:C147([Payment:28])))
							PayApplyOneInvoice
							
						Else 
							jAlertMessage(10004)
						End if 
						NEXT RECORD:C51([Payment:28])
					End for 
					PaidDaysCalc  //customer changes saved in acceptInvoice.
					acceptInvoice(True:C214)
					PayLoadShow(Records in selection:C76([Payment:28]))
					UNLOAD RECORD:C212([Payment:28])
				End if 
			End if 
		Else 
			If (allowAlerts_boo)
				ALERT:C41("Apply Invoice must be in base currency.")
			End if 
		End if 
	Else 
		jAlertMessage(9200)
	End if 
End if 