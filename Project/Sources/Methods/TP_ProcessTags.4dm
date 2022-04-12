//%attributes = {}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/26/17, 12:16:41
// ----------------------------------------------------
// Method: TP_ProcessTags
// Description
// 
//  WC_Parse
// REF:  Tag2Value
//  ParseAllTags
// Parameters
// ----------------------------------------------------



// $vtTextFinal. THIS WILL HOLD THE FINAL TEXT, AND WILL BE ADDED TO
// AS WE WALK THROUGH THE TEXT

C_TEXT:C284($vtTextFinal)
$vtTextFinal:=""

// $vtTextPreceeding IS THE RAW TEXT THAT PRECEEDS THE CURRENT TAG.

C_TEXT:C284($vtTextPreceeding)
$vtTextPreceeding:=""

// $vtTableNum. THIS HOLDS THE TABLE NUMBER OF A PARSED TAG. IT WILL
// CHANGE OVER AND OVER AS WE GO THROUGH EACH TAG.

C_TEXT:C284($vtTableNum)
$vtTableNum:=""

// $vtFieldNum. THIS HOLDS THE FIELD NUMBER OF A PARSED TAG. IT WILL
// CHANGE OVER AND OVER AS WE GO THROUGH EACH TAG.

C_TEXT:C284($vtFieldNum)
$vtFieldNum:=""

// $vtOutputFormat. THIS HOLDS THE OUTPUT FORMAT OF A PARSED TAG. IT WILL
// CHANGE OVER AND OVER AS WE GO THROUGH EACH TAG.

C_TEXT:C284($vtOutputFormat)
$vtOutputFormat:=""

//$viCount and $ciIncrementor ARE USED TO RUN THE FOR LOOP

C_LONGINT:C283($viCount; $viIncrementor)
$viCount:=Size of array:C274($1->)
$viIncrementor:=0

C_OBJECT:C1216($voTag)

For ($viIncrementor; 1; $viCount)
	
	$voTag:=$1->{$viIncrementor}
	
	$vtTextPreceeding:=(OB Get:C1224($voTag; "TextPreceeding"))
	$vtTableNum:=(OB Get:C1224($voTag; "TableNum"))
	$vtFieldNum:=(OB Get:C1224($voTag; "FieldNum"))
	$vtOutputFormat:=(OB Get:C1224($voTag; "OutputFormat"))
	
	Case of 
			
		: ($vtTableNum="begin@")
			
			$vtTextFinal:=$vtTextFinal+TP_ProcessTagLoop($voTag)
			
		: ($vtTableNum="if@")
			
			$vtTextFinal:=$vtTextFinal+TP_ProcessTagIf($voTag)
			
		Else 
			
			$vtTextFinal:=$vtTextFinal+TP_ProcessTagRegular($voTag)
			
	End case 
	
End for 

$0:=$vtTextFinal