//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/16/21, 20:45:54
// ----------------------------------------------------
// Method: QA_QTypeChange
// Description
// 
// Parameters
// ----------------------------------------------------


var $rec_ent; $sel_ent; $o : Object

$sel_ent:=ds:C1482.QAQuestion.query("questionType = :1"; Form:C1466.QType_cur.original)
For each ($rec_ent; $sel_ent)
	$rec_ent.questionType:=Form:C1466.QType_cur.qType
	$rec_ent.save()
	
End for each 
Form:C1466.QType_cur.original:=Form:C1466.QType_cur.qType
Form:C1466.LB_QAQuestion:=ds:C1482.QAQuestion.query("questionType = :1"; Form:C1466.QType_cur.qType).orderBy("seq asc, question asc")  //seq asc, 
Form:C1466.QType:=Form:C1466.QType