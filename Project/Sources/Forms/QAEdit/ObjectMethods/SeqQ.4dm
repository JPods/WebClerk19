var $rec_ent : Object
var $sel_ent : Object
var $id_c : Collection


$sel_ent:=Form:C1466.LB_QAQuestion_sel.orderBy("seq")
For each ($rec_ent; $sel_ent)
	If ($rec_ent.question[[4]]="-")
		$rec_ent.question:=Substring:C12($rec_ent.question; 5)
	End if 
	$rec_ent.question:=String:C10(questionCnt_i)+"-"+$rec_ent.question
	$rec_ent.save()
	questionCnt_i:=questionCnt_i+1
End for each 
Form:C1466.LB_QAQuestion:=Form:C1466.LB_QAQuestion

If (False:C215)
	var $inc_i; $cnt_i; $target_i : Integer
	$cnt_i:=Form:C1466.LB_QAQuestion_sel.length-1
	For ($inc_i; 0; $cnt_i)
		$rec_ent:=Form:C1466.LB_QAQuestion_sel[$inc_i]
		If ($rec_ent.question[[4]]="-")
			$rec_ent.question:=Substring:C12($rec_ent.question; 5)
		End if 
		$rec_ent.question:=String:C10(questionCnt_i)+"-"+$rec_ent.question
		$rec_ent.save()
		
	End for 
	questionCnt_i:=questionCnt_i+$cnt_i+1
End if 
If (False:C215)
	For each ($rec_ent; Form:C1466.LB_QAQuestion_sel)
		
		If ($rec_ent.question[[4]]="-")
			$rec_ent.question:=Substring:C12($rec_ent.question; 5)
		End if 
		$rec_ent.question:=String:C10(questionCnt_i)+"-"+$rec_ent.question
		$rec_ent.save()
		questionCnt_i:=questionCnt_i+1
		Form:C1466.LB_QAQuestion:=Form:C1466.LB_QAQuestion
	End for each 
End if 
