Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Form:C1466.LBFrom:=""  // must clear to keep from always trying to drop another
		If (Form:C1466.QType_cur#Null:C1517)
			//Form.LB_QAQuestion:=ds.QAQuestion.query("questionType = :1"; at_QuestionType{at_QuestionType}).toCollection().orderBy("seq asc, question asc")
			Form:C1466.LB_QAQuestion:=ds:C1482.QAQuestion.query("questionType = :1"; Form:C1466.QType_cur.qType).orderBy("seq asc, question asc")  //seq asc, 
			
			element_t:=Form:C1466.QType_cur.qType
			
			
			Form:C1466.LB_QAAnswer:=ds:C1482.QAAnswer.newSelection()
		End if 
		
		
	: (Form event code:C388=On Data Change:K2:15)
		
		
		QA_QTypeChange
		
End case 