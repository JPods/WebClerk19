//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/18/18, 17:40:40
// ----------------------------------------------------
// Method: AddProfile
// Description
// add new profile record for any table
//
// Parameters: Table Number, DocAlphaID, Name, Value
// Returns: success = Record Number, Duplicate = -1, Missing parameters = -4
// ----------------------------------------------------
// viResult:=AddProfile(viTableNum;vtDocAlphaID;vtName;vtValue{;vtTextValue})
//<declarations>
//==================================
//  Type variables 
//==================================

// "\r";$0;$1;$2;$3;$4;vpField
C_LONGINT:C283(<>VIDEBUGMODE; viFieldNum; viTableNum; viType)
C_TEXT:C284(vtComment; vtDocID; vtMyDate; vtMyName; vtMyText; vtMyTime; vtName; vtValue)

//==================================
//  Initialize variables 
//==================================

<>VIDEBUGMODE:=0
viFieldNum:=0
viTableNum:=0
viType:=0
vtComment:=""
vtDocID:=""
vtMyDate:=""
vtMyName:=""
vtMyText:=""
vtMyTime:=""
vtName:=""
vtValue:=""
//</declarations>

C_LONGINT:C283(viTableNum; viFieldNum)
C_TEXT:C284(vtDocID; vtName; vtValue; vtTextValue)
C_POINTER:C301(vpField)

If (Count parameters:C259>=4)
	
	viTableNum:=$1
	vtDocID:=$2
	vtName:=$3
	vtValue:=$4
	$0:=-1
	
	If (Count parameters:C259>=5)
		vtTextValue:=$5
	Else 
		vtTextValue:=""
	End if 
	
	viFieldNum:=STR_GetUniqueFieldNum(Table name:C256(viTableNum))
	vpField:=Field:C253(viTableNum; viFieldNum)
	viType:=Type:C295(vpField->)
	
	QUERY:C277([Profile:59]; [Profile:59]docAlphaID:3=vtDocID; *)
	QUERY:C277([Profile:59];  & ; [Profile:59]tableNum:1=viTableNum; *)
	QUERY:C277([Profile:59];  & ; [Profile:59]name:4=vtName; *)
	QUERY:C277([Profile:59];  & ; [Profile:59]value:5=vtValue; *)
	QUERY:C277([Profile:59])
	
	If (Records in selection:C76([Profile:59])=0)
		
		If (<>viDebugMode>410)
			ConsoleMessage("Setting Profile Name: "+vtName+" Value: "+vtValue)
		End if 
		
		vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
		vtMyDate:=String:C10(Current date:C33; 4)
		
		If ((vtName="") & (vtValue=""))
			vtMyText:="New Profile for "+Table name:C256(vpField)+" "+Field name:C257(vpField)+" "+vtDocID+" created by "
		Else 
			vtMyText:="Profile: "+vtName+" = "+vtValue+" for "+Table name:C256(vpField)+" "+Field name:C257(vpField)+" "+vtDocID+" created by "
		End if 
		
		vtMyName:=(Current user:C182)
		vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyText+vtMyName+"\r"
		
		// Create Profile Record
		CREATE RECORD:C68([Profile:59])
		[Profile:59]tableNum:1:=viTableNum
		If (viType=Is longint:K8:6)
			[Profile:59]docNumID:2:=Num:C11(vtDocID)  // Secondary field
		End if 
		[Profile:59]docAlphaID:3:=vtDocID  // Primary Field
		[Profile:59]name:4:=vtName
		[Profile:59]value:5:=vtValue
		[Profile:59]seq:11:=1
		[Profile:59]textValue:6:=vtComment
		If (vtTextValue#"")  // append additional text if passed in
			[Profile:59]textValue:6:=[Profile:59]textValue:6+vtTextValue
		End if 
		
		SAVE RECORD:C53([Profile:59])
		$0:=Record number:C243([Profile:59])
		UNLOAD RECORD:C212([Profile:59])
	End if 
Else 
	$0:=-4  // Error Requires 4 parameters optional 5th parameter
End if 
