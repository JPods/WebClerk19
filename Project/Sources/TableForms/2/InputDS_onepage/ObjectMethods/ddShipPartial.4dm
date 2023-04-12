
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/11/17, 13:36:58
// ----------------------------------------------------
// Method: entry_o..Input1.ddShipPartial
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(atShipPartial; 0)
		APPEND TO ARRAY:C911(atShipPartial; "Orders Complete")
		APPEND TO ARRAY:C911(atShipPartial; "Orders Partial")
		APPEND TO ARRAY:C911(atShipPartial; "OrderLines Complete")
		APPEND TO ARRAY:C911(atShipPartial; "Override To Partial")
		
	: (Form event code:C388=On Clicked:K2:4)
		$vtValue:=atShipPartial{atShipPartial}
		
		C_BOOLEAN:C305($prime; $ship)
		
		//TRACE
		Case of   // 
			: ($vtValue="Orders Complete")
				CONFIRM:C162("Set to Ship \"Orders Complete\"?")
				If (OK=1)
					[Customer:2]shipPartial:109:=0
				End if 
			: ($vtValue="Orders Partial")
				CONFIRM:C162("Set to Ship \"Orders Partial\"?")
				If (OK=1)
					[Customer:2]shipPartial:109:=1
				End if 
			: ($vtValue="OrderLines Complete")
				CONFIRM:C162("Set to Ship \"OrderLiness Complete\"?")
				If (OK=1)
					[Customer:2]shipPartial:109:=2
				End if 
			: ($vtValue="Override To Partial")
				CONFIRM:C162("Set to \"Override To Partial\"?")
				If (OK=1)
					[Customer:2]shipPartial:109:=3
				End if 
			Else 
				BEEP:C151
		End case 
		
	: (Form event code:C388=On Data Change:K2:15)
		// zzzqqq U_DTStampFldMod(->[QQQCustomer:2]comment:15; ->[QQQCustomer:2]shipPartial:109)
		
		
End case 

atShipPartial:=1  // reset 
