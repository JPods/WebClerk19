var $rec_ent : Object

For each ($rec_ent; Form:C1466.LB_QAAnswer_sel)
	If ($rec_ent.answer[[4]]="-")
		$rec_ent.answer:=Substring:C12($rec_ent.answer; 5)
	End if 
	$rec_ent.save()
	Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAAnswer
End for each 
