If (True:C214)
	ALERT:C41("qqq Not released")
	
Else 
	//  entry_o:=New object
	process_o.entitySave()
	process_o.entityAdd()
End if 

