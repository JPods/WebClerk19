//%attributes = {"publishedWeb":true}
//
//
//vi2:=Records in selection([Item])
//SELECTION TO ARRAY([Item];aTmpLong1)
//For (vi1;1;vi2)
//GOTO RECORD([Item];aTmpLong1{vi1})
//POP RECORD([Item])
//[Item]ItemNum:=srItemNum
//ItemNumChange (srItemNum)//
//