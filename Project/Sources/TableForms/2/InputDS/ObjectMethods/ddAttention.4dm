
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/08/17, 10:00:29
// ----------------------------------------------------
// Method: entryEntity..Input1.ddAttention
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(atAttention; 0)
		APPEND TO ARRAY:C911(atAttention; "Attention")
		APPEND TO ARRAY:C911(atAttention; "Cleanup")
		APPEND TO ARRAY:C911(atAttention; "Add To Contacts")
		APPEND TO ARRAY:C911(atAttention; "Set From Contact")
		
	: (Form event code:C388=On Clicked:K2:4)
		$vtValue:=atAttention{atAttention}
		
		C_BOOLEAN:C305($prime; $ship)
		
		//TRACE
		Case of   // 
			: ($vtValue="Cleanup")
				CONFIRM:C162("Clean up First and Last Names?")
				If (OK=1)
					entryEntity.nameFirst:=Txt_Clean(entryEntity.nameFirst; " ")
					entryEntity.nameLast:=Txt_Clean(entryEntity.nameLast; " ")
					
					//ParseName (->entryEntity.LastName;->entryEntity.FirstName;->entryEntity.LastName)  //entryEntity.Attention
					// ### jwm ### 20171207_1630 write a new ParseName that corrects Both Names in one field
					
				End if 
			: ($vtValue="Add To Contacts")
				
				//$prime:=(CmdKey=1)
				//$ship:=(ShftKey=1)
				var $rec_ent : Object
				$rec_ent:=ds:C1482.Contact.query("nameFirst = :1 & nameLast = :2 & customerID = :3"; entryEntity.nameFirst; entryEntity.nameLast; entryEntity.customerID)
				
				If ($rec_ent=Null:C1517)
					CONFIRM:C162("WARNING: There is already a contact "+entryEntity.nameFirst+" "+entryEntity.nameLast; " Add Contact "; " Cancel ")
				Else 
					CONFIRM:C162("Add "+entryEntity.nameFirst+" "+entryEntity.nameLast+" as a New Contact?"; " Add Contact "; " Cancel ")
				End if 
				
				If (OK=1)
					var $contact_ent : Object
					$contact_ent:=Contact_FillObj(entryEntity)
				End if 
				// reload contacts
				
				// MustFixQQQZZZ: Bill James (2021-12-01T06:00:00Z)
				// populate LB
				var $contact_sel : Object
				$contact_sel:=ds:C1482.Contact.query("customerID = :1 and dateRetired = :2"; entryEntity.customerID; !00-00-00!)
				
				
			: ($vtValue="Set From Contact")
				If ((Size of array:C274(aContactsSelect)#0) & (Is record loaded:C669([Contact:13])))  // if a record is selected and loaded
					
					CONFIRM:C162("Set Attention to "+[Contact:13]nameFirst:2+" "+[Contact:13]nameLast:4+"?")
					If (OK=1)
						// contact record selected in AreaList eContactsAreaList
						entryEntity.nameFirst:=[Contact:13]nameFirst:2
						entryEntity.nameLast:=[Contact:13]nameLast:4
					End if 
				Else 
					ALERT:C41("ERROR: No Contact Selected")
				End if 
			Else 
				BEEP:C151
		End case 
		
	: (Form event code:C388=On Data Change:K2:15)
		// no action
		
		
End case 

atAttention:=1  // reset 
