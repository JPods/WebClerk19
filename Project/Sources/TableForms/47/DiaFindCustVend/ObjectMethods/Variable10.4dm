C_LONGINT:C283($i; $k)
aText1:=0
If (Record number:C243([ItemSerial:47])>-1)
	Srl_SaveChanges
End if 
QUERY:C277([ItemSerial:47]; [ItemSerial:47]SerialNum:4=srSrlNum+"@")
TRACE:C157
If (Records in selection:C76([ItemSerial:47])>0)
	SELECTION TO ARRAY:C260([ItemSerial:47]ItemNum:1; aSrlItemSr; [ItemSerial:47]; aSrlRecNum; [ItemSerial:47]SerialNum:4; aSrNum)
	SORT ARRAY:C229(aSrNum; aSrlItemSr; aSrlRecNum)
	$k:=Size of array:C274(aSrlItemSr)
	ARRAY TEXT:C222(aText1; $k)
	For ($i; 1; $k)
		aText1{$i}:=aSrNum{$i}+"    "+aSrlItemSr{$i}
	End for 
	aText1:=1
	GOTO RECORD:C242([ItemSerial:47]; aSrlRecNum{aText1})
	srSrlNum:=[ItemSerial:47]SerialNum:4
Else 
	TRACE:C157
	ARRAY TEXT:C222(aText1; 0)
	REDUCE SELECTION:C351([ItemSerial:47]; 0)
End if 
doSearch:=1
HIGHLIGHT TEXT:C210(srSrlNum; 1; 30)