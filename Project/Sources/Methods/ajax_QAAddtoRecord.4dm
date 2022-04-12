//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/25/21, 21:38:27
// ----------------------------------------------------
// Method: ajax_QAAddtoRecord
// Description
// 
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0; $vResponse)
C_LONGINT:C283($viIncrement; $viCount)
C_TEXT:C284($vtQuestionType; $tableName; $vtUUIDKey)
C_LONGINT:C283($viTableNum; $vitaskID; $viCount; $viIncrement; $dtCreated)

var $enPrimary; $enRecQuestion; $enRecQuestion; $enQA : Object


$vtQuestionType:=WCapi_GetParameter("QuestionType"; "")

$tableName:=voState.request.parameters.tableNameTarget
$vtUUIDKey:=WCapi_GetParameter("id"; "")

If ($vtUUIDKey#"")
	$ptTable:=STR_GetTablePointer($tableName)
	If (Not:C34(Is nil pointer:C315($ptTable)))
		$ptUUIDKey:=STR_GetFieldPointer($tableName; "id")
		$enPrimary:=ds:C1482[$tableName].query("id = :1 "; $vtUUIDKey).first()
		var $doTaskID : Boolean
		If ($enPrimary#Null:C1517)
			Case of 
				: ($ptTable=(->[Customer:2]))
					$vtcustomerID:=$enPrimary.customerID
				: ($ptTable=(->[Contact:13]))
					$vtcustomerID:=String:C10($enPrimary.idNum)
				: ($ptTable=(->[Vendor:38]))
					$vtcustomerID:=$enPrimary.vendorID
				: ($ptTable=(->[Item:4]))
					$vtcustomerID:=$enPrimary.itemNum
					
					
				: ($ptTable=(->[Order:3]))
					$vtcustomerID:=$enPrimary.customerID
					$doTaskID:=True:C214
				: ($ptTable=(->[Invoice:26]))
					$vtcustomerID:=$enPrimary.customerID
					$doTaskID:=True:C214
				: ($ptTable=(->[Proposal:42]))
					$vtcustomerID:=$enPrimary.customerID
				: ($ptTable=(->[PO:39]))
					$vtcustomerID:=$enPrimary.vendorID
				: ($ptTable=(->[WorkOrder:66]))
					$vtcustomerID:=$enPrimary.customerID
					$doTaskID:=True:C214
				: ($ptTable=(->[Project:24]))
					$vtcustomerID:=$enPrimary.customerID
					$doTaskID:=True:C214
			End case 
			$viTableNum:=Table:C252($ptTable)
			$vitaskID:=0
			var $max_i : Integer
			// find if there is a taskID
			If ($doTaskID)
				If ($enPrimary.idNumTask=0)  // assure that 
					$enPrimary.idNumTask:=Task_New($enPrimary; $tableName)
					$enPrimary.save()
				End if 
				$vitaskID:=$enPrimary.idNumTask
			End if 
			$max_i:=ds:C1482.QA.query("customerID = :1"; $vtcustomerID).max("idGroup")+1
			var $enRecQuestion; $enSelQuestion : Object
			$enSelQuestion:=ds:C1482.QAQuestion.query("questionType = :1"; $vtQuestionType).orderBy("question asc, seq asc")
			
			ARRAY TEXT:C222($aQaID; 0)
			var $seq_i : Integer
			$seq_i:=0
			var $qa_c : Collection
			$qa_c:=New collection:C1472
			vResponse:="OK: "+$vtQuestionType+", "+String:C10($enRecQuestion.length)+", QA added to "+$tableName
			If (<>viDebugMode>410)
				ConsoleMessage(vResponse)
			End if 
			$dtCreated:=DateTime_Enter
			For each ($enRecQuestion; $enSelQuestion)
				$seq_i:=$seq_i+1
				$enQA:=ds:C1482.QA.new()
				$enQA.dtCreated:=$dtCreated
				$enQA.groupid:=$max_i
				$enQA.customerID:=$vtcustomerID
				$enQA.tableNum:=$viTableNum
				$enQA.tableName:=$tableName
				$enQA.questionType:=$enRecQuestion.questionType
				$enQA.idNumQAQuestion:=$enRecQuestion.idNum
				$enQA.idQAQuestion:=$enRecQuestion.id
				$enQA.question:=$enRecQuestion.question
				$enQA.seq:=$seq_i
				$enQA.idNumTask:=$vitaskID
				$enQA.save()
				$qa_c.push($enQA.toObject())
			End for each 
		End if 
	End if 
End if 


vResponse:=WcapiTask_QABuild($qa_c)
//QUERY WITH ARRAY([QA]id; $aQaID)
//$voSelection:=API_SelectionToObject("QA")
//vResponse:=API_EntityToText($voSelection)

If (False:C215)
	vResponse:=JSON Stringify:C1217($qa_c)
End if 


