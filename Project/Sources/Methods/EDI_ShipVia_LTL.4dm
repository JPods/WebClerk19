//%attributes = {}
//Script   ShipVia_LTL.4d
//Author   James W Medlen
//Date     20090224
//Modified 20160913


//<declarations>
//==================================
//  Type variables 
//==================================

C_BOOLEAN:C305(allowAlerts_boo)
C_LONGINT:C283(vi1; vi2; viLength; viMatch; viStart)
C_REAL:C285(vrSumWt)
C_TEXT:C284(vtComment; vtFedExAccount; vtMyDate; vtMyMessage; vtMyTime; vtRegex; vtUPSAccount)

//==================================
//  Initialize variables 
//==================================

// allowAlerts_boo:=False
// vi1:=0
// vi2:=0
// viLength:=0
// viMatch:=0
// viStart:=0
// vrSumWt:=0
// vtComment:=""
// vtFedExAccount:=""
// vtMyDate:=""
// vtMyMessage:=""
// vtMyTime:=""
// vtRegex:=""
// vtUPSAccount:=""
//</declarations>

vi2:=Size of array:C274(aoExtWt)
vrSumWt:=0

For (vi1; 1; vi2)
	vrSumWt:=vrSumWt+aoExtWt{vi1}
End for 

//Alert("Sum of Extended Weight = "+String(vrSumWt))

If (vrSumWt>=150)
	
	[Order:3]shipVia:13:="FedEx Freight"
	[Order:3]upsBillingOption:89:="Bill 3rd Party"
	[Order:3]upsReceiverAcct:90:="On File"
	
Else 
	
	// Script SBT EDI Bill 3rd Party Account Numbers 20160211
	
	ARRAY TEXT:C222(atMatches; 0; 0)
	//C_TEXT(vtUPSAccount;vtFedExAccount)
	//C_Longint(viMatch)
	
	[Order:3]upsBillingOption:89:="Prepaid & Add"
	[Order:3]upsReceiverAcct:90:=""
	
	vtRegex:="UPS ACCOUNT NUMBER:[ -]{0,1}([a-zA-Z0-9]+) "
	vtUPSAccount:=""
	viMatch:=Preg Match All(vtRegex; [Order:3]commentProcess:12; atMatches; Regex Multi Line)
	If (viMatch>=1)
		vtUPSAccount:=atMatches{1}{2}
		//Alert("UPS ACCOUNT NUMBER: = "+vtUPSAccount)
	End if 
	
	ARRAY TEXT:C222(atMatches; 0; 0)
	vtRegex:="FEDEX ACCOUNT NUMBER:[ -]{0,1}([a-zA-Z0-9]+) "
	vtFedExAccount:=""
	viMatch:=Preg Match All(vtRegex; [Order:3]commentProcess:12; atMatches; Regex Multi Line)
	If (viMatch>=1)
		vtFedExAccount:=atMatches{1}{2}
		//Alert("FEDEX ACCOUNT NUMBER: = "+vtFedExAccount)
	End if 
	
	If ([Order:3]shipVia:13="@UPS@")  // UPS Accounts are 6 characters
		If (vtUPSAccount#"")
			vtUPSAccount:=Replace string:C233(vtUPSAccount; "-"; "")  // remove dashes
			viLength:=Length:C16(vtUPSAccount)
			viStart:=viLength-5
			vtUPSAccount:=Substring:C12(vtUPSAccount; viStart)
		End if 
		[Order:3]upsReceiverAcct:90:=vtUPSAccount
		[Order:3]upsBillingOption:89:="Bill 3rd Party UPS"
	End if 
	
	If ([Order:3]shipVia:13="@FedEx@")
		If (vtFedExAccount#"")
			vtFedExAccount:=Replace string:C233(vtFedExAccount; "-"; "")  // remove dashes
			While (vtFedExAccount[[1]]="0")
				vtFedExAccount:=Substring:C12(vtFedExAccount; 2)
			End while 
		End if 
		[Order:3]upsReceiverAcct:90:=vtFedExAccount
		[Order:3]upsBillingOption:89:="Bill 3rd Party FedEx"
		
	End if 
	
	If ([Order:3]upsReceiverAcct:90="")
		If ([Order:3]status:59="")  //don't overwrite previous Error status
			[Order:3]status:59:="EXCEPTION"
		End if 
		If ([Order:3]profile4:103#"@ERR@")
			[Order:3]profile4:103:=[Order:3]profile4:103+"ERR "
		End if 
		//Script Sales Order Comment
		vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
		vtMyDate:=String:C10(Current date:C33; 4)
		vtMyMessage:="Error: Missing Siemens Bill 3rd Party Account "
		vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyMessage+Char:C90(13)
		[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
	Else 
		// validate Bill 3rd Party address
		allowAlerts_boo:=False:C215
		//Execute_TallyMaster("N1_11_Bill3rdParty";"Scripts";3)
		EDI_Bill3rdParty
	End if 
	
	If ([Order:3]upsBillingOption:89="Prepaid & Add")
		If ([Order:3]status:59="")  //don't overwrite previous Error status
			[Order:3]status:59:="EXCEPTION"
		End if 
		If ([Order:3]profile4:103#"@ERR@")
			[Order:3]profile4:103:=[Order:3]profile4:103+"ERR "
		End if 
		//Script Sales Order Comment
		vtMyTime:=String:C10(Current time:C178; HH MM AM PM:K7:5)
		vtMyDate:=String:C10(Current date:C33; 4)
		vtMyMessage:="Error: Freight Billing Option =  Prepaid & Add"
		vtComment:=vtMyDate+": "+vtMyTime+"; "+vtMyMessage+Char:C90(13)
		[Order:3]commentProcess:12:=Insert string:C231([Order:3]commentProcess:12; vtComment; 0)
	End if 
	
End if 

