var $sel_ent : Object
var $c; $cDistinct; $filter_c : Collection
var $query_t : Text
$filter_c:=New collection:C1472
$filter_c.push("answer")
$query_t:=Self:C308->+"@"
$sel_ent:=ds:C1482.QAAnswer.query("answer = :1"; $query_t)
If ($sel_ent#Null:C1517)
	$c:=$sel_ent.answer
	$cDistinct:=$c.distinct()
	Form:C1466.LB_AnswersAll:=Col_DistinctGet($cDistinct; "answer")
Else 
	Form:C1466.LB_AnswersAll:=New collection:C1472
End if 
Form:C1466.countAnswers:=Form:C1466.LB_AnswersAll.length

