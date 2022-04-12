//%attributes = {}

// ----------------------------------------------------
// User name (OS): Riju Karar
// Date and time: 08/26/21, 21:04:24
// ----------------------------------------------------
// Method: LBX_ColumnBuildOne
// Description
// 
//
// Parameters
// ----------------------------------------------------

var $lbName_t; $tableName; $columnAdder_t : Text
var $1; $columnSetup_o; $columnSetup_o : Object
var $viCnt; $viInc : Integer
var $oneField_o; $fields_o : Object
var $NilPtr : Pointer
var $footerName_t; $headerName_t : Text

$columnSetup_o:=$1
$lbName_t:=$columnSetup_o.listboxName
$tableName:=$columnSetup_o.tableName
If ($columnSetup_o.number=Null:C1517)
	$columnSetup_o.number:=1
End if 
$columnAdder_t:=""
If ($columnSetup_o.adder#Null:C1517)
	$columnAdder_t:=$columnSetup_o.adder
End if 
If ($columnSetup_o.fieldType=Null:C1517)
	$columnSetup_o.fieldType:=ds:C1482[$columnSetup_o.tableName][$columnSetup_o.fieldName].fieldType
End if 
If ($columnSetup_o.fomula=Null:C1517)
	$columnSetup_o.fomula:="This."+$columnSetup_o.fieldName
End if 
$columnName_t:="Column_"+$columnSetup_o.tableName+"_"+$columnSetup_o.fieldName+"_"+$columnAdder_t
$headerName_t:="Header_"+$columnSetup_o.tableName+"_"+$columnSetup_o.fieldName+"_"+$columnAdder_t
$footerName_t:="Footer_"+$columnSetup_o.tableName+"_"+$columnSetup_o.fieldName+"_"+$columnAdder_t
LISTBOX INSERT COLUMN FORMULA:C970(*; $columnSetup_o.listboxName; $columnSetup_o.number; $columnName_t; $columnSetup_o.fomula; $columnSetup_o.fieldType; $headerName_t; $NilPtr; $footerName_t; $NilPtr)
var $vtTitle : Text
$vtTitle:=Uppercase:C13($columnSetup_o.fieldName[[1]])+Substring:C12($columnSetup_o.fieldName; 2; Length:C16($columnSetup_o.fieldName))
OBJECT SET TITLE:C194(*; $headerName_t; $vtTitle)

Case of 
	: ($columnSetup_o.fieldType=Is date:K8:7)
		LISTBOX SET COLUMN WIDTH:C833(*; $columnName_t; 70)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $columnName_t; Align center:K42:3)
		OBJECT SET FORMAT:C236(*; $columnName_t; Char:C90(System date short:K1:1))  // 1
		
	: ($columnSetup_o.fieldType=Is boolean:K8:9)
		LISTBOX SET COLUMN WIDTH:C833(*; $columnName_t; 40)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $columnName_t; Align center:K42:3)
	: ($columnSetup_o.fieldType=Is time:K8:8)
		
		LISTBOX SET COLUMN WIDTH:C833(*; $columnName_t; 70)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $columnName_t; Align center:K42:3)
		
		//OBJECT SET FORMAT(*; $columnName_t; HH MM AM PM))  // 5   Char(HH MM AM PM)
		
	: ($columnSetup_o.fieldType=Is longint:K8:6)
		
	: ($columnSetup_o.fieldType=Is real:K8:4)
		
		LISTBOX SET COLUMN WIDTH:C833(*; $columnName_t; 80)
		LISTBOX SET PROPERTY:C1440(*; $columnName_t; lk display type:K53:46; lk numeric format:K53:55)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $columnName_t; Align right:K42:4)
		Case of 
			: (($columnSetup_o.fieldName="@price@") | ($columnSetup_o.fieldName="@cost@") | ($columnSetup_o.fieldName="@tax@") | ($columnSetup_o.fieldName="@rate@"))
				OBJECT SET FORMAT:C236(*; $columnName_t; "###,###,###,##0.00")
				
				
		End case 
		
	: ($columnSetup_o.fieldType="string")
		Case of 
			: ($columnSetup_o.fieldName="@phone@")
				OBJECT SET FORMAT:C236(*; $columnName_t; "### ### (###) ###-####")
			Else 
		End case 
End case 


