var $rec_ent : Object
var $sel_ent : Object


$sel_ent:=Form:C1466.LB_QAAnswer_sel.orderBy("seq")

For each ($rec_ent; $sel_ent)
	If ($rec_ent.answer[[4]]="-")
		$rec_ent.answer:=Substring:C12($rec_ent.answer; 5)
	End if 
	$rec_ent.answer:=String:C10(answerCnt_i)+"-"+$rec_ent.answer
	$rec_ent.save()
	answerCnt_i:=answerCnt_i+1
End for each 
Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAAnswer
