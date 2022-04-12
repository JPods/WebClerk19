//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/12/07, 17:49:38
// ----------------------------------------------------
// Method: TallyMasterExecutePopup
// Description
//ONLY INTERNAL EMPLOYEE USE
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160908_1007 command key to create new script
// ### jwm ### 20160908_1005 option key to display scripts
// ### jwm ### 20160909_0937 confirm before creating new script
// ### jwm ### 20190815_1137 moved restricted notice alert message

C_POINTER:C301($1; $2)
C_TEXT:C284($3)
C_BOOLEAN:C305($restrictNotice; $doChange)
$restrictNotice:=Not:C34(UserInPassWordGroup("UnlockRecord"))
KeyModifierCurrent
Case of 
		
	: ($2->{$2->}="-- TallyMasters below --")
		ALERT:C41("Scripts listed below this selection")
		
	: ($2->{$2->}="Index/Duplicates@")
		sortFiles
		
	: ($2->{$2->}="Distinct Values@")  // ### jwm ### 20190718_1250
		DistinctValues
		
	: ($2->{$2->}="UserSet@")
		C_OBJECT:C1216($obPassable)
		C_TEXT:C284($tableName)
		COPY SET:C600("UserSet"; "<>curUserSet")
		$tableName:=Table name:C256(ptCurTable)
		$obPassable:=New object:C1471("tableName"; $tableName; "form"; "Input"; "tableForm"; $tableName+"_Input")
		$viProcess:=New process:C317("Process_ByUseSet"; 0; $tableName+" - "+String:C10(Count tasks:C335); $obPassable)
		
	: ($2->{$2->}="Help-@")
		HelpPopUp(<>viHelpSet; "oLo_"+Table name:C256(ptCurTable))
		
	: ($2->{$2->}="New Script")
		If ($restrictNotice)
			ALERT:C41("You must belong to the 'UnlockRecord' Password Group to edit.")
		Else 
			CONFIRM:C162("Create New Script"; " Create "; " Cancel ")  // ### jwm ### 20160909_0937
			If (OK=1)
				CREATE RECORD:C68([TallyMaster:60])
				
				[TallyMaster:60]purpose:3:=$3+"Scripts"
				[TallyMaster:60]tableNum:1:=Table:C252($1)
				[TallyMaster:60]publish:25:=Storage:C1525.user.securityLevel
				[TallyMaster:60]name:8:="ReplaceWithUniqueName"
				SAVE RECORD:C53([TallyMaster:60])
				ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
			End if 
		End if 
		
	: ($2->{$2->}="Edit Scripts")  // ### jwm ### 20160908_1005
		If ($restrictNotice)
			ALERT:C41("You must belong to the 'UnlockRecord' Password Group to edit.")
		Else 
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3=$3+"Scripts"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252($1))
			If (Records in selection:C76([TallyMaster:60])>0)
				ProcessTableOpen(Table:C252(->[TallyMaster:60])*-1)
			End if 
		End if 
		
	Else 
		C_LONGINT:C283($selectedItem)
		$selectedItem:=$2->
		READ ONLY:C145([TallyMaster:60])
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=$2->{$selectedItem}; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3=$3+"Scripts"; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25>0; *)
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]publish:25<=Storage:C1525.user.securityLevel; *)  //ONLY INTERNAL EMPLOYEE USE
		//If (vWccSecurity>0)
		//QUERY([TallyMaster];&[TallyMaster]Publish<=vWccSecurity;*)//Storage.user.securityLevel
		//Else 
		//QUERY([TallyMaster];&[TallyMaster]Publish<=viEndUserSecurityLevel;*)
		//End if 
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]tableNum:1=Table:C252($1))
		
		Case of 
			: (Records in selection:C76([TallyMaster:60])=1)
				
				ExecuteText(0; [TallyMaster:60]script:9)
			: (Records in selection:C76([TallyMaster:60])=0)
				ALERT:C41("No TallyMasters script record with name: "+$2->{$selectedItem})
			: (Records in selection:C76([TallyMaster:60])>1)
				ALERT:C41("Multiple TallyMasters script records with name: "+$2->{$selectedItem})
		End case 
		REDUCE SELECTION:C351([TallyMaster:60]; 0)
		READ WRITE:C146([TallyMaster:60])
End case 

$2->:=1  // ### jwm ### 20160830_1601