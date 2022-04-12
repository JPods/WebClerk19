Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(aiLoText1; 0)
		APPEND TO ARRAY:C911(aiLoText1; "UnitTime")
		APPEND TO ARRAY:C911(aiLoText1; "Minutes")
		APPEND TO ARRAY:C911(aiLoText1; "Hours")
		APPEND TO ARRAY:C911(aiLoText1; "Days")
	: (aiLoText1>1)
		[WorkOrder:66]UnitTime:18:=aiLoText1{aiLoText1}
End case 
aiLoText1:=1
