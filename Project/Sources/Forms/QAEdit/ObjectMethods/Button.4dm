var element_t : Text
var $o : Object



// you cannot add to a 'static' entity selection, so ensure it is alterable
//  If (Not(Form.QType.isAlterable()))   // only for entity selections
//$es:=Form.QType.copy()  // turn it into being alterable
//Form.QType:=$es  // I suppose this is necessary.
// End if 
$o:=New object:C1471("qType"; element_t; "original"; element_t)
Form:C1466.QType.push($o)
Form:C1466.QType:=Form:C1466.QType


Form:C1466.LB_QAQuestion:=ds:C1482.QAQuestion.query("questionType = :1"; element_t).orderBy("seq asc, question asc")  //seq asc,
Form:C1466.LB_QAAnswer:=ds:C1482.QAAnswer.newSelection()