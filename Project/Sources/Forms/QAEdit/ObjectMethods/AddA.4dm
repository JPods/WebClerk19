var $answer_t : Text

If (Form:C1466.LB_QAQuestion_cur=Null:C1517)
	ALERT:C41("You must choose a Question Type")
Else 
	
	$answer_t:=Request:C163("Enter new answer")
	Case of 
		: (($answer_t="") & (OK=1))
			ALERT:C41("You must enter a questiontype value")
		: (OK=1)
			
			QA_Add($answer_t)
			Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAAnswer
			
			// Form.LB_QAAnswer:=Form.LB_QAAnswer.orderBy("seq asc")
			//  $rec_ent
			//  Form.questionPosition
			
	End case 
	
End if 