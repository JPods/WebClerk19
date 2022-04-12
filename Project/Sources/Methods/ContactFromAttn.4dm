//%attributes = {"publishedWeb":true}
If (False:C215)
	//Date: 02/23/02
	//Who: Peter Fleming, Arkware
	//Description: Enter Prepaid as default for [Contact]UPSBillingOption
	VERSION_960
	//June 29, 2002
	//Bill, Fixed contact name entry, alert added at end
End if 


C_BOOLEAN:C305($prime; $ship)
C_POINTER:C301($1)
KeyModifierCurrent
//TRACE
Case of   // 
	: (CmdKey=1)
		CONFIRM:C162("Clean up First and Last Names?")
		If (OK=1)
			var $oName : Object
			$oName:=ParseName("Contact")
		End if 
	: (OptKey=1)
		CONFIRM:C162("Add to Contact Lists?")
		If (OK=1)
			//$prime:=(CmdKey=1)
			//$ship:=(ShftKey=1)
			REDUCE SELECTION:C351([Contact:13]; 0)
			CREATE RECORD:C68([Contact:13])
			
			TRACE:C157
			Contact_FillFrom(Table:C252(Table:C252($1)))
			SAVE RECORD:C53([Contact:13])
			ALERT:C41("Contact added")
			QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
			
		End if 
	: (aContact>0)
		CONFIRM:C162("Set as Contact Name?")
		If (OK=1)
			QUERY:C277([Contact:13]; [Contact:13]idNum:28=aContactUnique{aContact})  // Replaced GOTO Record in Selection
			If (Table:C252($1)=Table:C252(->[Customer:2]))
				[Customer:2]nameFirst:73:=[Contact:13]nameFirst:2
				[Customer:2]nameLast:23:=[Contact:13]nameLast:4
				[Customer:2]title:3:=[Contact:13]title:5
			Else 
				$1->:=[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4
			End if 
		End if 
	Else 
		BEEP:C151
End case 