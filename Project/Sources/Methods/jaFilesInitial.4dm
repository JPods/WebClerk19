//%attributes = {"publishedWeb":true}
C_BOOLEAN:C305($1; $2)

<>aTableNames:=Find in array:C230(<>aTableNames; Table name:C256(ptCurTable))
curTableNum:=<>aTableNums{<>aTableNames}
//End if 
curTableNumAlt:=curTableNum
StructureFields(curTableNum)
If ($2)
	jaFilesFindSrch
End if 
