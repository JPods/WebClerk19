//%attributes = {}

// Modified by: Bill James (2022-04-08T05:00:00Z)
// Method: Form_SetSubForm
// Description 
// Parameters
// ----------------------------------------------------
var $1; $nameSF; $2; $tableName; $3; $nameForm : Text
$nameSF:=$1
$tableName:=$2
$nameForm:=$3


var _LB_ : Object
_LB_o:=New object:C1471("form"; New object:C1471; "ents"; New object:C1471)
$nameSF:="_LB_o"
$tableName:=""
$nameForm:="Document"


var $path_par; $path_doc : Text
var $path_o : Object
$path_par:=HFS_ParentName(Folder:C1567(fk resources folder:K87:11).platformPath)  //$path_t.parent
If ($tableName="")
	$path_doc:=$path_par+"Project"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"Forms"+Folder separator:K24:12+$nameForm
	If (Test path name:C476($path_doc)=0)
		OBJECT SET SUBFORM:C1138(*; $nameSF; $nameForm)
	Else 
		Form_Draft($nameSF; $tableName; $nameForm)
		OBJECT SET SUBFORM:C1138(*; $nameSF; $nameForm)
	End if 
Else 
	$path_par:=Storage:C1525.paths.localComEx
	var $tableNum : Integer
	$tableNum:=STR_GetTableNumber($tableName)
	$path_doc:=$path_par+"Project"+Folder separator:K24:12+"Sources"+Folder separator:K24:12+"TableForms"+Folder separator:K24:12+String:C10($tableNum)+Folder separator:K24:12+$nameForm
	If (Test path name:C476($path_doc)=0)
		OBJECT SET SUBFORM:C1138(*; $nameSF; Table:C252($tableNum)->; $nameForm)
	Else 
		Form_Draft($nameSF; $tableName; $nameForm)
		OBJECT SET SUBFORM:C1138(*; $nameSF; $tableName; $nameForm)
	End if 
End if 