//%attributes = {"publishedWeb":true}
//Procedure: Contact_ShipTo
If (False:C215)
	//01/21/03.prf
	//Added Fax and eMail fields to Proposal section  
	VERSION_9919
	VERSION_9919_ISC
	//Date: 02/23/02
	//Who: Peter Fleming, Arkware
	//Description: Added new UPS fields
	VERSION_960
End if 
C_POINTER:C301($1; $2)
C_BOOLEAN:C305($0; $doContact; $setBillTo; $setShipTo)
C_TEXT:C284($theName)
KeyModifierCurrent
$setBillTo:=(CmdKey=1)
$setShipTo:=True:C214  //(OptKey=1)
$0:=False:C215
//

Case of 
	: (Locked:C147($2->))
		$doContact:=False:C215
		jAlertMessage(12009)
	: (($1->=0) & (Size of array:C274($1->)>0))
		$1->:=1
	: (($1->>0) & (Size of array:C274($1->)>=$1->))
		If ($1=(->aContact))
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=aContactUnique{aContact})  // Replaced GOTO Record in Selection
			//  GOTO SELECTED RECORD([Contact];aContactUnique{aContact})
		Else 
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=aShipToUnique{aShipTo})
			//  GOTO SELECTED RECORD([Contact];aShipToSel{aShipTo})
		End if 
		$theName:=[Contact:13]salutation:15+(" "*Num:C11([Contact:13]salutation:15#""))+[Contact:13]nameFirst:2+(" "*Num:C11(([Contact:13]nameFirst:2#"") & ([Contact:13]nameLast:4#"")))+[Contact:13]nameLast:4
		Case of 
			: ($setBillTo)
				CONFIRM:C162("Change BILL to "+$theName+" address.")
				If (OK=1)
					$doContact:=True:C214
				End if 
			: ($setShipTo)
				CONFIRM:C162("Change SHIP to "+$theName+" address.")
				If (OK=1)
					$doContact:=True:C214
				End if 
		End case 
End case 
//
If ($doContact)
	Case of 
		: ($2=(->[Order:3]))
			//  CHOPPED  ContactsLoadFromRecord(->[Order]; $setBillTo)
		: ($2=(->[Proposal:42]))
			//  CHOPPED  ContactsLoadFromRecord(->[Proposal]; $setBillTo)
		: ($2=(->[Invoice:26]))
			//  CHOPPED  ContactsLoadFromRecord(->[Invoice]; $setBillTo)
	End case 
	vMod:=True:C214
End if 