//%attributes = {}
var $rec_ent; $sel_ent : Object
var $ans_ent; $selAns_ent : Object


$sel_ent:=ds:C1482.QAQuestion.all()
For each ($rec_ent; $sel_ent)
	$selAns_ent:=ds:C1482.QAAnswer.query("idNum = :1 "; $rec_ent.idNum)
	For each ($ans_ent; $selAns_ent)
		$ans_ent.idQAQuestion:=$rec_ent.id
		$ans_ent.save()
	End for each 
End for each 