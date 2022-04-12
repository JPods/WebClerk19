//%attributes = {"publishedWeb":true}
If (<>vlRecNum>0)  //Pop a new record into existing process  
	jSaveRecord
	TRACE:C157
	GOTO RECORD:C242(<>ptCurTable->; <>vlRecNum)
	booPreNext:=True:C214
	POST KEY:C465(9; 0)
End if 
<>vlRecNum:=0