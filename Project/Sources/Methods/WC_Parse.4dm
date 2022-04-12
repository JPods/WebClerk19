//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/04/18, 13:31:20
// ----------------------------------------------------
// Method: WC_Parse
// Description
//   // ### bj ### 20200111_1418
//  // Rework to use <>ovStructure and STR_
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($p; $doNext; $1; $recordNum)
C_LONGINT:C283($tableNum; $theField; $testFile; $activeSecurityLevel)
C_LONGINT:C283($pAscii; $tableNum; $theField; $testFile)
C_TEXT:C284($theValue; $cleanValue; $workingText; $theFormat; pvParseStatus)
ARRAY TEXT:C222($afieldNames; 0)
C_POINTER:C301($2)
C_BOOLEAN:C305($4; $doCapitals; $newRecord)
C_BOOLEAN:C305($3; $doSave)
If (Count parameters:C259>3)
	$doCapitals:=$4
Else 
	$doCapitals:=False:C215
End if 
If (Count parameters:C259>2)
	$doSave:=$3
Else 
	$doSave:=True:C214
End if 

$showPermission:=WCapi_GetParameter("EditFields"; "")
WC_VariablesRead
C_TEXT:C284($skipFieldProtect)
$skipFieldProtect:=WCapi_GetParameter("SkipKeyProtect"; "")
//
$tableNum:=$1
$ptTable:=Table:C252($tableNum)
$recordNum:=Record number:C243(Table:C252($tableNum)->)
$newRecord:=Is new record:C668(Table:C252($tableNum)->)  //must create a new record outside this command
$workingText:=$2->  //ITK_URL2Text ($2->)
pvParseStatus:=""


// get a list of fields allowed to be modified
ARRAY LONGINT:C221($aFieldCheck; 0)
$activeSecurityLevel:=MaxValueReturn(vWccSecurity; viSecureLvl)
QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]securityLevel:3=$activeSecurityLevel; *)
QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]tableNum:1=$tableNum)
protectedFieldNum:=-1
If (Records in selection:C76([FieldCharacteristic:94])>0)
	SELECTION TO ARRAY:C260([FieldCharacteristic:94]fieldNumber:5; $aFieldCheck)
	
	C_LONGINT:C283($protectedFieldNum)
	$protectedFieldNum:=STR_GetUniqueFieldNum(Table name:C256($tableNum))
	If (($skipFieldProtect#"t@") & ($skipFieldProtect#"1@") & ($skipFieldProtect#"y@"))
		$w:=Find in array:C230($aFieldCheck; $protectedFieldNum)
		If ($w>0)
			DELETE FROM ARRAY:C228($aFieldCheck; $w; 1)
		End if 
	End if 
	
	// get a list of fields allowed to be modified
	C_LONGINT:C283($cntFields; $incFields)
	$cntFields:=Size of array:C274($aFieldCheck)
	pvParseStatus:=""
	If ($showPermission="true")  // if "EditFields" passed as "true" parameter to show editable field names
		ARRAY TEXT:C222($afieldNames; $cntFields)
		For ($incFields; 1; $cntFields)
			$afieldNames{$incFields}:=Field name:C257($tableNum; $aFieldCheck{$incFields})
		End for 
		SORT ARRAY:C229($afieldNames)  // sort the fields by name
		For ($incFields; 1; $cntFields)
			pvParseStatus:=pvParseStatus+", "+$afieldNames{$incFields}
		End for 
	End if 
End if 
//check to see fields have not be deleted to zero
$cntFields:=Size of array:C274($aFieldCheck)
If ($cntFields=0)
	vResponse:="No fields can be edited for: "+Table name:C256($tableNum)+" at authority: "+String:C10($activeSecurityLevel)
	pvParseStatus:="No fields can be edited for: "+Table name:C256($tableNum)+" at authority: "+String:C10($activeSecurityLevel)
Else 
	vResponse:="Edit allowed to "+String:C10($cntFields)+" fields."
	If (pvParseStatus="")
		pvParseStatus:=vResponse
	End if 
End if 


If (<>viDebugMode>0)
	$incomingPrep:="FieldCharacteristics Records at level: "+String:C10($activeSecurityLevel)+" and table: "+Table name:C256($tableNum)+"\r"+"\r"
	C_TEXT:C284(vDebugMessage)
	SET PROCESS VARIABLE:C370(<>webMonitorProcess; vDebugMessage; $incomingPrep)  //send to vDebugDisplay in WebClerkMonitor window
	POST OUTSIDE CALL:C329(<>webMonitorProcess)  // vNewThermometer is set to zero
	SET PROCESS VARIABLE:C370(<>webMonitorProcess; vDebugMessage; pvParseStatus)  //send to vDebugDisplay in WebClerkMonitor window
	POST OUTSIDE CALL:C329(<>webMonitorProcess)  // vNewThermometer is set to zero
End if 

CLEAR VARIABLE:C89(atSavedFieldNames)
CLEAR VARIABLE:C89(atSavedFieldValuesNew)
CLEAR VARIABLE:C89(atSavedFieldValuesOld)

C_TEXT:C284($strField)

If (Size of array:C274($aFieldCheck)>0)  // are there fields allowed to be written to
	WccExecuteTask("Http_Parse_Begin"; $tableNum)
	$fldMax:=Get last field number:C255($tableNum)
	C_LONGINT:C283($cntParameters; $incParameters)
	
	// Modified by: Bill James (2015-01-02T00:00:00 Reading data from ParameterValue/Name arrays
	//  Arrays created in WC_ParseRequestParameter
	
	$cntParameters:=Size of array:C274(aParameterName)
	For ($incParameters; 1; $cntParameters)
		If (aParameterName{$incParameters}="_jit_@")
			$theFormat:=""
			$theValue:=""
			
			$workingText:=aParameterName{$incParameters}
			// $workingText:=Replace string($workingText;"_jit_";"")
			// $workingText:=Replace string($workingText;"jj";"")
			TagToComponents($workingText)
			
			If ((vWebTagTableNum>0) & (viWebTagFieldNum>0))
				C_POINTER:C301($ptField)
				$ptField:=Field:C253(vWebTagTableNum; viWebTagFieldNum)
				$theType:=Type:C295($ptField->)
				$theValue:=aParameterValue{$incParameters}
				$theFormat:=vWebTagFormat
				$fieldname:=Field name:C257($ptField)
				//is alpha field
				//is longint
				//Is Real, Boolean, Date, Time, etc....
				// ### bj ### 20191231_1617
				If (<>viDebugMode>710)
					ConsoleMessage("Parse: "+aParameterName{$incParameters}+"\r"+aParameterValue{$incParameters})
				End if 
				///If (Position("Comment";aParameterName{$incParameters})>0)
				// end if
				
				
				If ($theValue="nul")  // ### AZM ### 20171016_1434 THIS NEEDS TO APPLY TO ALL THE FOLLOWING CASES
					$theValue:=""
				End if 
				
				Case of 
					: (($theType=Is alpha field:K8:1) | ($theType=Is string var:K8:2))  // Is alpha field = 0 , Is string var = 24
						Case of 
							: (($fieldname="@username@") | ($fieldname="@email@"))
								$ptField->:=$theValue
							: (($theFormat="fone") | ($fieldname="@phone@") | ($fieldname="@fax@"))
								ParsePhone($theValue; $ptField; <>tcLocalArea)
							: (($theFormat="AsIs") | ($theFormat="Text"))
								$ptField->:=$theValue
							Else 
								$ptField->:=Replace string:C233($theValue; Storage:C1525.char.crlf; "\r")
								If (($fieldname#"domain@") & ($fieldname#"email@"))  // Modified by: williamjames *11/08/22)
									// zzzqqq jCapitalize1st($ptField)
								End if 
						End case 
					: ($theType=Is text:K8:3)  //2
						$ptField->:=WC_FieldTagToValue(0; $theValue; $theFormat)  //checkThis,  Seems correct to test insided
					: ($theType=Is date:K8:7)  //4
						$ptField->:=Date_GoFigure($theValue)
					: ($theType=Is real:K8:4)  //1
						$ptField->:=Num:C11($theValue)
					: ($theType=Is integer:K8:5)  //8   // Modified by: williamjames (110823)
						If (($theValue="Y@") | ($theValue="t@"))
							$ptField->:=1
						Else 
							$ptField->:=Num:C11($theValue)
						End if 
					: ($theType=Is longint:K8:6)  //9)
						DT_ParseImport($ptField; $theValue)
					: ($theType=Is boolean:K8:9)  //6)
						$ptField->:=(($theValue="1") | ($theValue="on@") | ($theValue="=on@") | ($theValue="T") | ($theValue="True") | ($theValue="Y") | ($theValue="Yes"))
					: ($theType=Is time:K8:8)  //11)
						$ptField->:=Time:C179($theValue)
				End case 
				// ### bj ### 20200121_0618
				
				
				If (<>vbLogStrFieldChanges)
					If (($ptField->#Old:C35($ptField->)) & (($theType#Is text:K8:3) | ($fieldname="Title")))
						
						APPEND TO ARRAY:C911(atSavedFieldNames; Field name:C257(vWebTagTableNum; viWebTagFieldNum))
						//APPEND TO ARRAY(atSavedFieldValuesNew;String($theValue))
						//APPEND TO ARRAY(atSavedFieldValuesOld;String($ptField->))
						APPEND TO ARRAY:C911(atSavedFieldValuesNew; String:C10($ptField->))
						APPEND TO ARRAY:C911(atSavedFieldValuesOld; String:C10(Old:C35($ptField->)))
						
					End if 
				End if 
				// ### jwm ### 20180104_1324 moved from below execute only when there is a valid field additional parsing of inputs
				WccExecuteTask("Http_Parse_loop"; $tableNum)  // ### jwm ### 20171207_1014
				
			Else 
				If (pvParseStatus="")
					pvParseStatus:="Not valid: "+$workingText
				Else 
					pvParseStatus:=pvParseStatus+"\r"+$workingText
				End if 
			End if 
		End if 
		
	End for 
	
	//
	C_BOOLEAN:C305($minOK)
	$minOK:=True:C214
	
	// Modified by: William James (2014-01-21T00:00:00)
	// save record a
	If ($doSave)
		If ($newRecord)
			$minOK:=WC_ParseMinRequired(Table:C252($tableNum); $2)
		End if 
		WccAcceptTasks($ptTable; $newRecord; $doSave; $2)
		If (False:C215)  //  not needed. saved in WccAcceptTasks  ($doSave)
			If (Modified record:C314($ptTable->))
				SAVE RECORD:C53($ptTable->)
				C_LONGINT:C283(doShowImport)
			End if 
		End if 
		If ((doShowImport>0) & (allowAlerts_boo))
			ADD TO SET:C119(Table:C252($1)->; "Imported")
		End if 
	End if 
	//RP_SaveRecordtoSyncRecord (Table($tableNum))
End if 
WccExecuteTask("Http_Parse_End"; $tableNum)
