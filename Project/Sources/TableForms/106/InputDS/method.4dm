// ### jwm ### 20181214_1543 check this or restore old procedure

// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[AccountPayType:106])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	// related records not addressed by (P) RelatedGet
	// form calculations
End if 

booAccept:=True:C214  // no madatory fields

If (False:C215)
	C_LONGINT:C283($formEvent; $curRecNum)
	$formEvent:=Form event code:C388
	$curRecNum:=Record number:C243([AccountPayType:106])
	Case of 
		: ($formEvent=On Unload:K2:2)
			UNLOAD RECORD:C212(ptCurTable->)
			READ WRITE:C146([AccountPayType:106])
		: ($formEvent=On Outside Call:K2:11)
			Prs_OutsideCall
		: ($formEvent=On Load:K2:1)  //|(booPreNext))//(Before)
			MESSAGES OFF:C175
			booAccept:=True:C214
			jsetBefore(->[AccountPayType:106])
			If (bEDI_Pass)
				//setup area lists and other layout parameters
			End if 
			If (Is new record:C668([AccountPayType:106]))  //($curRecNum=-3)
				jrelateClrFiles(1)  //clear related tables
				jNxPvButtonSet  //set button actions
			End if 
			//SET TIMER(60*60*10)
			//: ($formEvent=On After Keystroke)
			//C_TEXT($keystroke)
			//$keystroke:=Get edited text
			//SET TIMER(60*60*10)
			//: ($formEvent=On Timer)//auto close windows after time passing
			//jCancelButton 
			
			Before_New(ptCurTable)
	End case 
	If (ptCurTable#(->[AccountPayType:106]))  //must be ahead of the next call
		jsetDuringIncl(->[AccountPayType:106])
		jrelateClrFiles(0)  //rebuild the arrays
	End if 
	Case of 
		: ($curRecNum>-1)
			If ((<>aLastRecNum{Table:C252(ptCurTable)}#$curRecNum) | ($formEvent=On Load:K2:1))
				<>aLastRecNum{Table:C252(ptCurTable)}:=$curRecNum
				jrelateClrFiles(0)
				//Console_Log ("TEST: jrelateClrFiles")
				
				//SET TIMER(60*60*1)
				jNxPvButtonSet
				Before_New(->[AccountPayType:106])
				curRecNum:=Selected record number:C246([AccountPayType:106])
				<>ptCurTable:=(->[AccountPayType:106])
			End if 
			
	End case 
	booAccept:=True:C214
	
	Case of 
			
			
		: ($formEvent=On Activate:K2:9)
			If (False:C215)
				//allowing this will allow changes to be displayed by then the current selected lines are lost
				RelatedRelease
			End if 
			//: ($formEvent=On Losing Focus)
			
		: ($formEvent=On Deactivate:K2:10)
			
			//: ($formEvent=On Activate)
			
			//: ($formEvent=On Getting Focus)
			
		: ($formEvent=On Close Detail:K2:24)
			READ WRITE:C146([AccountPayType:106])
			
	End case 
	//
End if 