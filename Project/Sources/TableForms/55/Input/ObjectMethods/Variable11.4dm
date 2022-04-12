GOTO RECORD:C242(Table:C252([TempRec:55]tableNum:1)->; [TempRec:55]RecordNumNew:3)
MODIFY RECORD:C57(Table:C252([TempRec:55]tableNum:1)->)
//If (curFile#File([TempRec]))
//vHere:=vHere-1
//aPagePath{curFile}:=1
//curFile:=File([TempRec])
//SET WINDOW TITLE(Filename([TempRec])+" - "+aPages{1}+" - "+String
//(curRecNum))
//End if 