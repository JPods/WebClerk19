//%attributes = {}
//YYYYY//YYYYY
// FORM_MERGE_PAGE_0 ( Form Object ) --> Page 0 of the form is merged into page 1 and nullified.
//https://discuss.4d.com/t/project-mode-using-forms-dynamically-loses-the-form-method-and-scripts/15597/3


//var $1 : Object  // the form object we operate on
//var $obj_Page0; $obj_Page1 : Object
//var $col_Page1ObjNames : Collection
//var $objName : Text
//If ($1.pages[0]#Null)  // if it is a useful page
//$obj_Page0:=$1.pages[0].objects
//$obj_Page1:=$1.pages[1].objects
//$col_Page1ObjNames:=colGetPropertyNames($obj_Page1)
//For each ($objName; $col_Page1ObjNames)  // transfer each page 1 into rear of page 0; then we will move page 0 to page 1 and NULL page 0
//$obj_Page0[$objName]:=OB Copy($obj_Page1[$objName])
//End for each 
//$1.pages[1]:=$1.pages[0]
//$1.pages[0]:=Null
//End if 