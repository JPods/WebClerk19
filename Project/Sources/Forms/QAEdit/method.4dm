Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
		var $lb_Question_o; $LB_QAAnswer_o; $lb_QuestionTypes_o : Object
		var vtFieldList : Text
		var $cFilter : Collection
		var answerCnt_i; questionCnt_i : Integer
		answerCnt_i:=101
		questionCnt_i:=101
		Form:C1466.LBFrom:=""
		
		
		
		var $c; $c2 : Collection
		$c:=New collection:C1472
		Form:C1466.doCollections:=False:C215
		If (Form:C1466.doCollections)
			Form:C1466.LB_QAQuestion:=ds:C1482.QAQuestion.all().toCollection()
			Form:C1466.LB_QAAnswer:=ds:C1482.QAAnswer.all().toCollection()
			Form:C1466.LB_AnswersAll:=ds:C1482.QAAnswer.all().toCollection("answer")
		Else 
			Form:C1466.LB_QAQuestion:=ds:C1482.QAQuestion.all(dk keep ordered:K85:11)
			Form:C1466.LB_QAAnswer:=ds:C1482.QAAnswer.all(dk keep ordered:K85:11)
			$c:=ds:C1482.QAAnswer.all().toCollection("answer").distinct("answer").orderBy()
			//$c:=$c.distinct("answer")
			//$c:=$c.orderBy("answer asc")
		End if 
		$c2:=New collection:C1472
		For each ($anwer_t; $c)
			$c2.push(New object:C1471("answer"; $anwer_t))
		End for each 
		Form:C1466.LB_AnswersAll:=$c2
		var $questions_c; QATypes : Collection
		QATypes:=New collection:C1472
		Form:C1466.QATypes:=New collection:C1472
		//$questions_c:=New collection
		//$questions_c:=Form.questions
		$questions_c:=Form:C1466.LB_QAQuestion.distinct("questionType")
		For each ($text; $questions_c)
			Form:C1466.QATypes.push(New object:C1471("questionType"; $text))
		End for each 
		ARRAY LONGINT:C221(aSelected; 0)
		ARRAY TEXT:C222(at_QuestionType; 0)
		COLLECTION TO ARRAY:C1562($questions_c; at_QuestionType)
		var $o : Object
		$c2:=New collection:C1472
		For each ($anwer_t; $questions_c)
			$o:=New object:C1471("qType"; $anwer_t; "original"; $anwer_t)
			$c2.push($o)
		End for each 
		Form:C1466.QType:=$c2
		element_t:=""
End case 