//%attributes = {}
// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 06/17/19, 11:15:54
// ----------------------------------------------------
// Method: WCR_IsResource
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_BOOLEAN:C305($0; $vbIsResource)

C_TEXT:C284($1; $vtResourceName)
$vtResourceName:=Lowercase:C14($1)

// ******************************************************************************************** //
// ** TEST TO SEE IF THE RESOURCENAME IS JUST A TRUE TABLE. IF NOT, CHECK IF IT IS A RESOURCE * //
// ******************************************************************************************** //
// ### bj ### 20210211_0154
// currently only use existing resources
If (STR_IsTable($vtResourceName))
	
	$vbIsResource:=True:C214
	
Else 
	
	CREATE SET:C116([GenericChild2:91]; "TempSet_WCRIsResource")
	
	QUERY:C277([GenericChild2:91]; [GenericChild2:91]Purpose:4="WebClerkResource"; *)
	QUERY:C277([GenericChild2:91];  & ; [GenericChild2:91]Name:3=$vtResourceName; *)
	QUERY:C277([GenericChild2:91])
	
	If (Records in selection:C76([GenericChild2:91])>0)
		
		$vbIsResource:=True:C214
		
	Else 
		
		$vbIsResource:=False:C215
		
	End if 
	
	UNLOAD RECORD:C212([GenericChild2:91])
	REDUCE SELECTION:C351([GenericChild2:91]; 0)
	USE SET:C118("TempSet_WCRIsResource")
	CLEAR SET:C117("TempSet_WCRIsResource")
	
End if 

// ******************************************************************************************** //
// ** RETURN A BOOLEAN SHOWING IF THE PASSED RESOURCE NAME IS REALLY A RESOURCE *************** //
// ******************************************************************************************** //

$0:=$vbIsResource