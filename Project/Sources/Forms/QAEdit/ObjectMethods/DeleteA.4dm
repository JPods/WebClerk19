If (Form:C1466.LB_QAAnswer_cur=Null:C1517)
	ALERT:C41("No Answer selected.")
	
Else 
	var $o : Object
	$o:=Form:C1466.LB_QAAnswer_sel
	$result_o:=$o.drop(dk force drop if stamp changed:K85:17)
	
	
	LBX_seqReset(Form:C1466.LB_QAAnswer)
	Form:C1466.LB_QAAnswer_sel:=New object:C1471
	Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAQuestion_cur.ch_QAAnswers.orderBy("seq asc, answer asc")
End if 