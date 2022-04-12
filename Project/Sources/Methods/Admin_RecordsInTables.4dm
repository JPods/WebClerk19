//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Admin_RecordsInTables
	//Date: 07/01/02
	//Who: Bill
	//Get Record Counts
End if 

myDoc:=Create document:C266(Storage:C1525.folder.jitF+"RecordsInTables.txt")
If (OK=1)
	vi2:=Get last table number:C254
	ARRAY TEXT:C222(aText1; vi2)
	ARRAY TEXT:C222(aText2; vi2)
	ARRAY TEXT:C222(aText3; vi2)
	For (vi1; 1; vi2)
		aText1{vi1}:=Table name:C256(vi1)
		aText2{vi1}:=String:C10(Records in table:C83((Table:C252(vi1))->))
		aText3{vi1}:=String:C10(vi1)
		SEND PACKET:C103(myDoc; aText1{vi1}+"\t"+aText2{vi1}+"\t"+aText3{vi1}+"\r")
	End for 
	CLOSE DOCUMENT:C267(myDoc)
End if 