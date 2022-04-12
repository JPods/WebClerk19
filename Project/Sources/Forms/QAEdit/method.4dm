Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
		var $lb_Question_o; $LB_QAAnswer_o; $lb_QuestionTypes_o : Object
		var vtFieldList : Text
		var $cFilter : Collection
		var answerCnt_i; questionCnt_i : Integer
		answerCnt_i:=101
		questionCnt_i:=101
		Form:C1466.LBFrom:=""
		
		If (False:C215)
			$fieldsQuestions:="question,seq,questionType,idNum,id"
			
			$lb_Question_o:=New object:C1471("listboxName"; "LB_QAQuestion"; "tableName"; "QAQuestion"; "fieldList"; $fieldsQuestions; "priority"; "fieldList")
			//$lb_Question_o:=LBX_DraftFromFieldString($lb_Question_o)
			
			$lb_Question_o:=LBX_FieldListClean($lb_Question_o)
			LBX_ColumnBuild($lb_Question_o)
			LISTBOX SET COLUMN WIDTH:C833(*; "Column_QAQuestion_question_"; 200)
			
			
			
			$fieldsAnswers:="answer,seq"
			
			$LB_QAAnswer_o:=New object:C1471("listboxName"; "LB_QAAnswer"; "tableName"; "QAAnswer"; "fieldList"; $fieldsAnswers; "priority"; "fieldList")
			//$LB_QAAnswer_o:=LBX_DraftFromFieldString($LB_QAAnswer_o)
			
			$LB_QAAnswer_o:=LBX_FieldListClean($LB_QAAnswer_o)
			LBX_ColumnBuild($LB_QAAnswer_o)
			LISTBOX SET COLUMN WIDTH:C833(*; "Column_QAAnswer_answer_"; 230)
		End if 
		
		If (False:C215)  // could not get it to work, using na array below
			
			$fieldsQuestionTypes:="questionType"
			
			$lb_QuestionTypes_o:=New object:C1471("listboxName"; "LB_QuestionTypes"; "tableName"; "jjQAType"; "fieldList"; $fieldsQuestionTypes; "priority"; "fieldList")
			
			$columnAdder_t:=""
			var field_o : Object
			var $inc; $cnt : Integer
			var $columnSetup_o : Object
			$columnSetup_o:=New object:C1471
			$cFilter:=New collection:C1472
			$cFilter:=Split string:C1554($fieldList_t; ",")
			$inc:=0
			$tableName:="jjQAType"
			For each ($vtFieldName; $cFilter)
				$inc:=$inc+1
				$columnSetup_o[String:C10($inc)]:=New object:C1471("tableName"; $tableName; "fieldName"; $vtFieldName; "formula"; "This."+$vtFieldName; "width"; 110; "alignment"; Align left:K42:2; "format"; "")
				
				
				$vtFieldName:=$columnSetup_o[$vtProperty].fieldName
				$viCount:=Num:C11($vtProperty)
				
				$vtColumnName:="Column_"+$tableName+"_"+$vtFieldName+"_"+$columnAdder_t
				$vtHeader:="Header_"+$tableName+"_"+$vtFieldName+"_"+$columnAdder_t
				$ptHeaderVar:=$NilPtr  // Get pointer($vtHeader)
				$vtColumnFormula:=$columnSetup_o[$vtProperty].formula
				$vtColumnFormula:="Form."+$vtFieldName
				LISTBOX INSERT COLUMN FORMULA:C970(*; $lbName_t; $viCount; $vtColumnName; $vtColumnFormula; $obDateStore[$vtFieldName].fieldType; $vtHeader; $NilPtr)
				var $vtTitle : Text
				$vtTitle:=Uppercase:C13($vtFieldName[[1]])+Substring:C12($vtFieldName; 2; Length:C16($vtFieldName))
				OBJECT SET TITLE:C194(*; $vtHeader; $vtTitle)
				
				LISTBOX SET COLUMN WIDTH:C833(*; $vtColumnName; 120)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $vtColumnName; Align left:K42:2)
				
				
			End for each 
			
		End if 
		
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