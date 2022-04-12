//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/18/21, 00:51:31
// ----------------------------------------------------
// Method: WCapiTask_DeleteRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($tableName; $vtID)
C_OBJECT:C1216($obRec; $obSel)
$tableName:=WCapi_GetParameter("tableName")
$vtID:=WCapi_GetParameter("id")
Case of 
	: (($tableName="") | ($vtID=""))
		vResponse:="Error: Invalid value for tableName: "+$tableName+" or id: "+$vtID
	: (voUser.delete=False:C215)
		vResponse:="Error: Not authorized to delete."
	: (voUser.deleteList=False:C215)
		// find if access to delete that table
	: ($tableName="InvoiceLine")
		// manage if Jurnaled or not
		// etc
	Else 
		$obSel:=ds:C1482[$tableName].query("id = :1"; $vtID)
		If ($obSel.first()=Null:C1517)
			vResponse:="Error: No such record, tableName: "+$tableName+" or id: "+$vtID
		Else 
			// add a logging featue
			$obSel.first().delete()
			vResponse:="Success: Deleted id: "+$vtID
		End if 
End case 

