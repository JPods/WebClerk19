If (Form:C1466.LB_QAQuestion_cur=Null:C1517)
	ALERT:C41("No Question selected.")
	
Else 
	
	var $o : Object
	var $rec_ent; $sel_ent : Object
	$sel_ent:=Form:C1466.LB_QAQuestion_sel
	For each ($rec_ent; $sel_ent)
		
		$o:=$rec_ent.ch_QAAnswers
		$o.drop(dk force drop if stamp changed:K85:17)
	End for each 
	
	$result_o:=Form:C1466.LB_QAQuestion_sel.drop(dk force drop if stamp changed:K85:17)
	
	LBX_seqReset(Form:C1466.LB_QAQuestion)
	
	Form:C1466.LB_QAQuestion:=Form:C1466.LB_QAQuestion.orderBy("seq asc")
	Form:C1466.LB_QAAnswer:=ds:C1482.QAAnswer.newSelection()
	
End if 