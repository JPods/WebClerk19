C_TEXT:C284($pathCerts; $pathacme; $zerossl)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(ailoText16; 0)
		APPEND TO ARRAY:C911(ailoText16; "Load Customer's Address")
		APPEND TO ARRAY:C911(ailoText16; "Load Order's Address")
		
		INSERT IN ARRAY:C227(ailoText16; 1; 1)
		ailoText16{1}:="Address options"
	: (ailoText16{ailoText16}="Load Customer's Address")
		[WorkOrder:66]Company:36:=[QQQCustomer:2]company:2
		[WorkOrder:66]Address1:50:=[QQQCustomer:2]address1:4
		[WorkOrder:66]Address2:51:=[QQQCustomer:2]address2:5
		[WorkOrder:66]City:52:=[QQQCustomer:2]city:6
		[WorkOrder:66]State:53:=[QQQCustomer:2]state:7
		[WorkOrder:66]Zip:54:=[QQQCustomer:2]zip:8
	: (ailoText16{ailoText16}="Load Order's Address")
		[WorkOrder:66]Company:36:=[Order:3]company:15
		[WorkOrder:66]Address1:50:=[Order:3]address1:16
		[WorkOrder:66]Address2:51:=[Order:3]address2:17
		[WorkOrder:66]City:52:=[Order:3]city:18
		[WorkOrder:66]State:53:=[Order:3]state:19
		[WorkOrder:66]Zip:54:=[Order:3]zip:20
End case 
ailoText16:=1