//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 06/27/17, 13:35:34
// ----------------------------------------------------
// Method: EmployeesNameID
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($vtNameID; $vtFirstName; $vtLastName)
C_BOOLEAN:C305($vbDuplicate)

If (Is new record:C668([Employee:19]))
	
	$vtFirstName:=Txt_Clean([Employee:19]nameFirst:3)
	$vtLastName:=Txt_Clean([Employee:19]nameLast:2)
	
	If (($vtFirstName#"") | ($vtLastName#""))
		If (($vtFirstName#"") & ($vtLastName#""))
			[Employee:19]nameid:1:=$vtFirstName[[1]]
		Else 
			[Employee:19]nameid:1:=$vtFirstName
		End if 
		[Employee:19]nameid:1:=[Employee:19]nameid:1+$vtLastName
		
		// check for duplicate nameID
		$vtNameID:=[Employee:19]nameid:1
		PUSH RECORD:C176([Employee:19])
		QUERY:C277([Employee:19]; [Employee:19]nameid:1=$vtNameID)
		
		If (Records in selection:C76([Employee:19])>0)
			$vbDuplicate:=True:C214
		Else 
			$vbDuplicate:=False:C215
		End if 
		POP RECORD:C177([Employee:19])
		
		// If duplicate use full name
		If ($vbDuplicate)
			[Employee:19]nameid:1:=$vtFirstName+$vtLastName
		End if 
		
	Else 
		[Employee:19]nameid:1:=String:C10([Employee:19]idNum:71)  // ### jwm ### 20160810_1124
	End if 
	
End if 
