//%attributes = {"publishedWeb":true}
//Method: Before_New
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_TEXT:C284(vTextExecute)


If (process_o=Null:C1517)
	ConsoleLog("Form_process_o_init")
	Form_process_o_init
End if 
// critical that these be cleared to prevent constantly reloading the form. 
// inicated by arealist repeatedly resetting to the first line.

var $tm_o : Object
$tm_o:=ds:C1482.TallyMaster.query("name = :1 & purpose = :2"; "OnOpen_"+process_o.dataClassName; "ilo_OnLoadRecord").first()
If ($tm_o#Null:C1517)
	ExecuteText(0; $tm_o.script)  //no confirm
End if 




