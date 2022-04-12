//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-19T00:00:00, 09:33:27
// ----------------------------------------------------
// Method: URpt_SetTypePrm
// Description
// Modified: 08/19/13
// 
// 
//
// Parameters
// ----------------------------------------------------


//check and set/correct parameters required for all recognized Creator Types
C_BOOLEAN:C305($fileOpen)
$fileOpen:=False:C215

URpt_SetTypePop
Case of 
	: ([UserReport:46]Creator:6="Fax")
		//No Param Requirements
	: ([UserReport:46]Creator:6="Browser")
		//No Param Requirements    
	: ([UserReport:46]Creator:6="SuperReport")
		//No Param Requirements    
	: ([UserReport:46]Creator:6="QuickReport")
		//No Param Requirements
	: ([UserReport:46]Creator:6="Script")
		If ([UserReport:46]ScriptBegin:5="")
			$fileOpen:=URpt_DocLocPath("TEXT"; "Locate Program File")
			If ($fileOpen)
				CLOSE DOCUMENT:C267(myDoc)
			End if 
		End if 
	: ([UserReport:46]Creator:6="EDIx")
		[UserReport:46]Creator:6:="Script"
		//No Param Requirements
	: (([UserReport:46]Creator:6="TxtO") | ([UserReport:46]Creator:6="Text-Out"))
		[UserReport:46]Creator:6:="Text-Out"
		$fileOpen:=URpt_DocLocPath("TEXT"; "Locate Program File")
		If ($fileOpen)
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	: (([UserReport:46]Creator:6="EDIO") | ([UserReport:46]Creator:6="EDI-Out"))
		[UserReport:46]Creator:6:="EDI-Out"
		If ([UserReport:46]Template:7="")
			$fix:=True:C214
		Else 
			QUERY:C277([EDISetID:76]; [EDISetID:76]DocType:1=[UserReport:46]Template:7)
			If (Records in selection:C76([EDISetID:76])>0)
				$fix:=False:C215
			Else 
				$fix:=True:C214
			End if 
		End if 
		If ($fix)
			QUERY:C277([EDISetID:76]; [EDISetID:76]InputOutput:2=False:C215)  //output type only
			ARRAY TEXT:C222(<>yURptDTypes; 0)
			SELECTION TO ARRAY:C260([EDISetID:76]DocType:1; <>yURptDTypes)
			Ray_Distinct(-><>yURptDTypes)
			<>yURptDTypes:=Num:C11(Size of array:C274(<>yURptDTypes)>0)
			vDiaCom:="Select the EDI Set ID for this User Report."
			jCenterWindow(220; 102)
			DIALOG:C40([EDISetID:76]; "diaDistinctDTyp")
			If (OK=1)
				[UserReport:46]Template:7:=<>yURptDTypes{<>yURptDTypes}
			Else 
				[UserReport:46]Creator:6:=""
				<>yURptTypes:=1  //other
			End if 
		End if 
		If (Size of array:C274(aLoText5)>=<>yURptTypes)
			aLoText5:=<>yURptTypes
		End if 
	: (([UserReport:46]Creator:6="EDII") | ([UserReport:46]Creator:6="EDI-In"))
		[UserReport:46]Creator:6:="EDI-In"
		//No Param Requirements
End case 