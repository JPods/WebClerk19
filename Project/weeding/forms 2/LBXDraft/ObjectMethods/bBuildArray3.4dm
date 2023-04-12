

Form:C1466.form_o:=cs:C1710.cEditSubForm
Form:C1466.form_o:=cs:C1710.cEditSubForm.new("SF_Selection"; "Customer")
Form:C1466.form_o.setLBFromCollection(Form:C1466.LB_Fields.sel.extract("fieldName"))
LBX_SelectionIfEmpty(Form:C1466.form_o.lbName; Form:C1466.form_o.dataClassName)



Form:C1466.form_o:=cs:C1710.cEditSubForm
Form:C1466.form_o:=cs:C1710.cEditSubForm.new("SF_Selection"; "Customer")
var $recFC : Object
$recFC:=ds:C1482.FC.query("purpose = :1 and tableName = :2"; "formDefault"; "Customer").first()
Case of 
	: (Form:C1466.fieldlist#Null:C1517)  // make a default value that can be passed
		Form:C1466.form_o.setLBFromCollection(Split string:C1554(fieldList; ";"))
	: ($recFC=Null:C1517)
		// do nothing
	: ($recFC.data.rework.columns#Null:C1517)
		Form:C1466.form_o.setLBFromColumns($recFC.data.rework.columns)
		
	: ($recFC.data.rework.fieldList#"")
		Form:C1466.form_o.setLBFromCollection(Split string:C1554($recFC.data.rework.fieldList; ";"))
End case 