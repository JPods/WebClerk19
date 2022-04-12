jaFilesManage(True:C214; 2)
//  --  CHOPPED  AL_UpdateArrays(eSrchFlds; -2)
// -- AL_SetSort(eSrchFlds; 1)
//
QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=curTableNum; *)
QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="search")
SELECTION TO ARRAY:C260([TallyMaster:60]name:8; aTmp20Str1; [TallyMaster:60]; aTmpLong1)
SORT ARRAY:C229(aTmp20Str1; aTmpLong1)
//  --  CHOPPED  AL_UpdateArrays(eSrchRecs; -2)
UNLOAD RECORD:C212([TallyMaster:60])
//