//%attributes = {}
// ### jwm ### 20181214_1543 check this or restore old procedure
// ### bj ### 20181201_1034
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[Carrier:11])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		For ($i; 12; 18)  //table specific data events
			Field:C253(Table:C252(->[Carrier:11]); $i)->:=$i-10
		End for 
		[Carrier:11]dateEntered:1:=Current date:C33
		[Carrier:11]approvedNameid:2:=Current user:C182
		[Carrier:11]factor:5:=1
		[Carrier:11]active:6:=False:C215
		[Carrier:11]cODCharge:7:=3.5
		[Carrier:11]avgBoxWt:8:=25
		[Carrier:11]handlingCharge:9:=2.45
		[Carrier:11]costType:20:=True:C214
		REDUCE SELECTION:C351([CarrierZone:143]; 0)
		REDUCE SELECTION:C351([CarrierWeight:144]; 0)
		
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	// related records not addressed by (P) RelatedGet
	// form calculations
	
	
	
End if 

booAccept:=(([Carrier:11]carrierid:10#"") & ([Carrier:11]approvedNameid:2#"") & ([Carrier:11]avgBoxWt:8#0) & ([Carrier:11]zipLength:19#0))

// ### bj ### 20181201_1042  Delete after 2019-01-01
If (False:C215)
	C_LONGINT:C283($formEvent; $curRecNum; changerecord)
	$formEvent:=Form event code:C388  //get the form event
	$curRecNum:=Record number:C243([Carrier:11])
	
	Case of 
		: ($formEvent=On Unload:K2:2)
			UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
			READ WRITE:C146([Carrier:11])
		: ($formEvent=On Outside Call:K2:11)
			Prs_OutsideCall
		: ($formEvent=On Load:K2:1)  //runs when window opens for the first time
			MESSAGES OFF:C175
			booAccept:=True:C214
			jsetBefore(->[Carrier:11])  //organize the window features for this table
			If (allowAlerts_boo)
				//setup area lists and other layout parameters
				RelatedGet  // ### jwm ### 20171116_2155
				Before_New(ptCurTable)  //last thing to do  // ### jwm ### 20170717_1817 On_Open
				
			End if 
		: ($formEvent=On Activate:K2:9)
			//If (False)
			//allowing this will allow changes to be displayed by then the current selected lines are lost
			RelatedGet
			//End if 
			//: ($formEvent=On Losing Focus)
			
		: ($formEvent=On Deactivate:K2:10)
			
			//: ($formEvent=On Getting Focus)
			
		: ($formEvent=On Close Detail:K2:24)
			READ WRITE:C146([Carrier:11])
		: ($formEvent=On Timer:K2:25)  //auto close windows after time passing
			TimeWindowClose
	End case 
	If (changerecord#0)
		If (Is new record:C668([Carrier:11]))  //($curRecNum=-3)  //manages special entries for new records
			//jrelateClrFiles (1)  //clear related tables
			RelatedGet
			jNxPvButtonSet  //set button actions
			
			For ($i; 12; 18)  //table specific data events
				Field:C253(Table:C252(->[Carrier:11]); $i)->:=$i-10
			End for 
			[Carrier:11]dateEntered:1:=Current date:C33
			[Carrier:11]approvedNameid:2:=Current user:C182
			[Carrier:11]factor:5:=1
			[Carrier:11]active:6:=False:C215
			[Carrier:11]cODCharge:7:=3.5
			[Carrier:11]avgBoxWt:8:=25
			[Carrier:11]handlingCharge:9:=2.45
			[Carrier:11]costType:20:=True:C214
			
			
			REDUCE SELECTION:C351([CarrierZone:143]; 0)
			REDUCE SELECTION:C351([CarrierWeight:144]; 0)
			
			Before_New(ptCurTable)  //must be inside this if to avoid double running: If ($curRecNum>-1)
		End if 
		
		If (ptCurTable#(->[Carrier:11]))  //vHere > 2, coming back from another table in this window.  Reset features for this table.
			jsetDuringIncl(->[Carrier:11])
			changerecord:=-11
		End if 
		If ((changerecord#0) | ($curRecNum#<>aLastRecNum{Table:C252(ptCurTable)}) | ($formEvent=On Load:K2:1))  //fill in details for an existing record onLoad and set window values for a newly displayed record.
			changerecord:=0
			curRecNum:=Record number:C243([Carrier:11])
			<>aLastRecNum{Table:C252(ptCurTable)}:=Record number:C243(ptCurTable->)  //remember the current record number to avoid reloading details.
			RelatedRelease
			
			jNxPvButtonSet
			Before_New(->[Carrier:11])
			TimeWindowOpen  //Set window characteristic for automatic closing
		End if 
		
	End if 
	If ($formEvent=On After Keystroke:K2:26)  //manage time feature based on user action.
		TimeWindowKeyStroke
	End if 
	// Modified by: Bill James (2015-02-17T00:00:00 Removed related table requirement. Not needed is scripts are used.)
	booAccept:=(([Carrier:11]carrierid:10#"") & ([Carrier:11]approvedNameid:2#"") & ([Carrier:11]avgBoxWt:8#0) & ([Carrier:11]zipLength:19#0))
	
End if 