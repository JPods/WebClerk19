var $rec_ent; $sel_ent; $question_ent : Object
var $c; $c2; $cDistinct; $filter_c : Collection
$boo_b:=False:C215
$sel_ent:=ds:C1482.QAAnswer.all()
$c:=$sel_ent.answer
$cDistinct:=$c.distinct()
Form:C1466.LB_AnswersAll:=Col_DistinctGet($cDistinct; "answer")
Form:C1466.countAnswers:=Form:C1466.LB_AnswersAll.length
Form:C1466.LB_AnswersAll:=Form:C1466.LB_AnswersAll