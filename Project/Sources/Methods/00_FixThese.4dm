//%attributes = {"publishedWeb":true}
If (False:C215)
	
	//reduce these down
	//WCapiTask_GetDocPath
	//WC_SendServerResponsePath
	//WC_SendServerResponse
	//WC_SendResponse
	//WCapi_Docs
	
	//WC_DoPage
	//WC_SetHeaderOut
	//WC_SetContentType
	//WC_SendBody
	
	// # of QA in customer, che idTask ,instead of idNumTask
	// check document drop
	
	
End if 

var $rec_ent; $sel_ent; $recQuestion_ent : Object
$sel_ent:=ds:C1482.QA.all()
For each ($rec_ent; $sel_ent)
	$recQuestion_ent:=ds:C1482.QAQuestion.query(" idNum = :1"; $rec_ent.questionKey).first()
	If ($recQuestion_ent#Null:C1517)
		$rec_ent.questionType:=$recQuestion_ent.questionType
		$rec_ent.save()
	End if 
End for each 