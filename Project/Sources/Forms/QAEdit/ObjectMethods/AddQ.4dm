var $answer_t : Text

If (Form:C1466.QType_cur#Null:C1517)
	
	$answer_t:=Request:C163("Enter new question")
	Case of 
		: (($answer_t="") & (OK=1))
			ALERT:C41("You must enter a questiontype value")
		: (OK=1)
			
			If (False:C215)
				// this uses:  Form.es = the selection; Form.en = the entity you want to append
				// you cannot add to a 'static' entity selection, so ensure it is alterable
				If (Not:C34(Form:C1466.es.isAlterable()))
					// ** I don't know if this is necessary to put into 2 steps; at the time
					//    I was coding, it seemed to be necessary to get everything to work
					$es:=Form:C1466.es.copy()  // turn it into being alterable
					Form:C1466.es:=$es  // I suppose this is necessary. 
				End if 
				Form:C1466.es.add(Form:C1466.en)  // add it to the current selection
				Form:C1466.es:=Form:C1466.es  // necessary to force the listbox to redraw
			End if 
			
			var $i : Integer
			var $c : Collection
			$c:=Form:C1466.LB_QAQuestion.seq
			If ($c.length=0)
				$i:=1
			Else 
				$i:=$c.max()+1
			End if 
			
			var $rec_ent : Object
			$rec_ent:=ds:C1482.QAQuestion.new()
			$rec_ent.questionType:=Form:C1466.QType_cur.qType
			$rec_ent.seq:=$i
			$rec_ent.question:=$answer_t
			$rec_ent.save()
			
			// you cannot add to a 'static' entity selection, so ensure it is alterable
			If (Not:C34(Form:C1466.LB_QAQuestion.isAlterable()))
				$es:=Form:C1466.LB_QAQuestion.copy()  // turn it into being alterable
				Form:C1466.LB_QAQuestion:=$es  // I suppose this is necessary.
			End if 
			Form:C1466.LB_QAQuestion.add($rec_ent)
			Form:C1466.LB_QAQuestion:=Form:C1466.LB_QAQuestion
			
			Form:C1466.anwers:=New object:C1471
	End case 
	
Else 
	ALERT:C41("You must choose a Question Type")
End if 