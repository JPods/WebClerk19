If (aAnswers>1)
	LB_QA_cur.answer:=aAnswers{aAnswers}
	LB_QA_cur.idNumQAAnswer:=aAnswerNums{aAnswers}
	LB_QA_cur.answeredBy:=Current user:C182
	LB_QA_cur.dateOfAnswer:=Current date:C33
	LB_QA_cur.save()
End if 
aAnswers:=1