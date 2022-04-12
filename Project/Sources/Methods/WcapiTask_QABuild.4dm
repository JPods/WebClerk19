//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/25/21, 19:12:21
// ----------------------------------------------------
// Method: WcapiTask_QABuild
// Description
// 
// Parameters
// ----------------------------------------------------
var $0 : Text
var $1 : Variant
C_COLLECTION:C1488($vcQuestions)

C_OBJECT:C1216($voSelAnswer)

If (Value type:C1509($1)=Is collection:K8:32)
	$vcQuestions:=$1
Else 
	$entQA:=$1
	
	$vtRole:="Sales"
	$vtQuestionFieldList:=API_GetFieldList("QACustomer"; $vtRole; "list")
	$vtAnswerFieldList:=API_GetFieldList("QAAnswer"; $vtRole; "list")
	// keep it simple to start
	$vtQuestionFieldList:=""
	$vtAnswerFieldList:=""
	$vcQuestions:=$entQA.toCollection($vtQuestionFieldList)
End if 
C_COLLECTION:C1488($anwers_c)
var $seqA_i; $seqQ_i : Integer
var $answer_o : Object
$seqQ_i:=0
For each ($voEachQ; $vcQuestions)
	If ($voEachQ#Null:C1517)
		$seqQ_i:=$seqQ_i+1
		$voEachQ.seq:=$seqQ_i
		// $voEachQ.questionKey:=$voEachQ.idQAQuestion  // make capatible with Vue, fix Vue
		
		// set image url
		C_LONGINT:C283($wCust)
		C_TEXT:C284($vtURL; $path_t; $pathTN_t)
		//$vtURL:="http://"+Storage.default.domain
		
		$wCust:=Position:C15("CommerceExpert/"; $voEachQ.imagePath)
		If ($wCust>0)  // 
			$voEachQ.imagePath:=Substring:C12($voEachQ.imagePath; $wCust)
			$voEachQ.imagePath:=Replace string:C233($voEachQ.imagePath; ":"; "/")
			$voEachQ.imagePath:=Replace string:C233($voEachQ.imagePath; "\\"; "/")
			If ($voEachQ.imagePathTN=Null:C1517)
				$voEachQ.imagePathTN:=$voEachQ.imagePath
			Else 
				$voEachQ.imagePathTN:=Substring:C12($voEachQ.imagePathTN; $wCust)  // assumes the same initial path
				$voEachQ.imagePathTN:=Replace string:C233($voEachQ.imagePathTN; ":"; "/")
				$voEachQ.imagePathTN:=Replace string:C233($voEachQ.imagePathTN; "\\"; "/")
			End if 
		End if 
		
		// set up answers
		$voSelAnswer:=ds:C1482.QAAnswer.query("idNumQAQuestion = :1 "; $voEachQ.idNumQAQuestion).orderBy("seq asc")
		$anwers_c:=$voSelAnswer.toCollection()  //   $vtAnswerFieldList
		$anwers_c.unshift(New object:C1471("answer"; "Select/type choice"; "id"; "zzzFiller"; "idNum"; 1; "idNumQAQuestion"; 1; "idQAQuestion"; "zzzFiller"; "seq"; -9999999))
		$seqA_i:=1
		// assure valid seq and first line not selectable.
		For each ($answer_o; $anwers_c)
			$answer_o.seq:=$seq_i
			$seq_i:=$seq_i+1
		End for each 
		$voEachQ.choices:=$anwers_c
	End if 
End for each 
//If (voState.errors.length>0)
//$vcQuestions.push(New object("errors"; voState.errors))
//End if 
$0:=JSON Stringify:C1217($vcQuestions)
voState.result:=$tableName+" records in selection: "+String:C10($entQA.length)



