If ([Invoice:26]consignment:63="")
	Open window:C153(440; 325; 699; 435; 1)
	GOTO XY:C161(1; 4)
	MESSAGE:C88("Completed or empty to journalize")
	DELAY PROCESS:C323(Current process:C322; 40)
End if 
entryEntity.consignment:=DE_PopUpArray(Self:C308)