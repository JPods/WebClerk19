//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/11/10, 14:08:18
// ----------------------------------------------------
// Method: Set_Window_Title
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($protectedFieldNum)
C_TEXT:C284($uniqueKey; $strRecordNum)
C_POINTER:C301($1; ptCurTable)
If (ptCurTable#(->[Control:1]))
	$protectedFieldNum:=IEA_ReturnKeyField(ptCurTable)
	If ($protectedFieldNum>0)
		$uniqueKey:=" - "+PackMakeText(Field:C253(Table:C252(ptCurTable); $protectedFieldNum))
	Else 
		$uniqueKey:=""
	End if 
	//
	$thePage:=""
	$lockedStatus:=""
	If (Locked:C147(ptCurTable->))
		$lockedStatus:="Locked: "
	End if 
	If ((vHere>1) & (Size of array:C274(aPages)>0) & (aPages<=Size of array:C274(aPages)))
		$thePage:=aPages{aPages}+" - "
	End if 
	Case of 
		: (Is new record:C668(ptCurTable->))
			$strRecordNum:="New"
		: (Record number:C243(ptCurTable->)=-1)
			$strRecordNum:="No Record"
		Else 
			$strRecordNum:=String:C10(Record number:C243(ptCurTable->))
	End case 
	C_TEXT:C284(vWindowTitle)
	If (vWindowTitle="")
		SET WINDOW TITLE:C213($lockedStatus+Table name:C256(ptCurTable)+" - "+$thePage+$strRecordNum+$uniqueKey+" - "+Storage:C1525.default.company)  //+$locked)
	Else 
		SET WINDOW TITLE:C213($lockedStatus+Table name:C256(ptCurTable)+" - "+$thePage+$strRecordNum+$uniqueKey+" - "+Storage:C1525.default.company+" - "+vWindowTitle)
	End if 
	
End if 
