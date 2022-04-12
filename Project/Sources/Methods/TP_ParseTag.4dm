//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/12/17, 08:37:24
// ----------------------------------------------------
// Method: TP_ParseTag
//
// Description:
//
// This method will parse one jit tag and return the results.
//
// Parameters:
//
// $1 is the tag that needs to be parsed.
// 
// Return:
//
// $0 is an object containing the parsed tag.
// ----------------------------------------------------

// ******************************************* //
// **** TYPE AND INITIALIZE ALL VARIABLES **** //
// ******************************************* //

// RETURN VARIABLE
C_OBJECT:C1216($0)

// PARAMETER 1 IS THE UNPARSED TAG TEXT
C_TEXT:C284($1; $vtTextPreceeding)
$vtTextPreceeding:=$1

// PARAMETER 1 IS THE UNPARSED TAG TEXT
C_TEXT:C284($2; $vtTextTag)
$vtTextTag:=$2

// THESE ARE THE THREE VARIABLES WHICH WILL HOLD THE
// PIECES OF THE PARSED TAG. THEY WILL BE RETURNED
// IN AN OBJECT.
C_TEXT:C284($vtTableNum; $vtFieldNum; $vtOutputFormat)
$vtTableNum:=""
$vtFieldNum:=""
$vtOutputFormat:=""

C_BOOLEAN:C305($vbValidTableNum)
$vbValidTableNum:=False:C215

C_BOOLEAN:C305($vbValidFieldNum)
$vbValidFieldNum:=False:C215

// ************************************************************** //
// ****** PARSE THE TAG, BASED ON TEXT BETWEEN UNDERSCORES ****** //
// ************************************************************** //

// CHECK TO MAKE SURE THAT THE JIT PORTION OF THE TAG HAS ALREADY BEEN
// STRIPPED OFF, AND IS IT HASN'T, STRIP IT OFF

If ($vtTextTag="_jit_@")
	C_LONGINT:C283($viLength)
	$vtTextTag:=Substring:C12($vtTextTag; 6)
	$viLength:=Length:C16($vtTextTag)
	If (Substring:C12($vtTextTag; $viLength-2)="jj")
		$vtTextTag:=Substring:C12($vtTextTag; 1; $viLength-2)
	End if 
End if 

// PARSE THE TAG

If ($vtTextTag#"")
	
	// SNIP OFF THE TABLE NUM PORTION, WHICH IS EVERYTHNG UP UNTIL THE
	// FIRST UNDERSCORE
	
	$viPosMid:=Position:C15(<>midTag; $vtTextTag)
	$vtTableNum:=Substring:C12($vtTextTag; 1; $viPosMid-1)
	$vtTextTag:=Substring:C12($vtTextTag; $viPosMid+1)
	
	// SEPARATE THE FIELD NUM PORTION OF THE TAG FROM THE POSSIBLE OUTPUT
	// FORMAT PORTION. IF THIS IS A SCRIPT OR OBJECT, WE ARE GOING TO ASSUME
	// THAT THERE IS NO OUTPUT FORMAT SPECIFIED, BECAUSE THERE MIGHT BE UNDERSCORES
	// IN THE SCRIPT AND WE WANT TO IGNORE THEM.
	
	If (($vtTableNum="-6") | ($vtTableNum="Script") | ($vtTableNum="-3") | ($vtTableNum="Object"))
		$viPosMid:=-1
	Else 
		$viPosMid:=Position:C15(<>midTag; $vtTextTag)
	End if 
	If ($viPosMid>0)
		$vtFieldNum:=Substring:C12($vtTextTag; 1; $viPosMid-1)
		$vtOutputFormat:=Substring:C12($vtTextTag; $viPosMid+1)
	Else 
		$vtFieldNum:=$vtTextTag
	End if 
	
	// ************************************************************** //
	// ******************* VALIDATE THE TABLE NUM ******************* //
	// ************************************************************** //
	
	// USERS CAN NOW USE WORDS INSTEAD OF NUMBERS ON TEMPLATES. THIS HELPS
	// BY MAKING TEMPLATES EASIER TO READ AND UNDERSTAND. THE PROCESSING
	// METHODS ARE SET UP TO HANDLE NUMBERS THOUGH, SO WE NEED TO CONVERT
	// WORDS TO NUMBERS HERE BEFORE WE DO ANYTHING ELSE.
	
	C_LONGINT:C283($viIndex)
	
	$viIndex:=Find in array:C230(<>aTableNames; $vtTableNum)
	If ($viIndex>0)
		$vtTableNum:=String:C10(<>aTableNums{$viIndex})
	Else 
		Case of 
			: ($vtTableNum="begin")
				$vtTableNum:="begin"
			: ($vtTableNum="script")
				$vtTableNum:="-6"
			: ($vtTableNum="object")
				$vtTableNum:="-3"
			: ($vtTableNum="array")
				$vtTableNum:="-2"
			: ($vtTableNum="variable")
				$vtTableNum:="0"
		End case 
	End if 
	
	// NEXT, WE NEED TO CHECK A COUPLE SPECIFIC CASES WHERE WE WANT TO OVERWRITE
	// THE OUTPUT FORMAT. THIS IS TO PREVENT ISSUES LATER.
	
	Case of 
		: ($vtTableNum="-6")
			$vtOutputFormat:="txt"
		: ($vtTableNum="-3")
			$vtOutputFormat:="txt"
		Else 
	End case 
	
	// FINALLY, WE NEED TO MAKE SURE THAT THESE ARE VALID TABLE NUMBERS. BECAUSE THE NUM() FUNCTION
	// WILL RETURN 0 FOR RANDOM TEXT STRINGS, WE CAN'T CHECK $viTableNum for 0, WE HAVE TO USE THE
	// STRING VERSION OF "0". SO FOR CONSISTENCY, WE'LL CHECK THE STRING VERSIONS. ADDITIONALLY, IT
	// MAY BE VALID IF IT MATCHES THE LIST OF VALID TABLE NUMS.
	
	C_LONGINT:C283($viTableNum)
	
	$viTableNum:=Num:C11($vtTableNum)
	$viIndex:=Find in array:C230(<>aTableNums; $viTableNum)
	
	If (($vtTableNum="begin") | ($vtTableNum="if") | ($vtTableNum="-6") | ($vtTableNum="-3") | ($vtTableNum="-2") | ($vtTableNum="0") | ($viIndex>0))
		$vbValidTableNum:=True:C214
	End if 
	
	// ************************************************************** //
	// ******************* VALIDATE THE FIELD NUM ******************* //
	// ************************************************************** //
	
	// IF WE HAVE A REAL, VALID TABLE NUMBER
	
	If ($viIndex>0)
		
		// GRAB THE CACHED LIST OF VALID FIELD NAMES FOR THE SELECTED TABLE,
		// AND USE THAT TO CONVERT ANY OF THE VALID NON-NUMBER TEXT STRINGS
		// TO THEIR COORESPONDING NUMBER
		
		$vpValidFields:=Get pointer:C304("<>a"+Table name:C256($viTableNum)+"_FL")
		$viIndex:=Find in array:C230($vpValidFields->; $vtFieldNum)
		If ($viIndex>0)
			$vtFieldNum:=String:C10($viIndex)
		Else 
			Case of 
				: ($vtFieldNum="records")
					$vtFieldNum:="0"
				: ($vtFieldNum="tablename")
					$vtFieldNum:="-1"
				: ($vtFieldNum="recordnum")
					$vtFieldNum:="-2"
			End case 
		End if 
		
		// NOW THAT WE HAVE A NUMBER, WE NEED TO CHECK TO SEE IF IT IS VALID. IT
		// IS VALID IF IT IS A CERTAIN STRING, OR IF IT IS A VALID FIELD NUMBER
		
		C_LONGINT:C283($viFieldNum)
		$viFieldNum:=Num:C11($vtFieldNum)
		
		C_TEXT:C284($vtFieldName)
		$vtFieldName:=""
		
		If ($viFieldNum>0)
			$vtFieldName:=Field name:C257($viTableNum; $viFieldNum)
		End if 
		
		$viIndex:=Find in array:C230($vpValidFields->; $vtFieldName)
		
		If (($vtFieldNum="0") | ($vtFieldNum="-1") | ($vtFieldNum="-2") | ($viIndex>0))
			
			$vbValidFieldNum:=True:C214
			
		End if 
		
	Else 
		
		$vbValidFieldNum:=True:C214
		
	End if 
	
End if 

If (($vbValidTableNum=True:C214) & ($vbValidFieldNum=True:C214))
	
	OB SET:C1220($0; "TextPreceeding"; $vtTextPreceeding)
	OB SET:C1220($0; "TableNum"; $vtTableNum)
	OB SET:C1220($0; "FieldNum"; $vtFieldNum)
	OB SET:C1220($0; "OutputFormat"; $vtOutputFormat)
	
Else 
	
	OB SET:C1220($0; "TextPreceeding"; $vtTextPreceeding)
	OB SET:C1220($0; "TableNum"; "")
	OB SET:C1220($0; "FieldNum"; "")
	OB SET:C1220($0; "OutputFormat"; "")
	
End if 
