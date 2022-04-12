//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/15/21, 20:58:53
// ----------------------------------------------------
// Method: WCapi_QASave
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($viQuestionID; $vitaskID; $viAnswerID; $viUniqueID)
C_TEXT:C284($tableName; $vtPhotoTag; $vtUUIDKey)
C_POINTER:C301($ptTable)
C_TEXT:C284($textBase64; $vtAnswer; $vtcustomerID)
C_LONGINT:C283($viMilliSeconds; $tableNum)
$viMilliSeconds:=Milliseconds:C459
vResponse:=""  // clear risk of cookies
If (voState.tableName=Null:C1517)
	$tableName:=voState.tableName
Else 
	$tableName:="Customer"
End if 
$vtUUIDKey:=WCapi_GetParameter("id")
If ($vtUUIDKey="")
	vResponse:="Error: Invalid id, QA must already exist"
Else 
	C_OBJECT:C1216($voSelQA; $voRecord)
	$voRecord:=ds:C1482.QA.query("id = :1 "; $vtUUIDKey).first()
	If ($voRecord=Null:C1517)
		vResponse:="Error: No QACustomers for id "+$vtUUIDKey
	End if 
End if 

$obPayload:=voState.request.parameters
If (vResponse="Err@")
	$obPayload.error:=vResponse
Else 
	$voRecord.answer:=$obPayload.answer
	$obPayload.nameTag:=""  // completed below
	If ($obPayload.idQAAnswer#Null:C1517)
		$voRecord.idQAAnswer:=$obPayload.idQAAnswer
	End if 
	$voRecord.dateOfAnswer:=Current date:C33
	$voRecord.answeredBy:=obRemoteUser.userName
	
	var $recAns_o : Object
	If ($obPayload.idQAAnswer#Null:C1517)
		$recAns_o:=ds:C1482.QAAnswer.query("id = :1"; $obPayload.idQAAnswer).first()
		If ($recAns_o#Null:C1517)
			$voRecord.url:=$recAns_o.url
		Else   // various efforts to connect the answer url. Keep the id incase we want to coordinate the answers from many diffent sweeps
			// ai approach to collaboration
			If ($obPayload.idNumQAAnswer#Null:C1517)
				$recAns_o:=ds:C1482.QAAnswer.query("idQAQuestion = :1 & idNum = :2"; $voRecord.idQAQuestion; $obPayload.idNumQAAnswer).first()
				If ($recAns_o#Null:C1517)
					$voRecord.url:=$recAns_o.url
				Else 
					$recAns_o:=ds:C1482.QAAnswer.query("idQAQuestion = :1 & answer = :2"; $voRecord.idQAQuestion; Substring:C12($obPayload.answer; 1; 3)+"@").first()
					If ($recAns_o#Null:C1517)
						$voRecord.url:=$recAns_o.url
						$obPayload.nameTag:=$recAns_o.photoTag
					End if 
				End if 
			End if 
		End if 
	End if 
	
	
	C_TEXT:C284($pathFolder; $customerTag_t; $idNumTaskTag_t)
	If ($obPayload.photo#Null:C1517)  // if a photo was added
		If (Length:C16($obPayload.photo)>6)  // protect against "null" being sent as a string
			$customerTag_t:="customer"+Folder separator:K24:12+$voRecord.customerID+Folder separator:K24:12
			If ($voRecord.idNumTask>9)
				$customerTag_t:=$customerTag_t+"numTask"+String:C10($voRecord.idNumTask)+Folder separator:K24:12
			End if 
			
			//Alert(Storage.paths.serverComEx)
			If (Test path name:C476(Storage:C1525.paths.serverComEx)=0)
				$obPayload.path:=Storage:C1525.paths.serverComEx+$customerTag_t
			Else 
				$obPayload.path:=Storage:C1525.paths.localComEx+$customerTag_t
			End if 
			
			If ($obPayload.nameTag="")
				$obPayload.nameTag:="QA-"+Txt_CleanForURL(Substring:C12($voRecord.question; 1; 8)+"-"+Substring:C12($voRecord.answer; 1; 8))+\
					"-"+Date_StrYYYY MM DDTHH MM SS
			Else 
				$obPayload.nameTag:=$obPayload.nameTag+"-"+Date_StrYYYY MM DDTHH MM SS
			End if 
			var $pathsFinal_o : Object
			$pathsFinal_o:=imgBase64($obPayload)
			
			
			If ($pathsFinal_o.imagePath#Null:C1517)
				$voRecord.imagePath:=Convert path system to POSIX:C1106($pathsFinal_o.imagePath)
			End if 
			If ($pathsFinal_o.imagePathTn#Null:C1517)
				$voRecord.imagePathTn:=Convert path system to POSIX:C1106($pathsFinal_o.imagePathTn)
			End if 
			
			If (<>VIDEBUGMODE>210)
				ConsoleMessage("Storage.paths.serverComEx: "+Storage:C1525.paths.serverComEx)
				ConsoleMessage("Storage.paths.localComEx: "+Storage:C1525.paths.localComEx)
				ConsoleMessage("$obPayload.path: "+$obPayload.path)
				ConsoleMessage("$voRecord.imagePath: "+$voRecord.imagePath)
			End if 
			
		End if 
	End if 
	
	$voRecord.save()
	C_OBJECT:C1216($voOutput)
	$voOutput:=New object:C1471
	$voOutput:=$voRecord.toObject()
	$voOutput.isLocked:=False:C215
	
	If ($voOutput.imagePath#"")  // convert to web path
		$vtURL:="http://"+Storage:C1525.default.domain
		$wCust:=Position:C15("/CommerceExpert/"; $vtDocPath)
		If ($wCust>0)  // 
			$voOutput.imagePath:=$vtURL+Substring:C12($vtDocPath; $wCust)
			$voOutput.imagePathTN:=$vtURL+Substring:C12($vtDocPathTN; $wCust)
		Else 
			$voOutput.imagePath:=$vtDocPath
			$voOutput.imagePathTN:=$vtDocPathTN
		End if 
	End if 
	
	vResponse:=JSON Stringify:C1217($voOutput)
	
End if 