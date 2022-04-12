//C_LONGINT(<>vlCalc)
////If (<>vlCalc=0)
//TRACE
//QUERY([TallyResult];[TallyResult]TableNum=2;*)
//QUERY([TallyResult];&[TallyResult]Purpose=[Customer]customerID)
//Case of 
//: (Records in selection([TallyResult])=1)
//<>vlCalc:=Open external window(4;40;636;440;8;"";"_4D Calc")//to know
// if the module is here           
//SP FIELD TO AREA (<>vlCalc;Table(->[TallyResult]);Field(->
//[TallyResult]PictBlk1))
//: (Records in selection([TallyResult])=0)
//<>vlCalc:=Open external window(4;40;636;440;8;"";"_4D Calc")//to know
// if the module is here  
//CREATE RECORD([TallyResult])
// 
//[TallyResult]TableNum:=2
//[TallyResult]Purpose:=[Customer]customerID
//SAVE RECORD([TallyResult])
//Else 
//FIRST RECORD([TallyResult])
//<>vlCalc:=Open external window(4;40;636;440;8;"";"_4D Calc")//to know
// if the module is here           
//SP FIELD TO AREA (<>vlCalc;Table(->[TallyResult]);Field(->
//[TallyResult]PictBlk1))
//End case 
////End if 
//KeyModifierCurrent 
//If (OptKey=0)
//C_PICTURE($emptyPict)
//[TallyResult]PictBlk1:=$emptyPict
//
//$k:=Size of array(aQaQuest)
//C_LONGINT($maxWide;$keyQuest)
//C_Longint($spacer;$filler;$end)
//PVars_AddressFull (->[Customer];->CustAddress)
//SP SET CELL TEXT (<>vlCalc;SP Cell (1;1);CustAddress)
//$spacer:=6
//$filler:=6
//For ($i;1;$k)
//If (aQaGroup{$i}-aQaGroup{($i-1)}>1)
//$spacer:=aQaGroup{$i}+$filler
//$filler:=$spacer-aQaGroup{$i}+1
//End if 
//If (SP Get cell text (SP Cell (aQaAnsweredBy{$i};$spacer))="")
//SP SET CELL TEXT (<>vlCalc;SP Cell (aQaAnsweredBy{$i};$spacer);aQaQuest{$i})
//End if 
//SP SET CELL TEXT (<>vlCalc;SP Cell (aQaAnsweredBy{$i};aQaGroup{$i}+$filler)
//;aQaAnswr{$i})
//$end:=aQaGroup{$i}+$filler
//End for 
//[TallyResult]PictBlk1:=SP Area to pict (<>vlCalc)
//SAVE RECORD([TallyResult])
//
////SP ARRAY TO CELLS (<>vlCalc;0;0;aQaQuest;Size of array(aQaQuest);0)
////SP ARRAY TO CELLS (<>vlCalc;0;SP Cell (1;2);aQaAnswr;Size of array
//(aQaAnswr
////);0)//
//End if 