//%attributes = {}


C_TEXT:C284(vText1)

vi2:=Get last table number:C254
For (vi1; 1; vi2)
	vText1:=vText1+String:C10(vi1)+"\t"+Table name:C256(vi1)+"\r"
End for 
SET TEXT TO PASTEBOARD:C523(vText1)




ALERT:C41(Table name:C256(123))
ALERT:C41(Table name:C256(125))

ALERT:C41(Table name:C256(126))
ALERT:C41(Table name:C256(127))