//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Andy
// Date and time: 09/11/17, 14:38:43
// ----------------------------------------------------
// Method: PageGetObject
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0; $1; $vtObjectName; $vtObjectPath; $vtObject)
C_LONGINT:C283($viObjectIndex)

// STANDARDIZE FOLDER SEPARATOR

$vtObjectName:=Replace string:C233($1; "/"; Folder separator:K24:12)

// GET OBJECT PATH

$vtObjectPath:=Storage:C1525.wc.webFolder+"jitObjects"+Folder separator:K24:12+$vtObjectName

// GET CONTENTS OF OBJECT

$viObjectIndex:=Find in array:C230(<>aWebObjectName; $vtObjectPath)

If ($viObjectIndex>0)
	
	$vtObject:=<>aWebObjectValue{$viObjectIndex}
	
Else 
	
	If (<>viDebugMode>2)  // ### AZM ### 20170927_1432
		
		$vtObject:="Object not found"
		
	Else 
		
		$vtObject:=""
		
	End if 
	
	
End if 

// RETURN OBJECT CONTENTS

$0:=$vtObject