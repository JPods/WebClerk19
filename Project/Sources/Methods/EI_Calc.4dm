//%attributes = {"publishedWeb":true}

//Deactivated 050203
tkSpreadSheet:=1

//C_PICTURE($emptyPict)
//C_LONGINT(spWind;$reverse)
//$doColumns:=Num(Optkey=0)
//C_LONGINT($i;$k;$recCnt;$doColumns)
//$k:=Size of array(aMatchField)
//$recCnt:=Records in selection(Table(curTableNum)->)
//If ($k>0)
//spWind:=Open external window(4;40;636;440;8;Table name(curTableNum);"_4D
// Calc")//to know if the module is her
//SP UPDATE MODE (spWind;0)
//ARRAY LONGINT($fileNums;$k)
//ARRAY LONGINT($fieldNums;$k)
//ARRAY LONGINT($axis;$k)
//ARRAY LONGINT($aCells;$k)
//For ($i;1;$k)
//$fileNums{$i}:=curTableNum//the file number
//$fieldNums{$i}:=aMatchNum{$i}//the field number
//$axis{$i}:=$doColumns
//$aCells{$i}:=SP Cell ($i;2)
//SP SET CELL TEXT (spWind;SP Cell ($i;1);aMatchField{$i})
//SP SET TITLE NAME (spWind;$doColumns;$i;aMatchField{$i})
//End for 
//SP FIELDS TO CELLS (spWind;curTableNum;$fileNums;$fieldNums;$axis;$aCells
//;$k)
//SP UPDATE MODE (spWind;1)
//End if //