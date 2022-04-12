var $rec_ent : Object
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Form:C1466.LBFrom:=""  // must clear to keep from always trying to drop another
		
	: (Form event code:C388=On Data Change:K2:15)
		
		If (Form:C1466.LB_QAAnswer_cur#Null:C1517)
			Form:C1466.LB_QAAnswer_cur.save()
		End if 
		
	: (Form event code:C388=On Drop:K2:12)
		
		If (Form:C1466.LBFrom="LB_AnswersAll")
			
			var $answer_t : Text
			For each ($rec_ent; Form:C1466.LB_AnswersAll_sel)
				// you cannot add to a 'static' entity selection, so ensure it is alterable
				QA_Add($rec_ent.answer)
			End for each 
			Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAAnswer
			
		Else 
			$lbName:="LB_QAAnswer"
			var $position_i : Integer
			$position_i:=Drop position:C608
			For each ($rec_ent; Form:C1466.LB_QAAnswer_sel)
				$toPosition:=LBX_seqMov(Form:C1466.LB_QAAnswer; $rec_ent; $position_i)
				$position_i:=$position_i+1
			End for each 
			If ($toPosition>Form:C1466.LB_QAQuestion.length)
				$toPosition:=Form:C1466.LB_QAQuestion.length
			End if 
			
			Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAAnswer.orderBy("seq")
			LISTBOX SELECT ROW:C912(*; $lbName; $toPosition; lk replace selection:K53:1)  // ensure the dragged row is highlighted
			OBJECT SET SCROLL POSITION:C906(*; $lbName; $toPosition)
		End if 
		
End case 