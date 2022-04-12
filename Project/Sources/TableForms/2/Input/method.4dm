
// Modified by: Bill James (2022-01-23T06:00:00Z)
// Method: [Customer].Input
// Description 
// Parameters
// ----------------------------------------------------

If (False:C215)  // QQQ testing
	If (Form event code:C388=On Load:K2:1)
		
		
		var $path; $text : Text
		$path:="Beldin:Users:williamjames:Documents:CommerceExpert:4D_Examples:sideORDA:sideORDA:Resources:nobel.json"
		If (Test path name:C476($path)=Is a document:K24:1)
			
			$text:=Document to text:C1236($path)
			
			Form:C1466.ents:=JSON Parse:C1218($text)
		End if 
	End if 
End if 
ILOCustomers
If (False:C215)
	C_BOOLEAN:C305(<>RecordToProcess)
	<>RecordToProcess:=True:C214
	If ((<>RecordToProcess=True:C214) & (Records in selection:C76(ptCurTable->)>1))
		$tableName_t:=Table name:C256(ptCurTable)
		$obPassable:=New object:C1471("tableName"; $tableName_t; "form"; "Input"; "tableForm"; $tableName_t+"_Input"; "id"; [Customer:2]id:127)
		UNLOAD RECORD:C212(ptCurTable->)
		CANCEL:C270
		$viProcess:=New process:C317("Process_ByID"; 0; $tableName_t+" - "+String:C10(Count tasks:C335); $obPassable)
	Else 
		
	End if 
End if 