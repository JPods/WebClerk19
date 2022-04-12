//%attributes = {"invisible":true,"shared":true}
// CodeAnalysis_FormScannerDialog (cmd, parm1, parm2)
// CodeAnalysis_FormScannerDialog (text, text, longint)
//
// DESCRIPTION
//   This method is automatically created by the Code Analysis
//   component. This method is a handler method for the
//   "CodeAnalysis_FormScanner" project form and is an
//   integral part of the abilty to export forms as XML.
//
C_TEXT:C284($1; $vt_command)
C_TEXT:C284($2; $vt_parm1)
C_LONGINT:C283($3; $vl_parm2)
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (11/01/2012)
// ----------------------------------------------------

If (Count parameters:C259>=1)
	$vt_command:=$1
End if 
If (Count parameters:C259>=2)
	$vt_parm1:=$2
End if 
If (Count parameters:C259>=3)
	$vl_parm2:=$3
End if 

C_TEXT:C284(_CA_vt_FormName; _CA_ACTION)
C_LONGINT:C283(_CA_vl_tableNo)


C_LONGINT:C283($vl_procID)
$vl_procID:=Process number:C372(Current method name:C684)
Case of 
	: ($vt_command="close")
		VARIABLE TO VARIABLE:C635($vl_procID; _CA_ACTION; $vt_command)
		
		
	: ($vt_command="OpenDialog")
		ARRAY TEXT:C222($at_projectFormNames; 0)
		FORM GET NAMES:C1167($at_projectFormNames)
		$pos:=Find in array:C230($at_projectFormNames; "CodeAnalysis_FormScanner")
		If ($pos<0)  // A check to make sure that the project form exists in the structure
			BEEP:C151
			ALERT:C41("The project form \"CodeAnalysis_FormScanner\" has not been copied to this structure.\r\rThis must be done before the forms can exported to disk.")
			ABORT:C156  // stop the process
		Else 
			
			// Check to make sure that there is code in the form method
			C_TEXT:C284($vt_formCode)
			METHOD GET CODE:C1190("[projectForm]/CodeAnalysis_FormScanner/{formMethod}"; $vt_formCode)
			If (Position:C15("CA_SaveFormProperties"; $vt_formCode)<1)
				BEEP:C151
				ALERT:C41("The project form method \"CodeAnalysis_FormScanner\" has not been copied to this structure.\r\rThis must be done before the forms can exported to disk.")
				ABORT:C156  // stop the process
			End if 
			
			If ($vl_procID<1)
				$vl_procID:=New process:C317(Current method name:C684; 1024*128; Current method name:C684)
			End if 
		End if 
		
		
	: ($vt_command="setForm")
		VARIABLE TO VARIABLE:C635($vl_procID; _CA_ACTION; $vt_command)
		VARIABLE TO VARIABLE:C635($vl_procID; _CA_vt_FormName; $vt_parm1)
		VARIABLE TO VARIABLE:C635($vl_procID; _CA_vl_tableNo; $vl_parm2)
		
		// Wait until the dialog indicates that it has completed with that action.
		Repeat 
			$vl_procID:=Process number:C372(Current method name:C684)
			If ($vl_procID>0)
				GET PROCESS VARIABLE:C371($vl_procID; _CA_ACTION; _CA_ACTION)
				If (_CA_ACTION#"")
					DELAY PROCESS:C323(Current process:C322; 5)
				End if 
			End if 
		Until ($vl_procID<1) | (_CA_ACTION="")
		
		
	: ($vl_procID#0) & ($vl_procID=Process number:C372(Current method name:C684))
		DIALOG:C40("CodeAnalysis_FormScanner")
		
End case 
