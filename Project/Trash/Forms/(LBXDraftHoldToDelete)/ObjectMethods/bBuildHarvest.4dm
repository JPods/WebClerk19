


If (Form:C1466.obHarvest=Null:C1517)
	ALERT:C41("There is nothing to build in Form.obHarvest.")
Else 
	LBX_BoxFromStored(Form:C1466.obHarvest)
	Form:C1466.ents:=ds:C1482[Form:C1466.obHarvest.tableName].all()
	
End if 

