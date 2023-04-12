//%attributes = {}


var $form_o; $method_o; $file_o; $format_o : Object
$file_o:=File:C1566("/Users/williamjames/Documents/"+\
"CommerceExpert/00WebClerk19/"+\
"Project/Sources/Forms/OutputDS/form.4DForm"; fk posix path:K87:1)
$method_o:=File:C1566("/Users/williamjames/Documents/"+\
"CommerceExpert/00WebClerk19/"+\
"Project/Sources/Forms/OutputDS/method.4dm"; \
fk posix path:K87:1)
$method_o:=File:C1566("/SOURCES/Forms/OutputDS/method.4dm"; \
fk posix path:K87:1)
var $rec_e : Object
$rec_e:=ds:C1482.FC.new()
$rec_e.purpose:="FCForm"
$rec_e.name:=process_o.dialog
$rec_e.data:=New object:C1471(\
"form"; $file_o; \
"method"; $method_o; \
"format"; $format_o)
$rec_e.role:="admin"
$rec_e.securityLevel:=5000
$rec_e.status:="created"
$rec_e.obGeneral:=Init_obGeneral
$rec_e.save()

