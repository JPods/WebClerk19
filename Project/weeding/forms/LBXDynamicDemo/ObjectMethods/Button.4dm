var $form : Object
$form:=JSON Parse:C1218(jsonText)
Form:C1466.form_o:=cs:C1710.cEditSubForm.new("SF_Draft"; "Customer")
form_o.setSubForm(form_o.name; $form)