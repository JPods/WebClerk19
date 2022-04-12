//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/15/21, 16:42:28
// ----------------------------------------------------
// Method: Orphan_Answers
// Description
// 
// Parameters
// ----------------------------------------------------



var $rec_ent; $sel_ent; $question_ent : Object
var $boo_b : Boolean
var $o : Object
$o:=ds:C1482.QAAnswer

$boo_b:=False:C215
$sel_ent:=ds:C1482.QAAnswer.all()
var $orphans_t : Text
For each ($rec_ent; $sel_ent)
	$question_ent:=ds:C1482.QAQuestion.pa_QAQuestion
	If ($question_ent#Null:C1517)
		
	End if 
	$question_ent:=ds:C1482.QAQuestion.query("id = ;1 "; $rec_ent.idQAQuestion)
	If ($question_ent=Null:C1517)
		$rec_ent.seq:=-222
		$rec_ent.save()
	End if 
End for each 
$sel_ent:=ds:C1482.QAAnswer.query("seq = -222")
var $o : Object
var $c; $c2; $c3 : Collection
$c:=$sel_ent.answer
$c2:=$c.distinct()
$c3:=New collection:C1472
var $answer_t : Text
For each ($answer_t; $c2)
	$c3.push(New object:C1471("answer"; $answer_t))
End for each 

$answer_t:=JSON Stringify:C1217($c3)

$0:=$c3
If (False:C215)
	$myDoc:=Create document:C266(Storage:C1525.folder.jitExportsF+"AnswerOrphans_json.txt")
	If (OK=1)
		CLOSE DOCUMENT:C267($myDoc)
		TEXT TO DOCUMENT:C1237(document; $answer_t)
	End if 
End if 