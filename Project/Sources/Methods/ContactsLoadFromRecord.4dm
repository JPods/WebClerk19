//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-09-14T00:00:00, 20:48:48
// ----------------------------------------------------
// Method: //  CHOPPED  ContactsLoadFromRecord
// Description
// Modified: 09/14/13
// 
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1)
C_BOOLEAN:C305($setBillTo; $2)
$setBillTo:=False:C215
If (Count parameters:C259=2)
	$setBillTo:=$2
End if 
If (Locked:C147($1->))
	jAlertMessage(12009)
Else 
	LOAD RECORD:C52([Contact:13])
	$theName:=[Contact:13]salutation:15+(" "*Num:C11([Contact:13]salutation:15#""))+[Contact:13]nameFirst:2+(" "*Num:C11(([Contact:13]nameFirst:2#"")))
	Case of 
		: ($1=(->[Order:3]))
			If ($setBillTo)
				[Order:3]contactBillTo:87:=[Contact:13]idNum:28
			Else 
				
				AddressOrderFill("shiptofromContact")
				
				
			End if 
		: ($1=(->[Proposal:42]))
			If ($setBillTo)
				[Proposal:42]contactBillTo:73:=[Contact:13]idNum:28
			Else 
				[Proposal:42]contactShipTo:63:=[Contact:13]idNum:28
				[Proposal:42]attention:37:=$theName
				[Proposal:42]company:11:=[Contact:13]company:23
				[Proposal:42]address1:12:=[Contact:13]address1:6
				[Proposal:42]address2:13:=[Contact:13]address2:7
				[Proposal:42]city:14:=[Contact:13]city:8
				[Proposal:42]state:15:=[Contact:13]state:9
				[Proposal:42]zip:16:=[Contact:13]zip:11
				[Proposal:42]country:17:=[Contact:13]country:12
				[Proposal:42]phone:24:=[Contact:13]phone:30
				//[Proposal]UPSBillingOption:=[Contact]UPSBillingOption
				//[Proposal]UPSReceiverAcct:=[Contact]UPSReceiverAcct
				//[Proposal]UPSResidential:=False
				If ([Proposal:42]taxJuris:33#[Contact:13]taxJuris:24)
					[Proposal:42]taxJuris:33:=[Contact:13]taxJuris:24
					$0:=True:C214
				End if 
				[Proposal:42]phone:24:=[Contact:13]phone:30
				
				[Proposal:42]fax:67:=[Contact:13]fax:31  //01/21/03.prf
				[Proposal:42]email:68:=[Contact:13]email:35  //01/21/03.prf
				
				//  Put  the formating in the form  jFormatPhone(->[Proposal]phone)
				[Proposal:42]shipVia:18:=[Contact:13]shipVia:26
				Find Ship Zone(->[Proposal:42]zip:16; ->[Proposal:42]zone:19; ->[Proposal:42]shipVia:18; ->[Proposal:42]country:17; ->[Proposal:42]siteID:77)
			End if 
		: ($1=(->[Invoice:26]))
			Case of 
				: (([Invoice:26]dateDocument:35#!00-00-00!) | ([Invoice:26]dateShipped:4#!00-00-00!) | ([Invoice:26]dateShipped:4#!00-00-00!))
					jAlertMessage(10008)
				: ($setBillTo)
					[Invoice:26]contactBillTo:79:=[Contact:13]idNum:28
				Else 
					AddressIinvoiceFill("shiptofromContact")
			End case 
	End case 
End if 