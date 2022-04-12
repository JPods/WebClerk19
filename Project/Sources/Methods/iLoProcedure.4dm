//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/27/09, 01:10:49
// ----------------------------------------------------
// Method: iLoProcedure
// Description
//
//
// Parameters
// ----------------------------------------------------
var $doRecordChange; $newRecord : Boolean
var $1 : Pointer
var $curRecNum; Formeventcode; changeRecord; curRecNum; vHereLast : Integer
var $0 : Integer
$0:=Form event code:C388
Case of 
	: (Is new record:C668($1->))
		// no new records in classic
		CANCEL:C270
	: (process_o.tableName=Null:C1517)
		
		// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
		// add user security to this also
		CANCEL:C270
	Else 
		
		// the form event can also be used outside this general procedure for any specific form activity
		// this is here so general features can be added to all layouts
		var $doLoad : Boolean
		$doLoad:=False:C215
		Case of 
			: (process_o.cur=Null:C1517)
				process_o.cur:=DB_RecordReturnObject(process_o.tableName)
				process_o.old:=Null:C1517  // NEVER_FROM_CLASSIC Bill James (2022-01-28T06:00:00Z)
				
				$doLoad:=True:C214
			: (process_o.cur.id=Null:C1517)
				CANCEL:C270
				ALERT:C41("No existing record.")
			: (process_o.cur.id#(STR_Get_idPointer(process_o.tableName)->))
				process_o.cur:=DB_RecordReturnObject(process_o.tableName)
				$doLoad:=True:C214
		End case 
		
		If ($doLoad)  // LIKELY Remove from CLASSIC
			// every opening and changing of records
			
			curRecNum:=Record number:C243($1->)  // even if -3, Manage Last Record
			var $o : Object
			$o:=New object:C1471(process_o.tableName; process_o.cur.id)
			Storage_Replace($o; "lastEntity")
			//remember the current record number to avoid reloading details
			//jOpenLastRec can manage -3 values
			// only place in the program this should be called
			// will have to remove others as iLo procedures are standardized
			
			
			// LIKELY Remove from CLASSIC
			// perhaps this should be moved out individual table calls
			RelatedGet  // always relate records
			// Is new record($1->) is also relate for new records to clear values
			
			TimeWindowOpen  //Set window characteristic for automatic closing
			// reset for opening and changing records
			//jrelateClrFiles (0)
			
			
		End if 
		
		
		// ### bj ### 20181115_0721
		// clear from previous use
		// these affect $doMore in the iLo
		iLoReturningToLayout:=False:C215
		iLoRecordNew:=False:C215
		iLoRecordChange:=False:C215
		
		Case of 
			: (Form event code:C388=On Load:K2:1)  // see line 102
				vHere:=2
				ptCurTable:=$1
				AutoSpellCheckOff
				MESSAGES OFF:C175
				var $passGroupOK : Boolean
				
				jsetBefore($1)  //organize the window features for this table
				
				iLoRecordChange:=True:C214
				
				SF_LoadByTable
				
			: (Form event code:C388=On After Keystroke:K2:26)  //manage time feature based on user action.
				TimeWindowKeyStroke
				
			: (Form event code:C388=On Activate:K2:9)
				TimeWindowKeyStroke
				//: (Form event code=On Losing Focus)
				
			: (Form event code:C388=On Deactivate:K2:10)
				
			: (Form event code:C388=On Close Box:K2:21)  // ### jwm ### 20181211_1052
				jCancelButton
				
			: (Form event code:C388=On Load Record:K2:38)
				changeRecord:=-22  // do not normally see this unless buttons are set to create form events
				
				//: (Form event code=On Getting Focus)
				
			: (Form event code:C388=On Close Detail:K2:24)
				READ WRITE:C146($1->)
			: (Form event code:C388=On Timer:K2:25)  //auto close windows after time passing
				TimeWindowClose
			: (Form event code:C388=On Unload:K2:2)
				UNLOAD RECORD:C212($1->)  //set the record so it can be opened by others
				READ WRITE:C146($1->)
				//: (Form event code=On Load Record)
				
			: (Form event code:C388=On Outside Call:K2:11)
				Prs_OutsideCall
				
			: (Form event code:C388=On Display Detail:K2:22)
				
			: (Form event code:C388=On Close Detail:K2:24)
				
			: (Form event code:C388=On Close Box:K2:21)
				
			: (Form event code:C388=On Validate:K2:3)
				
			: (Form event code:C388=On Timer:K2:25)  //auto close windows after time passing
				
			: (Form event code:C388=On Resize:K2:27)  //auto close windows after time passing
				
			: (Form event code:C388=On Menu Selected:K2:14)
				
			: (Form event code:C388=On Before Keystroke:K2:6)
				
			: (Form event code:C388=On Load Record:K2:38)  // I do not understand what this does
				// set a value to 222222
				//
			: (Form event code:C388=On After Keystroke:K2:26)
				var $keystroke : Text
				$keystroke:=Get edited text:C655
				SET TIMER:C645(60*60*10)
				
			: (Form event code:C388=On Getting Focus:K2:7)  // move to InputDS only
				var $found : Integer
				$found:=Prs_CheckRunnin("TextView")
				If ($found>0)
					
					var $vlFieldNum; $vlTableNum : Integer
					RESOLVE POINTER:C394(Focus object:C278; $vsVarName; $vlTableNum; $vlFieldNum)
					If (($vlTableNum#0) & ($vlFieldNum#0))
						If (False:C215)
							Case of 
								: ($vlFieldNum=1)  // Last name field
									vtStatusArea:="Enter the Last name of the Contact; it will be capitalized automatically"
									// ...
								: ($vlFieldNum=10)  // Zip Code field
									vtStatusArea:="Enter a 5-digit zip code; it will be checked and validated automatically"
									// ...
							End case 
						End if 
						If (Type:C295(Field:C253($vlTableNum; $vlFieldNum)->)=Is text:K8:3)
							<>vTextRead:=(Field:C253($vlTableNum; $vlFieldNum)->)
							<>vTextReadField:="["+Table name:C256($vlTableNum)+"]"+Field name:C257($vlTableNum; $vlFieldNum)
						Else 
							<>vTextRead:=""
							<>vTextReadField:=""
						End if 
						POST OUTSIDE CALL:C329(<>aPrsNum{$found})
					End if 
				End if 
		End case 
		
		
End case 
//  booAccept:=True  // set this in form specific iLo

