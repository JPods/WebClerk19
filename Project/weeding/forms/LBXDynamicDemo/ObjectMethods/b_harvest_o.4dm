var $form : Object
var $ptSubForm : Pointer
$ptSubForm:=OBJECT Get pointer:C1124("SF_Draft")
var $text; $text2 : Text
var $sf_o; $lb_o; $lb_tables : Object

$data:=ds:C1482[Form:C1466.dataClassName].all()
$lb_o:=OBJECT Get value:C1743("Form.LB_Tables")
$sf_o:=OBJECT Get value:C1743("Form.SF_Draft")



$sf_o:=OBJECT Get value:C1743(Form:C1466.widgets.subform.SF_Draft)
$lb_o:=OBJECT Get value:C1743(Form:C1466.widgets.subform.SF_Draft)

//form.widgets.subform[This.lbName]:=$listBox
//form.widgets.subform[This.name]:=$form

OBJECT GET SUBFORM:C1139(*; "SF_Draft"; $ptSubForm; $text; $text2)

ARRAY OBJECT:C1221($aObj; 0)
//FORM GET OBJECTS($aObj)

$properties:=New object:C1471(\
"enterable"; OBJECT Get enterable:C1067(*; $target); \
"allowWordwrap"; LISTBOX Get property:C917(*; $target; lk allow wordwrap:K53:39); \
"autoRowHeight"; LISTBOX Get property:C917(*; $target; lk auto row height:K53:72); \
"backgroundColorExpression"; LISTBOX Get property:C917(*; $target; lk background color expression:K53:47); \
"columnMinWidth"; LISTBOX Get property:C917(*; $target; lk column min width:K53:50); \
"columnResizable"; LISTBOX Get property:C917(*; $target; lk column resizable:K53:40); \
"detailFormName"; LISTBOX Get property:C917(*; $target; lk detail form name:K53:44); \
"displayFooter"; LISTBOX Get property:C917(*; $target; lk display footer:K53:20); \
"displayHeader"; LISTBOX Get property:C917(*; $target; lk display header:K53:4); \
"displayType"; LISTBOX Get property:C917(*; $target; lk display type:K53:46); \
"doubleClickOnRow"; LISTBOX Get property:C917(*; $target; lk double click on row:K53:43); \
"extraRows"; LISTBOX Get property:C917(*; $target; lk extra rows:K53:38); \
"fontColorExpression"; LISTBOX Get property:C917(*; $target; lk font color expression:K53:48); \
"fontStyleExpression"; LISTBOX Get property:C917(*; $target; lk font style expression:K53:49); \
"hideSelectionHighlight"; LISTBOX Get property:C917(*; $target; lk hide selection highlight:K53:41); \
"highlightSet"; LISTBOX Get property:C917(*; $target; lk highlight set:K53:66); \
"horScrollbarHeight"; LISTBOX Get property:C917(*; $target; lk hor scrollbar height:K53:7); \
"multiStyle"; LISTBOX Get property:C917(*; $target; lk multi style:K53:71); \
"namedSelection"; LISTBOX Get property:C917(*; $target; lk named selection:K53:67); \
"resizingMode"; LISTBOX Get property:C917(*; $target; lk resizing mode:K53:36); \
"rowHeightUnit"; LISTBOX Get property:C917(*; $target; lk row height unit:K53:42); \
"selectionMode"; LISTBOX Get property:C917(*; $target; lk selection mode:K53:35); \
"singleClickEdit"; LISTBOX Get property:C917(*; $target; lk single click edit:K53:70); \
"sortable"; LISTBOX Get property:C917(*; $target; lk sortable:K53:45); \
"truncate"; LISTBOX Get property:C917(*; $target; lk truncate:K53:37); \
"verScrollbarWidth"; LISTBOX Get property:C917(*; $target; lk ver scrollbar width:K53:9)\
)
//https://blog.4d.com/form-and-subform-communication-made-easy/