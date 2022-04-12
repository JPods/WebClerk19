C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388
C_TEXT:C284(<>vConnectionStatus)

Thermometer:=vNewThermometer

Case of 
		
	: ($formEvent=On Load:K2:1)
		
	: (Outside call:C328)
		//  vNewThermoTitle
		//update thermometer and set vNewThermoCount:=-1 to ack call    
		Case of 
			: (<>ThermoAbort)
				CANCEL:C270
				vNewThermometer:=-1
			: ((<>vConnectionStatus#vNewThermoTitle) & (<>vConnectionStatus#""))  //change the Thermo message on the fly
				vNewThermoTitle:=<>vConnectionStatus
				<>vConnectionStatus:=""
				// ### jwm ### 20180629_1151added ability to pass in new title in Thermo update.
			Else 
				Case of 
					: (<>ThermoAbort)
						CANCEL:C270
						vNewThermometer:=-1
					: (vNewThermometer=-2)
						CANCEL:C270
						vNewThermometer:=-1
					Else 
						//Thermometer:=(vNewThermoCount*100)/vNewThermoTotal
						Thermometer:=vNewThermometer
						vNewThermometer:=-1
				End case 
		End case 
	Else 
		If (<>ThermoAbort)
			CANCEL:C270
			vNewThermometer:=-1
		End if 
End case 