//%attributes = {"publishedWeb":true}
//(P) jaFilesManage      aFiles;curTableNumAlt;integer for place used (import, apply)
C_BOOLEAN:C305($1)
C_LONGINT:C283($2)
If (<>aTableNums=0)
	<>aTableNums:=Table:C252(ptCurTable)
Else 
	If (<>aTableNames=0)
		<>aTableNames:=Find in array:C230(<>aTableNums; curTableNum)  //File(ptCurFile))
	Else 
		vSearchBy:=""
		curTableNum:=<>aTableNums{Find in array:C230(<>aTableNames; <>aTableNames{<>aTableNames})}
		Case of 
			: (<>aTableNames=0)  //a non selection was made, restore last value
				<>aTableNames:=Find in array:C230(<>aTableNums; curTableNumAlt)
				curTableNum:=curTableNumAlt
				//: (vHere>0)// trying to change file when not at Splash screen, alert restore
				//<>aTableNames:=Find in array(<>aTableNums;curTableNumAlt)
				//curTableNum:=curTableNumAlt
				//jAlertMessage (9002)
			: ((jRestrictedFile(Table:C252(curTableNum))) & (Count parameters:C259=4))  //prevents importing and applying to selection
				If ((Current user:C182="James Technologies") | ($2=1000))  //unless current user is James Tech
					StructureFields(curTableNum)
					If ($1)  //find the unique value
						jaFilesFindSrch
					End if 
					curTableNumAlt:=curTableNum
				Else 
					jAlertMessage(9001; $2)  //2nd parameter makes a choice possible
					<>aTableNames:=Find in array:C230(<>aTableNums; curTableNumAlt)
					curTableNum:=curTableNumAlt
				End if 
			Else   //implement the change in aFiles value, reset curTableNumAlt
				curTableNumAlt:=curTableNum
				StructureFields(curTableNum)
				If ($1)
					jaFilesFindSrch
				End if 
		End case 
	End if 
End if 