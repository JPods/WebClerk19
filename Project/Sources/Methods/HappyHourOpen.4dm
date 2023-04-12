//%attributes = {}
var $formOb; $ents : Object
$formOb:=New object:C1471
$formOb.demo_lb:=cs:C1710.listboxK.new("demo_lb"; "Customer")
$formOb.demo_lb.setSource(ds:C1482.Customer.all())

DIALOG:C40("HappyHour"; $formOb)

