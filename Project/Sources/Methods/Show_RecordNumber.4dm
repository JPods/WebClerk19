//%attributes = {"publishedWeb":true}
//Method: Show_RecordNumber
C_LONGINT:C283($recNum; $curTableNum)
Case of 
	: (Count parameters:C259=0)
		$curTableNum:=Table:C252(ptCurTable)
		$recNum:=Num:C11(Request:C163("Enter Record Number for "+Table name:C256($curTableNum)))
	: (Count parameters:C259=1)
		$curTableNum:=Table:C252(ptCurTable)
		If ($1<0)
			$recNum:=Num:C11(Request:C163("Enter Record Number for "+Table name:C256($curTableNum)))
		Else 
			$recNum:=$1
		End if 
	: (Count parameters:C259=2)
		$curTableNum:=$2
		If ($1<0)
			$recNum:=Num:C11(Request:C163("Enter Record Number for "+Table name:C256($curTableNum)))
		Else 
			$recNum:=$1
		End if 
End case 
GOTO RECORD:C242((Table:C252($curTableNum))->; $recNum)
