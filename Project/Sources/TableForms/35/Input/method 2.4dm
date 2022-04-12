// ### jwm ### 20181214_1543 check this or restore old procedure

// ### bj ### 20181201_1040
C_LONGINT:C283($formEvent)
// $formEvent:=form event
$formEvent:=iLoProcedure(->[AdSource:35])
$doMore:=False:C215

Case of 
	: (iLoReturningToLayout)  //set in iLoProcedure only once, returning from other table
		$doMore:=True:C214
		
	: (iLoRecordNew)  //set in iLoProcedure only once, new record
		$doMore:=True:C214
		
		If ([AdSource:35]marketEffort:2="")
			booAccept:=False:C215
			GOTO OBJECT:C206([AdSource:35]marketEffort:2)
		Else 
			OBJECT SET ENTERABLE:C238([AdSource:35]marketEffort:2; False:C215)
			booAccept:=True:C214
		End if 
		
	: (iLoRecordChange)  //set in iLoProcedure only once, existing record
		$doMore:=True:C214
		
End case 

If ($doMore)  //action for the form regardless of new or existing record
	
	
	// related records not addressed by (P) RelatedGet
	// form calculations
	var $oDocs : Object
	$oDocs:=ds:C1482.Document.query("idRelated  = :1 & tableNum = :2"; [AdSource:35]id:58; Table:C252(->[AdSource:35]))
	// Add Documents
	// MustFixQQQZZZ: Bill James (2022-01-22T06:00:00Z)
End if 

AdSourceCalc
booAccept:=True:C214  // no madatory fields

