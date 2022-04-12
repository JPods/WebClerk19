var $rec_ent : Object

For each ($rec_ent; Form:C1466.LB_QAQuestion_sel)
	
	If ($rec_ent.question[[4]]="-")
		$rec_ent.question:=Substring:C12($rec_ent.question; 5)
	End if 
	$rec_ent.save()
	Form:C1466.LB_QAQuestion:=Form:C1466.LB_QAQuestion
End for each 

