Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Form:C1466.LBFrom:=""  // must clear to keep from always trying to drop another
		
		
		var $o : Object
		var $c : Collection
		//$o:=Form.LB_QAQuestion_cur.toObject("idNum")
		//$c:=Form.LB_QAQuestion_cur.toCollection("idNum")
		var $id_i; $cnt_i : Integer
		If (Form:C1466.LB_QAQuestion_cur#Null:C1517)
			
			Form:C1466.LB_QAAnswer:=ds:C1482.QAAnswer.newSelection(dk keep ordered:K85:11)
			Form:C1466.LB_QAAnswer:=Form:C1466.LB_QAQuestion_cur.ch_QAAnswers.orderBy("seq asc, answer asc")
			If (Form:C1466.LB_QAAnswer.first()#Null:C1517)
				If (Form:C1466.LB_QAAnswer[0].seq=0)
					$cnt_i:=0
					For each ($rec_ent; Form:C1466.LB_QAAnswer)
						$cnt_i:=$cnt_i+1
						$rec_ent.seq:=$cnt_i
						$rec_ent.save()
					End for each 
					
					
				End if 
			End if 
			
			
			//$id_i:=Form.LB_QAQuestion_cur.idNum
			//$id_i:=$o.idNum
			//Form.LB_QAAnswer:=ds.QAAnswer.query("idNumQuestion = :1"; $id_i).orderBy("seq asc, answer asc")
			//Form.LB_QAAnswer:=ds.QAAnswer.query("idNumQuestion = :1 "; Form.LB_QAQuestion_cur.idNum)
			//Form.LB_QAAnswer:=ds.QAAnswer.query("idQAQuestion = :1 "; Form.LB_QAQuestion_cur.idNum)
			// Form.LB_QAAnswer:=ds.QAAnswer.query("idQAQuestion = :1"; Form.LB_QAQuestion.item.idNum)
			// LISTBOX GET CELL POSITION(*; "LB_QAQuestion"; vCol_l; vRow_l)
		End if 
	: (Form event code:C388=On Data Change:K2:15)
		
		If (Form:C1466.LB_QAQuestion_cur#Null:C1517)
			Form:C1466.LB_QAQuestion_cur.save()
		End if 
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		LB:="LB_QAQuestion"
		
	: (Form event code:C388=On Drop:K2:12)
		$lbName:="LB_QAQuestion"
		
		var $position_i : Integer
		$position_i:=Drop position:C608
		For each ($rec_ent; Form:C1466.LB_QAQuestion_sel)
			$toPosition:=LBX_seqMov(Form:C1466.LB_QAQuestion; $rec_ent; $position_i)
			$position_i:=$position_i+1
		End for each 
		If ($toPosition>Form:C1466.LB_QAQuestion.length)
			$toPosition:=Form:C1466.LB_QAQuestion.length
		End if 
		
		//$toPosition:=LBX_seqMov(Form.LB_QAQuestion; Form.LB_QAQuestion_sel; Drop position)
		
		Form:C1466.LB_QAQuestion:=Form:C1466.LB_QAQuestion.orderBy("seq")
		LISTBOX SELECT ROW:C912(*; $lbName; $toPosition; lk replace selection:K53:1)  // ensure the dragged row is highlighted
		OBJECT SET SCROLL POSITION:C906(*; $lbName; $toPosition)
		
		If (False:C215)
			// perform the re-sequencing using the DataStore's function:
			ds:C1482.seqMove(Form:C1466.LB_QAQuestion; Form:C1466.LB_QAQuestion_cur; $dropPos_l; $seqName)  // given:
			// $es — entity selection
			// $en — the entity that was dragged (it will know its seq)
			// $toPosition — the row# to drag it to
			// $seqName — the name of the $en.Seq attribute that sets the sequencing
			$sortBy:=$seqName+" Ascending"
			$es.orderBy($sortBy)  // note: $sortBy is whatever you use, for instance:
			// "Seq Asc"
			LISTBOX SELECT ROW:C912(*; $lbName; $toPosition; lk replace selection:K53:1)  // ensure the dragged row is highlighted
			// maybe:
			OBJECT SET SCROLL POSITION:C906(*; $lbName; $toPosition)
		End if 
End case 