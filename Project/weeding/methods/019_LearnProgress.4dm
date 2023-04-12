//%attributes = {"publishedWeb":true}


// HOWTO:Progress
// this can be made more clear or better documented.
var $o; $rec_o : Object
var $progress : cs:C1710.progress
$progress:=cs:C1710.progress.new("Apply to Customer Records")
$o:=ds:C1482.Customer.all()

$progress.setTitle("Customer").setDelay(0).showStop()\
.forEach($o; Formula:C1597(Ui_demoProgressDoSomething); True:C214)
// Ui_demoProgressDoSomething : replace this with what ever we want to do with each entity.
$progress.close()
