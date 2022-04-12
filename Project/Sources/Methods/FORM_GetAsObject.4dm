//%attributes = {}
//YYYYY
// FORM_GetAsObject ( $formName; {mergePage0} ) --> get this form either from this component or its ‘master’ DB. — mergePage0:Boolean = TRUE if we want page 0 merged into page 1
//https://discuss.4d.com/t/project-mode-using-forms-dynamically-loses-the-form-method-and-scripts/15597/3


//var $1 : Text  // the name of the form to retrieve as an object
//var $2; $mergePage0 : Boolean
//$mergePage0:=Choose(Count parameters>1; $2; False)
//var $0; $obj_Form : Object  // the resulting Form Object
//$obj_Form:=JSON Parse(Storage.folder_ProjectForms.Folder($1).File(“form.4DForm”).getText(); Is object)  // this retrieves the FORM as an object
//If ($mergePage0)  // if they want page zero merged into page one…
//FORM_MERGE_PAGE_0($obj_Form)  // merge it
//End if 
//// —— To preserve the functionality of any FORM METHOD, we need to change it to ‘doMyScript’, which will be smart enough to get the script performed
//If ($obj_Form.method#_Blank)
//$obj_Form.method:=“doMyFormMethod”  // if there is a form method, we can only get it performed this way.
//End if 