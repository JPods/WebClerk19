//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/01/21, 22:50:33
// ----------------------------------------------------
// Method: LBX_FieldListClean
// Description
// 
// Parameters
// ----------------------------------------------------

var $0; $1; $listboxSetup_o : Object
var $tableName; $fieldList_t : Text
$listboxSetup_o:=$1
$tableName:=$listboxSetup_o.tableName
$fieldList_t:=$listboxSetup_o.fieldList

C_COLLECTION:C1488($cFilter)
$cFilter:=New collection:C1472
$cFilter:=Split string:C1554($fieldList_t; ",")
// $cFilter:=$cFilter.distinct()   // this sorts to change order
ARRAY TEXT:C222($atFields; 0)
COLLECTION TO ARRAY:C1562($cFilter; $atFields)
C_TEXT:C284($vtFieldName)
C_LONGINT:C283($viCount)

C_POINTER:C301($ptHeaderVar)
C_POINTER:C301($NilPtr)
C_OBJECT:C1216($obDateStore)

$obDateStore:=ds:C1482[$tableName]
ARRAY TEXT:C222($atFieldNames; 0)
ARRAY TEXT:C222($atUsedNames; 0)

// use in Output project layout 
$listboxSetup_o.fieldList:=$fieldList_t

var field_o : Object
var $inc; $cnt : Integer
var $columnSetup_o : Object
$columnSetup_o:=New object:C1471


STR_GetFieldNameList($tableName; ->$atFieldNames)
$fieldList_t:=""

// make sure these are first
If ($obDateStore.actionBy#Null:C1517)
	$fieldList_t:=$fieldList_t+"actionBy"+","
	APPEND TO ARRAY:C911($atUsedNames; "actionBy")  // assure field is only called once
End if 
If ($obDateStore.action#Null:C1517)
	$fieldList_t:=$fieldList_t+"action"+","
	APPEND TO ARRAY:C911($atUsedNames; "action")  // assure field is only called once
End if 
If ($obDateStore.actionDate#Null:C1517)
	$fieldList_t:=$fieldList_t+"actionDate"+","
	APPEND TO ARRAY:C911($atUsedNames; "actionDate")  // assure field is only called once
End if 
If ($obDateStore.actionTime#Null:C1517)
	$fieldList_t:=$fieldList_t+"actionTime"+","
	APPEND TO ARRAY:C911($atUsedNames; "actionTime")  // assure field is only called once
End if 

For each ($vtFieldName; $cFilter)
	$w:=Find in array:C230($atFieldNames; $vtFieldName)
	If ($w>0)
		$vtFieldName:=$atFieldNames{$w}  // correct for case
		$w:=Find in array:C230($atUsedNames; $vtFieldName)
		If ($w<1)
			APPEND TO ARRAY:C911($atUsedNames; $vtFieldName)  // assure field is only called once
			$fieldList_t:=$fieldList_t+$vtFieldName+","
			If (False:C215)
				$cFilter[$viCounter].push($vtFieldName)
				$cFilter[$viCounter]:=$vtFieldName
			End if 
		End if 
	End if 
End for each 
If (False:C215)  // does not need to be displayed.
	// must be in collections
	If (Find in array:C230($atUsedNames; "id")<1)
		$fieldList_t:=$fieldList_t+"id"
		APPEND TO ARRAY:C911($atUsedNames; "id")
	End if 
End if 
If ($fieldList_t="")
	$fieldList_t:="id"
	APPEND TO ARRAY:C911($atUsedNames; "id")
End if 
If ($fieldList_t[[Length:C16($fieldList_t)]]=",")
	$fieldList_t:=Substring:C12($fieldList_t; 1; Length:C16($fieldList_t)-1)
End if 

$columnSetup_o:=New object:C1471
$cnt:=Size of array:C274($atUsedNames)
For ($inc; 1; $cnt)
	field_o:=ds:C1482[$tableName][$atUsedNames{$inc}]
	$columnSetup_o[String:C10($inc)]:=New object:C1471("tableName"; $tableName; "fieldName"; $atUsedNames{$inc}; "formula"; "This."+$atUsedNames{$inc}; "width"; 110; "alignment"; Align left:K42:2; "format"; "")
	
	Case of 
		: (field_o.fieldType=Is time:K8:8)
			$columnSetup_o[String:C10($inc)].width:=70
			$columnSetup_o[String:C10($inc)].alignment:=Align center:K42:3
			//OBJECT SET FORMAT(*; $vtColumnName; HH MM AM PM))  // 5   Char(HH MM AM PM)
		: (field_o.type="string")
			Case of 
				: (field_o.name="@phone@")
					$columnSetup_o[String:C10($inc)].width:=100
					$columnSetup_o[String:C10($inc)].alignment:=Align left:K42:2
					$columnSetup_o[String:C10($inc)].format:="(###) ###-#### #### ####"
				: (field_o.name="@creditcardnum@")
					$columnSetup_o[String:C10($inc)].alignment:=Align left:K42:2
					$columnSetup_o[String:C10($inc)].format:="xxxx-xxxx-xxxx-####"
				: (field_o.name="@zip@")
					$columnSetup_o[String:C10($inc)].width:=70
				: (field_o.name="state")
					$columnSetup_o[String:C10($inc)].width:=60
				: (field_o.name="description")
					$columnSetup_o[String:C10($inc)].width:=220
			End case 
		: (field_o.type="date")
			$columnSetup_o[String:C10($inc)].width:=70
			$columnSetup_o[String:C10($inc)].alignment:=Align center:K42:3
			$columnSetup_o[String:C10($inc)].format:=Char:C90(System date short:K1:1)
			
			//LISTBOX SET COLUMN WIDTH(*; $vtColumnName; 70)
			//OBJECT SET HORIZONTAL ALIGNMENT(*; $vtColumnName; Align center)
			//OBJECT SET FORMAT(*; $vtColumnName; Char(System date short))  // 1
			
		: (field_o.type="bool")
			$columnSetup_o[String:C10($inc)].width:=70
			$columnSetup_o[String:C10($inc)].alignment:=Align left:K42:2
			//LISTBOX SET COLUMN WIDTH(*; $vtColumnName; 40)
			//OBJECT SET HORIZONTAL ALIGNMENT(*; $vtColumnName; Align center)
			
		: (field_o.type="number")
			$columnSetup_o[String:C10($inc)].width:=100
			Case of 
				: ((field_o.name="@cost@") | (field_o.name="@price@"))
					$columnSetup_o[String:C10($inc)].format:="###,###,###,###,##0.00"
					
				: ((field_o.name="@rate@") | (field_o.name="discount"))
					$columnSetup_o[String:C10($inc)].format:="###,###,##0.0"
					
				: (field_o.name="@wt@")
					$columnSetup_o[String:C10($inc)].width:=60
					$columnSetup_o[String:C10($inc)].format:="###,###,##0.0"
					
				: (field_o.name="@tax@")
					$columnSetup_o[String:C10($inc)].width:=70
					$columnSetup_o[String:C10($inc)].format:="###,###,###,###,##0.00"
					
			End case 
	End case 
	
End for 

$listboxSetup_o.columns:=$columnSetup_o
$0:=$listboxSetup_o

//LISTBOX SET COLUMN WIDTH(*; $vtColumnName; 80)
//LISTBOX SET PROPERTY(*; $vtColumnName; lk display type; lk numeric format)
//OBJECT SET HORIZONTAL ALIGNMENT(*; $vtColumnName; Align right)
//OBJECT SET FORMAT(*; $vtColumnName; "###,###,###,##0.00")