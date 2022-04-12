If (Records in set:C195("UserSet")#1)
	ALERT:C41("You much highlight one and only one record.")
Else 
	COPY SET:C600("UserSet"; "<>curSelSet")
	//<>prcControl:=21
	DB_ShowCurrentSelection(->[SyncMap:112]; ""; 21; "SyncBlobs"; 1)
	//ptTable; script; processPathDirect; nameAdder; manageSelection (no change in SyncRecord)
End if 