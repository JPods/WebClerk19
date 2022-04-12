//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/01/21, 15:38:51
// ----------------------------------------------------
// Method: DialogQuery
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_OBJECT:C1216($1; $formData)  // tableName and purpose
C_OBJECT:C1216($formData)
If (Count parameters:C259=1)
	$formData:=$1
Else 
	$formData:=New object:C1471("tableName"; "Customer"; "form"; "QueryEditor"; "process"; Current process:C322; "windowTitle"; "Query Editor")
End if 
If ($formData.tableName=Null:C1517)
	$formData.tableName:="Customer"
End if 
vtTableName:=$formData.tableName
If ($formData.form=Null:C1517)
	$formData.form:="QueryEditor"
End if 
If ($formData.securityLevel=Null:C1517)
	$formData.securityLevel:=1
End if 
If ($formData.role=Null:C1517)
	$formData.role:="Sales"
End if 

$formData.dataStore:=ds:C1482
$formData.dataClass:=ds:C1482.Customer  //This is the  Table search on

$formData.propertyList:=New collection:C1472  //We can also use $dataClass.keys() if we just need the names
$formData.propertySelected:=New object:C1471  //will be the current selected element in the propertyList
$formData.propertyPosition:=0  //will be the current selected element position in the propertyList (starting from 0)
$formData.ck_CurrentSel:=Null:C1517
$formData.dataClassName:=$formData.dataClass.getInfo().name

//   $formData.propertyListOriginal:=QRY_GetPropertyList("QRY"; $formData; $dataClass.all())

$cTemp:=New collection:C1472
$cTemp:=STR_GetTableNameCollection
$formData.cTables:=$cTemp
vtTableName:="Customer"
//$formData.dataClass:=ds.Customer
$formData.dataClass:=ds:C1482[vtTableName]

// STR_TablesListBox
$formData.cFields:=STR_FieldObject($formData.dataClassName)



$formData.criteria:=New collection:C1472
$formData.criteria_Cur:=New object:C1471
$formData.criteria_Pos:=0
$formData.clipObject:=Null:C1517  //This object will be used by the Drag & Drop
$formData.ck_CurrentSel:=New object:C1471  //$inSelection

$formData.windowTitle:="Query Editor"

Prs_ListActive
C_TEXT:C284($form_t)
C_LONGINT:C283($win_l)
C_LONGINT:C283($cascade_l)

$form_t:=$formData.form
C_OBJECT:C1216($obWindows)
$obWindows:=WindowCountToShow
$win_l:=Open form window:C675($form_t; Plain form window:K39:10; $obWindows.leftOffset; 53+$obWindows.topOffset; *)
SET WINDOW TITLE:C213($formData.windowTitle; $win_l)
$formData.windowID:=$win_l
DIALOG:C40($form_t; $formData)
CLOSE WINDOW:C154($win_l)