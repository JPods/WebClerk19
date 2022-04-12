//%attributes = {}

// Modified by: Bill James (2022-01-04T06:00:00Z)
// Method: STR_PrimeListBox
// Description 
// Parameters
// ----------------------------------------------------
var $tableList_t; $1; $lbName : Text
$lbName:=$1
// HOWTO:   Folder Paths
//      $appPath:=Path to object(Application file)
//  If (Test path name(($appPath.parentFolder)+"XRAYCAPT.DLL")#Is a document)


If (Test path name:C476(Storage:C1525.folder.jitF+"jitPrefs"+Folder separator:K24:12+"PrimeTables.txt")=1)
	$tableList_t:=Document to text:C1236(Storage:C1525.folder.jitF+"jitPrefs"+Folder separator:K24:12+"PrimeTables.txt")
Else 
	$tableList_t:="Contact,Customer,Invoice,Item,Order,PO,Project,Proposal,Vendor,WebClerk"
End if 

C_COLLECTION:C1488($cTemp; $cWorking)
$cTemp:=New collection:C1472
$cWorking:=New collection:C1472
$cTemp:=Split string:C1554($tableList_t; ",")

C_TEXT:C284($vtProperty)
var $tableNum : Integer
For each ($vtProperty; $cTemp)
	If ($vtProperty#"zz@")
		$cWorking.push(New object:C1471("tableName"; $vtProperty; "tableNum"; ds:C1482[$vtProperty].getInfo().tableNumber))
	End if 
End for each 

Form:C1466[$lbName].ents:=$cWorking

If (LISTBOX Get number of columns:C831(*; $lbName)=0)
	LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName; 1; "tableName"; "This.tableName"; Is text:K8:3; "headerTable1"; $NilPtr)
	OBJECT SET TITLE:C194(*; "headerPrime1"; "TableName")
	LISTBOX SET COLUMN WIDTH:C833(*; "tableName"; 150)
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "tableName"; Align left:K42:2)
	LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName; 2; "tableNum"; "This.tableNum"; Is text:K8:3; "headerTable2"; $NilPtr)
	OBJECT SET TITLE:C194(*; "headerPrime2"; "Num")
	LISTBOX SET COLUMN WIDTH:C833(*; "tableNum"; 40; 60)
	OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "tableNum"; Align right:K42:4)
	
	var $width_i : Integer
	$width_i:=LISTBOX Get column width:C834(*; "tableNum")
	
End if 