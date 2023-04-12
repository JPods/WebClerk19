//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-12-13T06:00:00Z)
//Depricate_yyy  yyy as soon as practical


//// ----------------------------------------------------
//// User name (OS): Jim Medlen
//// Date and time: 01/04/18, 13:31:20
//// ----------------------------------------------------
//// Method: WC_Parse
//// Description
////   // ### bj ### 20200111_1418
////  // Rework to use <>ovStructure and STR_
//// Parameters
//// ----------------------------------------------------

//C_LONGINT($p; $doNext; $1; $recordNum)
//C_LONGINT($tableNum; $theField; $testFile; $activeSecurityLevel)
//C_LONGINT($pAscii; $tableNum; $theField; $testFile)
//C_TEXT($theValue; $cleanValue; $workingText; $theFormat; pvParseStatus)
//ARRAY TEXT($afieldNames; 0)
//C_POINTER($2)
//C_BOOLEAN($4; $doCapitals; $newRecord)
//C_BOOLEAN($3; $doSave)
//If (Count parameters>3)
//$doCapitals:=$4
//Else 
//$doCapitals:=False
//End if 
//If (Count parameters>2)
//$doSave:=$3
//Else 
//$doSave:=True
//End if 

//$showPermission:=WCapi_GetParameter("EditFields"; "")
//WC_VariablesRead
//C_TEXT($skipFieldProtect)
//$skipFieldProtect:=WCapi_GetParameter("SkipKeyProtect"; "")
////
//$tableNum:=$1
//$ptTable:=Table($tableNum)
//$recordNum:=Record number(Table($tableNum)->)
//$newRecord:=Is new record(Table($tableNum)->)  //must create a new record outside this command
//$workingText:=$2->  //ITK_URL2Text ($2->)
//pvParseStatus:=""


//// get a list of fields allowed to be modified
//ARRAY LONGINT($aFieldCheck; 0)
//$activeSecurityLevel:=MaxValueReturn(vWccSecurity; viSecureLvl)
//QUERY([FC]; [FC]securityLevel=$activeSecurityLevel; *)
//QUERY([FC];  & [FC]tableNum=$tableNum)
//protectedFieldNum:=-1
//If (Records in selection([FC])>0)
//SELECTION TO ARRAY([FC]fieldNumber; $aFieldCheck)

//C_LONGINT($protectedFieldNum)
//$protectedFieldNum:=STR_GetUniqueFieldNum(Table name($tableNum))
//If (($skipFieldProtect#"t@") & ($skipFieldProtect#"1@") & ($skipFieldProtect#"y@"))
//$w:=Find in array($aFieldCheck; $protectedFieldNum)
//If ($w>0)
//DELETE FROM ARRAY($aFieldCheck; $w; 1)
//End if 
//End if 

//// get a list of fields allowed to be modified
//C_LONGINT($cntFields; $incFields)
//$cntFields:=Size of array($aFieldCheck)
//pvParseStatus:=""
//If ($showPermission="true")  // if "EditFields" passed as "true" parameter to show editable field names
//ARRAY TEXT($afieldNames; $cntFields)
//For ($incFields; 1; $cntFields)
//$afieldNames{$incFields}:=Field name($tableNum; $aFieldCheck{$incFields})
//End for 
//SORT ARRAY($afieldNames)  // sort the fields by name
//For ($incFields; 1; $cntFields)
//pvParseStatus:=pvParseStatus+", "+$afieldNames{$incFields}
//End for 
//End if 
//End if 
////check to see fields have not be deleted to zero
//$cntFields:=Size of array($aFieldCheck)
//If ($cntFields=0)
//vResponse:="No fields can be edited for: "+Table name($tableNum)+" at authority: "+String($activeSecurityLevel)
//pvParseStatus:="No fields can be edited for: "+Table name($tableNum)+" at authority: "+String($activeSecurityLevel)
//Else 
//vResponse:="Edit allowed to "+String($cntFields)+" fields."
//If (pvParseStatus="")
//pvParseStatus:=vResponse
//End if 
//End if 


//If (<>viDebugMode>0)
//$incomingPrep:="FC Records at level: "+String($activeSecurityLevel)+" and table: "+Table name($tableNum)+"\r"+"\r"
//C_TEXT(vDebugMessage)
//SET PROCESS VARIABLE(<>webMonitorProcess; vDebugMessage; $incomingPrep)  //send to vDebugDisplay in WebClerkMonitor window
//POST OUTSIDE CALL(<>webMonitorProcess)  // vNewThermometer is set to zero
//SET PROCESS VARIABLE(<>webMonitorProcess; vDebugMessage; pvParseStatus)  //send to vDebugDisplay in WebClerkMonitor window
//POST OUTSIDE CALL(<>webMonitorProcess)  // vNewThermometer is set to zero
//End if 

//CLEAR VARIABLE(atSavedFieldNames)
//CLEAR VARIABLE(atSavedFieldValuesNew)
//CLEAR VARIABLE(atSavedFieldValuesOld)

//C_TEXT($strField)

//If (Size of array($aFieldCheck)>0)  // are there fields allowed to be written to
//WccExecuteTask("Http_Parse_Begin"; $tableNum)
//$fldMax:=Get last field number($tableNum)
//C_LONGINT($cntParameters; $incParameters)

//// Modified by: Bill James (2015-01-02T00:00:00 Reading data from ParameterValue/Name arrays
////  Arrays created in WC_ParseRequestParameter

//$cntParameters:=Size of array(aParameterName)
//For ($incParameters; 1; $cntParameters)
//If (aParameterName{$incParameters}="_jit_@")
//$theFormat:=""
//$theValue:=""

//$workingText:=aParameterName{$incParameters}
//// $workingText:=Replace string($workingText;"_jit_";"")
//// $workingText:=Replace string($workingText;"jj";"")
//TagToComponents($workingText)

//If ((vWebTagTableNum>0) & (viWebTagFieldNum>0))
//C_POINTER($ptField)
//$ptField:=Field(vWebTagTableNum; viWebTagFieldNum)
//$theType:=Type($ptField->)
//$theValue:=aParameterValue{$incParameters}
//$theFormat:=vWebTagFormat
//$fieldname:=Field name($ptField)
////is alpha field
////is longint
////Is Real, Boolean, Date, Time, etc....
//// ### bj ### 20191231_1617
//If (<>viDebugMode>710)
//ConsoleLog("Parse: "+aParameterName{$incParameters}+"\r"+aParameterValue{$incParameters})
//End if 
/////If (Position("Comment";aParameterName{$incParameters})>0)
//// end if


//If ($theValue="nul")  // ### AZM ### 20171016_1434 THIS NEEDS TO APPLY TO ALL THE FOLLOWING CASES
//$theValue:=""
//End if 

//Case of 
//: (($theType=Is alpha field) | ($theType=Is string var))  // Is alpha field = 0 , Is string var = 24
//Case of 
//: (($fieldname="@username@") | ($fieldname="@email@"))
//$ptField->:=$theValue
//: (($theFormat="fone") | ($fieldname="@phone@") | ($fieldname="@fax@"))
//ParsePhone($theValue; $ptField; <>tcLocalArea)
//: (($theFormat="AsIs") | ($theFormat="Text"))
//$ptField->:=$theValue
//Else 
//$ptField->:=Replace string($theValue; Storage.char.crlf; "\r")
//If (($fieldname#"domain@") & ($fieldname#"email@"))  // Modified by: williamjames *11/08/22)
//// zzzqqq jCapitalize1st($ptField)
//End if 
//End case 
//: ($theType=Is text)  //2
//$ptField->:=WC_FieldTagToValue(0; $theValue; $theFormat)  //checkThis,  Seems correct to test insided
//: ($theType=Is date)  //4
//$ptField->:=Date_GoFigure($theValue)
//: ($theType=Is real)  //1
//$ptField->:=Num($theValue)
//: ($theType=Is integer)  //8   // Modified by: williamjames (110823)
//If (($theValue="Y@") | ($theValue="t@"))
//$ptField->:=1
//Else 
//$ptField->:=Num($theValue)
//End if 
//: ($theType=Is longint)  //9)
//DT_ParseImport($ptField; $theValue)
//: ($theType=Is boolean)  //6)
//$ptField->:=(($theValue="1") | ($theValue="on@") | ($theValue="=on@") | ($theValue="T") | ($theValue="True") | ($theValue="Y") | ($theValue="Yes"))
//: ($theType=Is time)  //11)
//$ptField->:=Time($theValue)
//End case 
//// ### bj ### 20200121_0618


//If (<>vbLogStrFieldChanges)
//If (($ptField->#Old($ptField->)) & (($theType#Is text) | ($fieldname="Title")))

//APPEND TO ARRAY(atSavedFieldNames; Field name(vWebTagTableNum; viWebTagFieldNum))
////APPEND TO ARRAY(atSavedFieldValuesNew;String($theValue))
////APPEND TO ARRAY(atSavedFieldValuesOld;String($ptField->))
//APPEND TO ARRAY(atSavedFieldValuesNew; String($ptField->))
//APPEND TO ARRAY(atSavedFieldValuesOld; String(Old($ptField->)))

//End if 
//End if 
//// ### jwm ### 20180104_1324 moved from below execute only when there is a valid field additional parsing of inputs
//WccExecuteTask("Http_Parse_loop"; $tableNum)  // ### jwm ### 20171207_1014

//Else 
//If (pvParseStatus="")
//pvParseStatus:="Not valid: "+$workingText
//Else 
//pvParseStatus:=pvParseStatus+"\r"+$workingText
//End if 
//End if 
//End if 

//End for 

////
//C_BOOLEAN($minOK)
//$minOK:=True

//// Modified by: William James (2014-01-21T00:00:00)
//// save record a
//If ($doSave)
//If ($newRecord)
//$minOK:=WC_ParseMinRequired(Table($tableNum); $2)
//End if 
//WccAcceptTasks($ptTable; $newRecord; $doSave; $2)
//If (False)  //  not needed. saved in WccAcceptTasks  ($doSave)
//If (Modified record($ptTable->))
//SAVE RECORD($ptTable->)
//C_LONGINT(doShowImport)
//End if 
//End if 
//If ((doShowImport>0) & (allowAlerts_boo))
//ADD TO SET(Table($1)->; "Imported")
//End if 
//End if 
////RP_SaveRecordtoSyncRecord (Table($tableNum))
//End if 
//WccExecuteTask("Http_Parse_End"; $tableNum)
