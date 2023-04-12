//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/17/21, 19:41:16
// ----------------------------------------------------
// Method: 019_FixQARelate
// Description
// 
// Parameters
// ----------------------------------------------------


var $recQ_o; $selQ_o; $recA_o; $selA_o : Object
var $cnt_i : Integer
$selQ_o:=ds:C1482.QAQuestion.all()
$cnt_i:=10

For each ($recQ_o; $selQ_o)
	$selA_o:=ds:C1482.QAAnswer.query("idNumQuestion = :1 "; $recQ_o.idNum).orderBy("answer asc, seq asc")
	$cnt_i:=$cnt_i+1
	$recQ_o.idNum:=$cnt_i
	$recQ_o.save()
	$seq_i:=1
	For each ($recA_o; $selA_o)
		$recA_o.idQAQuestion:=$recQ_o.id
		$recA_o.idNumQAQuestion:=$recQ_o.idNum
		$recA_o.seq:=$seq_i
		$recA_o.save()
		$seq_i:=$seq_i+1
	End for each 
End for each 

C_OBJECT:C1216(oRec; oSel)
oSel:=ds:C1482.QAAnswer.all()
For each (oRec; oSel)
	oRec.url:=""
	oRec.save()
End for each 

