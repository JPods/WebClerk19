//%attributes = {"invisible":true,"shared":true}
// CodeAnalysis_FormObjectStub (activateStubToIntercept)
// CodeAnalysis_FormObjectStub (boolean)
//
// DESCRIPTION
//   This method is installed as the first line of form methods
//   and form object methods. Does nothing unless the
//   Code Analysis component is scanning forms, then it 
//   avoids all form events.
//
C_BOOLEAN:C305($1; $vb_activateStubToIntercept)  // OPTIONAL - Used to turn scanning on/off
// ----------------------------------------------------
// HISTORY
//   Created by: Dani Beaubien (10/31/2012)
// ----------------------------------------------------

C_BOOLEAN:C305(<>_CODEANALYSIS_SCANNING_FORMS)
If (Count parameters:C259>=1)
	$vb_activateStubToIntercept:=$1
	
	<>_CODEANALYSIS_SCANNING_FORMS:=$vb_activateStubToIntercept
Else 
	If (<>_CODEANALYSIS_SCANNING_FORMS)
		ABORT:C156
	End if 
End if 
