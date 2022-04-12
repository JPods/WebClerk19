//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/12/21, 02:59:56
// ----------------------------------------------------
// Method: WCapiTask_GetLines
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($tableName; $vtTableNameLC; $vtUUIDkey)
C_POINTER:C301($ptTable; $ptUUIDKey)
C_TEXT:C284($vtTableLines)
$tableName:=WCapi_GetParameter("tableName")
$vtUUIDkey:=WCapi_GetParameter("id")
If (($tableName="") | (Length:C16($vtUUIDkey)<20))
	vResponse:="Error: Missing tableName: "+$tableName+" or invalid id: "+$vtUUIDkey
Else 
	C_OBJECT:C1216($recPrime_ent; $voRecPrime; $voSelQA; $recQA_o)
	$recPrime_ent:=ds:C1482[$tableName].query("id = :1 "; $vtUUIDkey).first()
	If ($recPrime_ent=Null:C1517)
		vResponse:="Error: Table not valid: "+$tableName
	Else 
		vResponse:="Error: no QA"
		Case of 
			: ($tableName="Customer")  // get only for the customer
				
				//$voSelQA:=ds.QA.query(" idNumTask < 1 AND customerID = :1  "; "002002@")
				
				//$voSelQA:=ds.QA.query("customerID = :1 AND idNumTask < 1 "; $recPrime_ent.customerID)
				
				$voSelQA:=ds:C1482.QA.query("customerID = :1 AND idNumTask < 1 "; $recPrime_ent.customerID).orderBy("questionType asc, question asc")
				// ### bj ### 20210116_0945
				// will need to add some additional tables, but think everything should shift from customer ID to idNumTask 
				//look at converting customerID to UniqueID
			: (($tableName="Proposal") | ($tableName="Order") | ($tableName="WorkOrder") | ($tableName="Invoice") | ($tableName="Project"))
				If ($recPrime_ent.idNumTask<9)
					$recPrime_ent.idNumTask:=Task_New($recPrime_ent; $tableName)
					$recPrime_ent.save()
				End if 
				$voSelQA:=ds:C1482.QA.query("idNumTask = :1 "; $recPrime_ent.idNumTask).orderBy("questionType asc, question asc")
			: ($tableName="Vendor")
			: ($tableName="Item")
				
			Else 
				
		End case 
		If ($voSelQA.length>0)
			vResponse:=WcapiTask_QABuild($voSelQA)
		End if 
	End if 
End if 


