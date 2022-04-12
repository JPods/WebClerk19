var $sel_ent : Object
var $c; $cDistinct; $filter_c : Collection
$filter_c:=New collection:C1472
$filter_c.push("answer")
$sel_ent:=ds:C1482.QAAnswer.query("answer :1"; Self:C308->+"@")
If ($sel_ent#Null:C1517)
	$c:=$sel_ent.toCollection($filter_c)
	Form:C1466.LB_AnswersAll:=Col_DistinctGet($c; "answer")
Else 
	Form:C1466.LB_AnswersAll:=New collection:C1472
End if 