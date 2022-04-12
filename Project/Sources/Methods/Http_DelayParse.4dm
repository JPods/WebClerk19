//%attributes = {"publishedWeb":true}
//Procedure: Http_DelayParse
GOTO RECORD:C242(Table:C252([TempRec:55]tableNum:1)->; [TempRec:55]recordNumOrig:2)
WC_Parse([TempRec:55]tableNum:1; ->[TempRec:55]dataField:7)
// zzzqqq jDateTimeStamp(->[Proposal:42]commentProcess:64; [TempRec:55]nameid:8)
SAVE RECORD:C53(Table:C252([TempRec:55]tableNum:1)->)