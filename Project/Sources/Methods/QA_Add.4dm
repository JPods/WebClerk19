//%attributes = {}
// generalize this
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/17/21, 12:42:56
// ----------------------------------------------------
// Method: QA_Add
// Description
// 
// Parameters
// ----------------------------------------------------
var $1 : Text
var $i : Integer
var $c : Collection
$c:=Form:C1466.LB_QAAnswer.seq
If ($c.length=0)
	$i:=1
Else 
	$i:=$c.max()+1
End if 

var $rec_ent : Object
$rec_ent:=ds:C1482.QAAnswer.new()
$rec_ent.seq:=$i
$rec_ent.answer:=$1
$rec_ent.idQAQuestion:=Form:C1466.LB_QAQuestion_cur.id
$rec_ent.idNumQAQuestion:=Form:C1466.LB_QAQuestion_cur.idNum
$rec_ent.save()

// you cannot add to a 'static' entity selection, so ensure it is alterable
If (False:C215)  // not a feature in 18
	If (Not:C34(Form:C1466.LB_QAAnswer.isAlterable()))
		$es:=Form:C1466.LB_QAAnswer.copy()  // turn it into being alterable
		Form:C1466.LB_QAAnswer:=$es  // I suppose this is necessary.
	End if 
End if 
Form:C1466.LB_QAAnswer.add($rec_ent)
