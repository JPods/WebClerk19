var $obFormEvent : Object
var obSel : Object
var docList : Object
$obFormEvent:=FORM Event:C1606

Case of 
	: ($obFormEvent.code=On Load:K2:1)
		_LB_QA_:=New object:C1471("ents"; New object:C1471; "cur"; New object:C1471; "sel"; New object:C1471; "pos"; -1; "formName"; "_LB_QA_"; "form"; New object:C1471; "meta"; New object:C1471)
		
		Case of 
			: (entryEntity.idNumTask#Null:C1517)
				If (entryEntity.idNumTask>9)
					_LB_QA_.ents:=ds:C1482.QA.query("idNumTask =:1"; entryEntity.idNumTask)
				Else 
					_LB_QA_.ents:=New object:C1471
				End if 
			: (entryEntity.customerID#Null:C1517)
				_LB_QA_.ents:=ds:C1482.QA.query("customerID = :1 AND idNumTask < 9"; entryEntity.customerID)
			Else 
				_LB_QA_.ents:=New object:C1471
		End case 
		
		_LB_QA_.ents:=process_o.ents
		_LB_QA_.cur:=_LB_QA_.ents.first()
		_LB_QA_.sel:=_LB_QA_.ents[0]
		
	: ($obFormEvent.code=On Drop:K2:12)
		
		
	: ($obFormEvent.code=On Double Clicked:K2:5)
		var $viRow : Integer
		LISTBOX SELECT ROW:C912(DocRecordList; $viRow)
		
		
	: ($obFormEvent.code=On Clicked:K2:4)
		var $viRow : Integer
		$viRow:=$obFormEvent.row
		If (LB_QA_cur#Null:C1517)
			ARRAY TEXT:C222(aAnswers; 0)
			ARRAY LONGINT:C221(aAnswerNums; 0)
			var $vtAnswer : Text
			var $row; $idNumQuestion : Integer
			var $rec_ent; $answers_ent : Object
			
			If (<>viDebugMode>210)
				ConsoleMessage("LB_QA_cur.question: "+LB_QA_cur.question)
			End if 
			$idNumQuestion:=LB_QA_cur.idNumQAQuestion
			$answers_ent:=ds:C1482.QAAnswer.query("idNumQAQuestion = :1"; $idNumQuestion).orderBy("seq asc, answer asc")
			For each ($rec_ent; $answers_ent)
				APPEND TO ARRAY:C911(aAnswers; $rec_ent.answer)
				APPEND TO ARRAY:C911(aAnswerNums; $rec_ent.idNum)
			End for each 
			
			SORT ARRAY:C229(aAnswers; aAnswerNums)
			INSERT IN ARRAY:C227(aAnswers; 1; 1)
			INSERT IN ARRAY:C227(aAnswerNums; 1; 1)
			aAnswers{1}:="Answers"
			aAnswerNums{1}:=-1
			aAnswers:=1
			
			pathQA_t:=LB_QA_cur.imagePath
			If (pathQA_t#"")
				En_ShowImage(pathQA_t; ->imageQA_p)
			Else 
				CLEAR VARIABLE:C89(imageQA_p)
			End if 
		Else 
			pathQA_t:=""
			CLEAR VARIABLE:C89(imageQA_p)
		End if 
		
	: ($obFormEvent.code=On Column Moved:K2:30)
		
		
	: ($obFormEvent.code=On Column Resize:K2:31)
		
End case 
