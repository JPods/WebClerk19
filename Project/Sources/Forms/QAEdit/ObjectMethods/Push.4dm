Case of 
	: (Form:C1466.LB_AnswersAll_sel=Null:C1517)
		ALERT:C41("You must sellect choices below")
	: (Form:C1466.LB_QAQuestion_cur=Null:C1517)
		ALERT:C41("You must sellect a question.")
	Else 
		var $rec_ent : Object
		var $answer_t : Text
		For each ($rec_ent; Form:C1466.LB_AnswersAll_sel)
			// you cannot add to a 'static' entity selection, so ensure it is alterable
			QA_Add($rec_ent.answer)
		End for each 
		Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAAnswer
End case 