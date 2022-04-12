//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 01/04/18, 15:13:17
// ----------------------------------------------------
// Method: WC_AddChangeLog
// Description
// 
//
// Parameters
// ----------------------------------------------------

// SET UP VARIABLES

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_LONGINT:C283($1; $viTableNum)
$viTableNum:=$1

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_POINTER:C301($2; $vpChangelogField)
$vpChangelogField:=$2

// PARAMETER 2 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_BOOLEAN:C305($3; $vbNewRec)
$vbNewRec:=$3

// $vpTable IS A POINTER TO THE CURRENT TABLE

C_POINTER:C301($vpTable)
$vpTable:=Table:C252($viTableNum)

// $tableName IS THE NAME OF THE CURRENT TABLE
C_TEXT:C284($tableName)
$tableName:=Table name:C256($viTableNum)

C_LONGINT:C283($viIncrementor; $viCount)
$viIncrementor:=0
$viCount:=0

// $vtNewLine IS THE BUFFER THAT HOLDS THE NEW CHANGELOG LINE
C_TEXT:C284($vtNewLine)
$vtNewLine:=""

// $vtDateTimeStamp IS THE DATE/TIME STAMP WHICH WILL BE PREPENDED
// TO EACH NEW CHANGELOG LINE
C_TEXT:C284($vtDateTimeStamp)
$vtDateTimeStamp:=""

// $vtUsername AND vtUserFullName HOLD THE ACTUAL USERNAME AND THE
// REAL FULL NAME OF THE CURRENT USER.
C_TEXT:C284(vtUsername)
vtUsername:=""

// IF THE CURRENT USER IS NOT WEBCLERK, LOAD THE LINKED [RemoteUser] ACCOUNT

// FILL OUT THE USERNAME

// ### bj ### 20191231_1719
// get the web user first then the current user if no authorized web user is identified
// vtUsername:=[RemoteUser]Name
If (vWccremoteUserID#"")
	vtUsername:=vWccremoteUserID+": "+[EventLog:75]id:54
Else 
	If (Current user:C182#"WebClerk")
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]customerID:10=Current user:C182)
	End if 
	
	C_TEXT:C284($vtAuthorTableName)
	$vtAuthorTableName:=Table name:C256([RemoteUser:57]tableNum:9)
	
	C_TEXT:C284($vtAuthorUniqueID)
	$vtAuthorUniqueID:=""
	
	If ($vtAuthorTableName="Employees")
		QUERY:C277([Employee:19]; [Employee:19]nameID:1=[RemoteUser:57]customerID:10)
		$vtAuthorUniqueID:=String:C10([Employee:19]idNum:71)
	Else 
		$vtAuthorUniqueID:=[RemoteUser:57]customerID:10
	End if 
	
	vtUsername:=[RemoteUser:57]userName:2+": "+String:C10([EventLog:75]idNum:5)
	
End if 

C_TEXT:C284($vtUniqueID)
C_POINTER:C301($vpUniqueIDField)
$vpUniqueIDField:=Field:C253($viTableNum; STR_GetUniqueFieldNum(Table name:C256($viTableNum)))
$vtUniqueID:=String:C10($vpUniqueIDField->)


// FILL OUT DATE TIME STAMP

$vtDateTimeStamp:=String:C10(Current date:C33; Internal date short:K1:7)+": "+String:C10(Current time:C178; HH MM AM PM:K7:5)+";"




If ($vbNewRec=True:C214)
	
	//$vtNewLine:=$vtDateTimeStamp+" Record Created - "+vtUserFullName
	$vtNewLine:=$vtDateTimeStamp+" Record Created - "+vtUserName  // ### AZM ### 20180213 THE VARIABLE NAME WAS SIMPLIFIED, BUT DIDN'T GET CHANGED HERE
	
	// ### bj ### 20200409_0046 need to keep data if there is any
	If ($vpChangelogField->="")
		$vpChangelogField->:=$vtNewLine
	Else 
		$vpChangelogField->:=$vtNewLine+"\r"+$vpChangelogField->
	End if 
	
Else 
	
	// LOOP THROUGH ALL CHANGES AND PREPEND TO 
	
	//<>vbLogStrFieldChanges in WC_Parse determines if changes are to be logged
	$viCount:=Size of array:C274(atSavedFieldNames)
	
	For ($viIncrementor; 1; $viCount)
		
		$vtNewLine:=$vtDateTimeStamp+" \""+atSavedFieldNames{$viIncrementor}+"\" changed from \""+atSavedFieldValuesOld{$viIncrementor}+"\" to \""+atSavedFieldValuesNew{$viIncrementor}+"\" - "+vtUsername
		
		$vpChangelogField->:=$vtNewLine+Storage:C1525.char.crlf+$vpChangelogField->
		
		LogRecordEdit($tableName; $vtUniqueID; $vtAuthorTableName; $vtAuthorUniqueID; atSavedFieldNames{$viIncrementor}; atSavedFieldValuesOld{$viIncrementor}; atSavedFieldValuesNew{$viIncrementor})
		
	End for 
	
End if 

// UNLOAD THE [RemoteUser] RECORD IF IT WAS LOADED

If (Current user:C182#"WebClerk")
	UNLOAD RECORD:C212([RemoteUser:57])
End if 


// SAVE RECORD

SAVE RECORD:C53($vpTable->)
