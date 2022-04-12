//%attributes = {"publishedWeb":true}
//October 6, 1995
//Procedure: File_eListScrip
C_LONGINT:C283($formEvent)
$formEvent:=Form event code:C388

Case of 
	: ($formEvent=On Load:K2:1)
		bNewRec:=0
		
		
		
	: (ALProEvt=0)
	: ((ALProEvt=1) | (ALProEvt=2))
		
		$w:=Find in array:C230(<>aTableNames; <>aTableNames{$nameSelect})
		If ($w>0)
			curTableNum:=<>aTableNums{$w}
			If (<>prcControl=5)
				$setName:="<>set"+Table name:C256(curTableNum)
				viRecordsInSelection:=Records in set:C195($setName)
			Else 
				viRecordsInSelection:=Records in selection:C76(Table:C252(curTableNum)->)
			End if 
			viRecordsInTable:=Records in table:C83(Table:C252(curTableNum)->)
		End if 
End case 
ALProEvt:=0