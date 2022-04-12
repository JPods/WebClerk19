//%attributes = {}

// Modified by: Bill James (2022-01-15T06:00:00Z)
// Method: Splash_TableLists
// Description
// Parameters
// ----------------------------------------------------
var $tableList_t; $1; $lbName : Text
$lbName:=$1
var $event_o; obDisplay : Object
var $viRow; viRow : Integer
$event_o:=FORM Event:C1606

Case of 
	: (Form event code:C388=On Load:K2:1)
		If ($lbName="LB_Primes")
			STR_PrimeListBox($lbName)
		Else 
			STR_TablesListBox($lbName)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		var $data; $rec; $new_o : Object
		var $tableName : Text
		//$tableName:=Form.LB_Primes.cur.tableName
		$tableName:=Form:C1466[$lbName].cur.tableName
		$data:=ds:C1482[$tableName].all()
		//$rec:=$data.first()
		$vtAddTitle:=""
		
		$new_o:=New object:C1471("ents"; New object:C1471($tableName; $data); \
			"ents"; $data; \
			"cur"; $data.first(); \
			"tableName"; $tableName; \
			"tableForm"; ""; \
			"form"; "OutputDS"; \
			"process"; Current process:C322)
		$childProcess:=New process:C317("Process_ShowTableDS"; 0; String:C10(Count user processes:C343)+"-"+$tableName; $new_o)
		
		
		//tableName:=Form.tableCurrent.tableName
		
		//STR_FieldsListBox
		
End case 