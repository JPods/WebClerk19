//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/09/18, 15:10:48
// ----------------------------------------------------
// Method: jAlertMessage
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1; $2; $messageNum; $messageMod)
C_TEXT:C284($3; $messageText)
C_LONGINT:C283(Error)
C_TEXT:C284($Comment)
C_BOOLEAN:C305(allowAlerts_boo)
C_TEXT:C284(vResponse)
If (Count parameters:C259>0)
	$messageNum:=$1
	If (Count parameters:C259>1)
		$messageMod:=$2
		If (Count parameters:C259>1)
			$messageText:=$3
		End if 
	End if 
End if 


Case of 
	: ($messageText#"")
		//  ALERT($messageText)
	: (vResponse#"")
		// ALERT(vResponse)  // failure was discovered in TallyMaster OnAccept
		$messageText:=vResponse
		vResponse:=""
	: ($messageNum=0)
		$messageText:="Error:  "+String:C10(Error)+"; refer to Appendix for explanation."
	: ($messageNum=-9999)
		$messageText:="Not enough memory to write to disk."
	: ($messageNum=-9998)
		$messageText:="Duplicate entry in a unique field."
	: ($messageNum=-9997)
		$messageText:="Duplicate entry in a unique field or probable duplicate."
	: ($messageNum=9000)
		$messageText:="You may not create or import records in a restricted file."
	: ($messageNum=9001)
		$Comment:=(""*Num:C11($messageMod=0))+("APPLY changes to the "*Num:C11($messageMod=1))+("IMPORT into the "*Num:C11($messageMod=2))
		$messageText:="You may not "+$Comment+"this File."
	: ($messageNum=9002)
		$messageText:="You must be at the splash screen to change files."
	: ($messageNum=9200)
		$messageText:="Authorization required and/or all Required Fields (UNDERLINED) must be completed"
	: ($messageNum=9201)
		$messageText:="The record or destination cannot be found."
	: ($messageNum=9202)
		$messageText:="No Record has been opened."
	: ($messageNum=9203)
		$messageText:="An Account Code MUST be entered."
	: ($messageNum=9204)
		$messageText:="Direct access not allowed."
	: ($messageNum=9205)
		$messageText:="WARNING -- No Customer - Tax not set."
	: ($messageNum=9206)
		$messageText:="Changes are not allowed after creating journal entries."
	: ($messageNum=9207)
		$messageText:="Assure that existing line items are appropriately Priced and Taxed."
	: ($messageNum=9208)
		$messageText:="Linked Invoices may not be modified."
	: ($messageNum=9209)
		$messageText:="Click on the desired Line(s)."
	: ($messageNum=9210)
		$messageText:="Add all information before creating a record."
	: ($messageNum=9211)
		$messageText:="Blobs, Picture and Subfiles Files may not used."
	: ($messageNum=9212)
		$messageText:="Warning:  you are duplicating a field."
	: ($messageNum=9213)
		$messageText:="You may not change the Item Number if Shipments have been made."
	: ($messageNum=9214)
		$messageText:="Change is different than allowed."
	: ($messageNum=9215)
		$messageText:="Check for account code overlap."
	: ($messageNum=9220)
		$messageText:="Credit plus Payment cannot exceed Unpaid Amount."
	: ($messageNum=9221)
		$messageText:="Privilege error."
	: ($messageNum=9221)
		$messageText:="Privilege error."
	: ($messageNum=9231)
		$messageText:="Required field incomplete."+"\r"+"Underlined fields required."
	: ($messageNum=9251)
		$messageText:="siteID must be selected."
	: ($messageNum=9280)
		$messageText:="No matching weight chart."
	: ($messageNum=9281)
		$messageText:="Total weight exceeded shipping weight chart."
	: ($messageNum=9282)
		$messageText:="No Ship and Carrier Zone Code match."
	: ($messageNum=9283)
		$messageText:="No matching carrier record."
	: ($messageNum=10001)
		$messageText:="You may not import the header."
	: ($messageNum=10002)
		$messageText:="Accept or Cancel current record before adding records."
	: ($messageNum=10003)
		$messageText:="No Records in Selection."
	: ($messageNum=10004)
		$messageText:="Display Record ONLY, Record is LOCKED by another user."
	: ($messageNum=10005)
		$messageText:="Cloning a sorted record will cause you to lose your selection."
	: ($messageNum=10006)
		$messageText:="Last entry is a RESERVED record."
	: ($messageNum=10007)
		$messageText:="No changes permitted after Linking to Accounting."
	: ($messageNum=10008)
		$messageText:="No changes permitted on Saved Invoices."
	: ($messageNum=10009)
		$messageText:="New rates will only affect Line Items which are modified."
	: ($messageNum=10010)
		$messageText:="No changes permitted after creating Journal entery."
	: ($messageNum=10011)
		$messageText:="Record ed -- NO ACTION."
	: ($messageNum=10012)
		$messageText:="Select Process or Attributes first."
	: ($messageNum=10013)
		$messageText:="Must be greater than ZERO."
		//Related
	: ($messageNum=10014)
		$messageText:="There are locked records preventing tally."
	: ($messageNum=10100)
		$messageText:="Navigation to the file is not permitted from the input layout."
	: ((Error=-9991) | ($messageNum=-9991))
		$messageText:=Current user:C182+": Requires password group to use this feature."
	: ((Error=-9992) | ($messageNum=-9992))
		$messageText:="Incorrect password for "+Current user:C182+"."
	: ($messageNum=11001)
		$messageText:="Allows publishing to the web."
	: ($messageNum=12000)
		$messageText:="Serialize Item does not exist, locked or not available for this action."
	: ($messageNum=12001)
		$messageText:="Serialize Items may not have a Location ID of less than 0."
	: ($messageNum=12002)
		$messageText:="Turn on serial number tracking in Defaults."
	: ($messageNum=12003)
		$messageText:="There already exists a primary record for this file."
	: ($messageNum=12005)
		$messageText:="You may not use an empty value."
	: ($messageNum=12006)
		$messageText:="This serial number is already used with this item."
	: ($messageNum=12007)
		$messageText:="You must fill a Serial Number or TBD."
	: ($messageNum=12008)
		$messageText:="Record or Path is locked."+"\r"+"It is likely you are looping back onto an already open record."
	: ($messageNum=12009)
		$messageText:="Record is locked from changes."
	: ($messageNum=17000)
		$messageText:="Error in creating or selecting the print document."
	: ($messageNum=17001)
		$messageText:="Document does not exist."
	: ($messageNum=17002)
		$messageText:="Folder does not exist."
	: ($messageNum=17003)
		$messageText:="Document is open by another application."
	: ($messageNum=17004)
		$messageText:="Saved."
	: ($messageNum=18000)
		$messageText:="Currently a Mac only feature."
	: ($messageNum=18001)
		$messageText:="Check Sync record count."
	: ($messageNum=18002)
		$messageText:="Orphan record, check it key linking field values."
	: ($messageNum=19001)
		$messageText:="Feature requires 4D Write."
	: ($messageNum=19002)
		$messageText:="Feature requires 4D Calc."
	: ($messageNum=19003)
		$messageText:="Feature requires 4D Draw."
End case 
If (Storage:C1525.vbEDIPass)
	ALERT:C41($messageText)
Else 
	ConsoleMessage($messageText)
End if 


