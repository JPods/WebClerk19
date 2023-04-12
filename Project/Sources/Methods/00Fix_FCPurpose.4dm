//%attributes = {}

var $rec_e; $sel_e : Object
var $new_t; $replace_t : Text

$sel_e:=ds:C1482.FC.query("name = :1"; "SF_cur")
For each ($rec_e; $sel_e)
	$rec_e.purpose:="setup"
	$rec_e.save()
End for each 

$sel_e:=ds:C1482.FC.query("name = :1"; "LB_Databrowser")
For each ($rec_e; $sel_e)
	$rec_e.purpose:="setup"
	$rec_e.save()
End for each 


$sel_e:=ds:C1482.FC.query("name = :1 && purpose = :2 "; "LB_Databrowser"; "")
For each ($rec_e; $sel_e)
	$rec_e.purpose:="setup"
	$rec_e.save()
End for each 

$sel_e:=ds:C1482.FC.all()

//sel_e:=ds.FC.query("name = :1"; "")
//sel_e.drop()

sel_e:=ds:C1482.FC.query("tableName = :1"; "Customer")

$sel_e:=ds:C1482.FC.query("tableName = :1"; "Customer")
For each ($rec_e; $sel_e)
	$rec_e.purpose:="setup"
	$rec_e.save()
End for each 



$sel_e:=ds:C1482.FC.query("name = :1"; "SF_Cur")
For each ($rec_e; $sel_e)
	$rec_e.purpose:="setup"
	$rec_e.save()
End for each 


$sel_e:=ds:C1482.FC.query("purpose = :1"; $replace_t)
For each ($rec_e; $sel_e)
	$rec_e.purpose:=$new_t
	$rec_e.save()
End for each 
