KeyModifierCurrent
C_TEXT:C284($wild)
$wild:="@"
If (OptKey=0)
	$wild:=""
Else 
	$wild:="@"
End if 
If (cmdKey=0)
	QUERY:C277([ItemSerial:47]; [ItemSerial:47]itemNum:1=vSnItmAlpha+$wild; *)
	QUERY:C277([ItemSerial:47];  & [ItemSerial:47]serialNum:4=vsnSrNum+$wild)
Else 
	QUERY:C277([ItemSerial:47])
End if 
Srl_FillRay(Records in selection:C76([ItemSerial:47]))
ARRAY LONGINT:C221(aSrRecSel; 0)
//  --  CHOPPED  AL_UpdateArrays(eListSrNums; -2)