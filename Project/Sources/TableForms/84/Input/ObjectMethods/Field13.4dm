C_LONGINT:C283($numSelect)
If ((curTableNum>0) & (curTableNum<=Get last table number:C254))
	$numSelect:=Find in array:C230(<>aTableNums; curTableNum)
	
Else 
	ALERT:C41("Invalid TableNum")
	[Map:84]tableNum:15:=2
	[Map:84]tableName:10:="Customer"
	//[Map]FieldNum:=1
	//[Map]FieldName:="customerID"
End if 