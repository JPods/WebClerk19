//%attributes = {}

// Modified by: Bill James (2022-07-31T05:00:00Z)
// Method: LBX_DataBrowserSetTable
// Description 
// Parameters
// ----------------------------------------------------
TRACE:C157
TRACE:C157

// Depricate_yyy by: Bill James (2022-12-14T06:00:00Z)

//#DECLARE($tableName : Text; viewName : Text; $data : Object)
// add this to a cForm class
// get the FC record

// added to cForm Class to line 
var $fc_s; $fc_o : Object
// FC for the table and DataBrowser
$fc_s:=ds:C1482.FC.query("purpose = :1 and tableName = :2 and role = :3"; "DataBrowser"; Form:C1466.dataClassName; "rework18")
Case of 
	: ($fc_s.length>1)
		ConsoleLog("Multiple FC records for DataBrowser: "+Form:C1466.dataClassName+": "+String:C10($fc_s.length))
		// clean up if there are multiple records
		// should this be automated?
		$fc_o:=$fc_s.first()
	: ($fc_s.length=1)
		$fc_o:=$fc_s.first()
	Else 
		var $id : Text
		//$id:=STR_FCNew(Form.dataClassName; "DataBrowser")
		
		// it is not saving when passing out the object
		// get the entity
		Form:C1466.fc:=ds:C1482.FC.get($id)
End case 


// set key form properties
Form:C1466.fc:=$fc_o
// choose the default at start
Form:C1466.view:="default"



// for entry form
Form:C1466.entry.fields:=Form:C1466.fc.data.views[Form:C1466.view].entry.fields
//Form.entry.form_o:=New object
// subfrom_o should be replaced by Form.entry.form_o

// SF_cur should be replaced by the current record object

var entry_e : Object
entry_e:=Null:C1517
// defined listbox data
// line 35, the name of the Listbox is in Form.list.lbName
//Form.LB_Selection:=cs.listboxK.new(Form.list.lbName; Form.dataClassName)
Form:C1466[Form:C1466.list.lbName]:=cs:C1710.listboxK.new(Form:C1466.list.lbName; Form:C1466.dataClassName)

If ($data=Null:C1517)
	//LB_DataBrowser.setSource(ds[Form.dataClassName].all())
	Form:C1466[Form:C1466.list.lbName].setSource(ds:C1482[Form:C1466.dataClassName].all())
Else 
	//LB_DataBrowser.setSource($data)
	Form:C1466[Form:C1466.list.lbName].setSource($data)
End if 

If (ds:C1482[Form:C1466.dataClassName].actionBy#Null:C1517)
	// change from DataBrowswer
	//LB_DataBrowser.setMeta("DataBrowswer")
End if 

// define listbox
// why is this not 
// qqqWorking
// Form.LB_Selection_s:=cs.listboxStructure.new(Form.list.lbName; Form.dataClassName)
// Form.LB_Selection_s.setColumns()


Form:C1466[Form:C1466.list.lbName].setColumns()


//define the entry form

SF_cur:=cs:C1710.cEntry.new(Form:C1466.dataClassName; "DataBrowser"; "SF_cur")
SF_cur._setSubForm()  // space between fields
SF_cur._makeEntryChoices()

// populate the views list
ARRAY TEXT:C222(aViewsEntry; 0)
ARRAY TEXT:C222(aViewsList; 0)
var viewEntry_c; viewList_c : Collection
var $property_t : Text
viewEntry_c:=New collection:C1472
viewList_c:=New collection:C1472
For each ($property_t; Form:C1466.fc.data.views)
	viewEntry_c.push($property_t)
	viewList_c.push($property_t)
End for each 
viewEntry_c.orderBy()
viewList_c.orderBy()
// made a copy for the list


viewEntry_c.unshift("Text to Entry")  // push a value at the first position
viewEntry_c.unshift("Array to Entry")  // push a value at the first position
//viewEntry_c.unshift("From Empty")  // push a value at the first position
viewEntry_c.unshift("--")  // push a value at the first position
viewEntry_c.unshift("Delete")  // push a value at the first position
viewEntry_c.unshift("--")  // push a value at the first position
viewEntry_c.unshift("Save")  // push a value at the first position
viewEntry_c.unshift("Save New")  // push a value at the first positionviewEntry_c.unshift("-----")  // push a value at the first position
viewList_c.unshift("--")  // push a value at the first position
viewEntry_c.unshift("Views")  // push a value at the first position

$ptviewsEntry:=OBJECT Get pointer:C1124(Object named:K67:5; "pu_viewsEntry")



viewList_c.unshift("Text to List")  // push a value at the first position
viewList_c.unshift("Array to List")  // push a value at the first position
//viewList_c.unshift("From Empty")  // push a value at the first position
viewList_c.unshift("--")  // push a value at the first position
viewList_c.unshift("Delete")  // push a value at the first position
viewList_c.unshift("--")  // push a value at the first position
viewList_c.unshift("Save")  // push a value at the first position
viewList_c.unshift("Save New")  // push a value at the first position
viewList_c.unshift("--")  // push a value at the first position
viewList_c.unshift("Views")  // push a value at the first position


$ptviewsList:=OBJECT Get pointer:C1124(Object named:K67:5; "pu_viewsList")
//COPY ARRAY(viewEntry_c; $ptr->)
//$ptr->:=1

COLLECTION TO ARRAY:C1562(viewEntry_c; aViewsEntry)
var $w : Integer
$w:=Find in array:C230(aViewsEntry; viewName)
If ($w<1)
	aViewsEntry:=1
Else 
	aViewsEntry:=$w
End if 

COLLECTION TO ARRAY:C1562(viewEntry_c; aViewsList)
var $w : Integer
$w:=Find in array:C230(aViewsList; viewName)
If ($w<1)
	aViewsaViewsListEntry:=1
Else 
	aViewsList:=$w
End if 