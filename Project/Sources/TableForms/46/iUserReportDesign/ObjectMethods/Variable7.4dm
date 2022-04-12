ARRAY TEXT:C222(aPropID; 0)
ARRAY TEXT:C222(aPropValue; 0)
ARRAY TEXT:C222(aPropName; 0)  // (this is the optional one)
C_LONGINT:C283($ObjID)

$ObjID:=SR_GetLongProperty(esrWin; 1; SRP_Report_DataSource)

ALERT:C41(String:C10($ObjID))

error:=SR_GetProperties(esrWin; $ObjID; aPropID; aPropValue; aPropName)

vText:="PropName\t PropID\t PropValue\r"
For (vi1; 1; Size of array:C274(aPropID))
	
	vText:=vText+aPropName{vi1}+"\t"+aPropID{vi1}+"\t"+aPropValue{vi1}+"\r"
	
End for 

SET TEXT TO PASTEBOARD:C523(vText)


ARRAY TEXT:C222(aPropID; 0)
ARRAY TEXT:C222(aPropValue; 0)
ARRAY TEXT:C222(aPropName; 0)  // (this is the optional one)

$ObjID:=SR_GetLongProperty(esrWin; 1; SRP_Report_DataSource)

ALERT:C41(String:C10($ObjID))

error:=SR_GetProperties(esrWin; $ObjID; aPropID; aPropValue; aPropName)

vText:="PropName\t PropID\t PropValue\r"
For (vi1; 1; Size of array:C274(aPropID))
	
	vText:=vText+aPropName{vi1}+"\t"+aPropID{vi1}+"\t"+aPropValue{vi1}+"\r"
	
End for 

SET TEXT TO PASTEBOARD:C523(vText)