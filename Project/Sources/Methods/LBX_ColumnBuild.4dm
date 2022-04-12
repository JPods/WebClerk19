//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/31/21, 16:56:48
// ----------------------------------------------------
// Method: LBX_ColumnBuild
// REF: LBX_ColumnHarvest
// 
// Parameters
// ----------------------------------------------------
var $lbName_t; $tableName; $columnAdder_t : Text
var $1; $listboxSetup_o; $columnSetup_o : Object
var $viCnt; $viInc : Integer
var $oneField_o; $fields_o : Object

// setup the ListBox
$listboxSetup_o:=$1
$columnSetup_o:=$listboxSetup_o.columns
// setup below

$lbName_t:=$listboxSetup_o.listboxName
$tableName:=$listboxSetup_o.tableName

If ($listboxSetup_o.events=Null:C1517)
	$listboxSetup_o.events:=Split string:C1554("onLoad,onClick,onDataChange,onSelectionChange"; ",")
	
End if 








$viCnt:=LISTBOX Get number of columns:C831(*; $lbName_t)
If ($viCnt>0)
	LISTBOX DELETE COLUMN:C830(*; $lbName_t; 1; $viCnt)
End if 


$obDateStore:=ds:C1482[$tableName]
For each ($vtProperty; $columnSetup_o)
	$vtFieldName:=$columnSetup_o[$vtProperty].fieldName
	$viCount:=Num:C11($vtProperty)
	
	$vtColumnName:="Column_"+$lbName_t+"_"+$vtFieldName+"_"+$columnAdder_t
	$vtHeader:="Header_"+$lbName_t+"_"+$vtFieldName+"_"+$columnAdder_t
	$ptHeaderVar:=$NilPtr  // Get pointer($vtHeader)
	$vtColumnFormula:=$columnSetup_o[$vtProperty].formula
	
	LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName_t; $viCount; $vtColumnName; $vtColumnFormula; $obDateStore[$vtFieldName].fieldType; $vtHeader; $NilPtr)
	
	
	var $vtTitle : Text
	$vtTitle:=Uppercase:C13($vtFieldName[[1]])+Substring:C12($vtFieldName; 2; Length:C16($vtFieldName))
	OBJECT SET TITLE:C194(*; $vtHeader; $vtTitle)
	
	// OBJECT SET FORMAT(*;“Spalte”+String(al_SpNr{$i});Char(Num(at_SpFormat{$i})))
	Case of 
		: ($columnSetup_o.width#Null:C1517)
			LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; $columnSetup_o.width)
			If ($columnSetup_o.wordwrap#Null:C1517)
				
			End if 
			
			
		: ($obDateStore[$vtFieldName].type="date")
			LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 70)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align center:K42:3)
			OBJECT SET FORMAT:C236(*; $vtColumnName; Char:C90(System date short:K1:1))  // 1
			
		: ($obDateStore[$vtFieldName].type="bool")
			LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 40)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align center:K42:3)
		: ($obDateStore[$vtFieldName].type="number")
			
			Case of 
				: ($vtColumnName="@time@")
					LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 70)
					OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align center:K42:3)
					
				: ($obDateStore[$vtFieldName].fieldType=Is real:K8:4)
					LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 80)
					LISTBOX SET PROPERTY:C1440(*; $vtColumnName; lk display type:K53:46; lk numeric format:K53:55)
					OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align right:K42:4)
					OBJECT SET FORMAT:C236(*; $vtColumnName; "###,###,###,##0.00")
					
					
					//OBJECT SET FORMAT(*; $vtColumnName; HH MM AM PM))  // 5   Char(HH MM AM PM)
				Else 
					LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 80)
					LISTBOX SET PROPERTY:C1440(*; $vtColumnName; lk display type:K53:46; lk numeric format:K53:55)
					OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align right:K42:4)
					OBJECT SET FORMAT:C236(*; $vtColumnName; "###,###,###,##0")
			End case 
			
		: ($obDateStore[$vtFieldName].type="string")
			Case of 
				: (($vtFieldName="@phone@") | ($vtFieldName="@fax@"))
					OBJECT SET FORMAT:C236(*; $vtColumnName; "### ### (###) ###-####")
				Else 
			End case 
	End case 
End for each 
