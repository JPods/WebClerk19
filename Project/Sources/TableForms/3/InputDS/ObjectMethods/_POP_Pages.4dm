jsetPages(->aPages)
Case of 
	: (aPages=6)
		If (Form:C1466.SF_QA=Null:C1517)
			OBJECT SET SUBFORM:C1138(*; "SF_QA"; "QA")
			SFEX_GetQA
			// change these to table names and clean up the data
		End if 
	: (aPages=7)
		If (Form:C1466.SF_Document=Null:C1517)
			OBJECT SET SUBFORM:C1138(*; "SF_Document"; "Document")
			SFEX_GetDocument
		End if 
End case 