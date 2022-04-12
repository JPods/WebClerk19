//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/23/06, 00:15:08
// ----------------------------------------------------
// Method: CalendarSaveRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
C_POINTER:C301($2)


vResponse:="Table name not correctly stated."
$pageDo:=WC_DoPage("Error.html"; "")
$tableName:=WCapi_GetParameter("TableName"; "")
If ($tableName#"")
	$tableNum:=STR_GetTableNumber($tableName)
	If ($tableNum>0)
		$recordStr:=WCapi_GetParameter("RecordNum"; "")
		$recordNum:=Num:C11($recordStr)
		If (($recordStr#"0") & ($recordNum=0))
			$recordNum:=-1
		End if 
		If ($recordNum>=0)  //must have at least one record
			GOTO RECORD:C242(Table:C252($tableNum)->; $recordNum)
			$newRec:=False:C215
			If (Locked:C147(Table:C252($tableNum)->))
				vResponse:="Record was locked by another process.  Change was not saved."
			Else 
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				$pageDo:=WC_DoPage("Cwc"+$tableName+"One.html"; $jitPageOne)
				vResponse:="Changes Posted."
				WC_Parse($tableNum; $2; True:C214)
			End if 
		End if 
	End if 
End if 
$err:=WC_PageSendWithTags($1; $pageDo; 0)

