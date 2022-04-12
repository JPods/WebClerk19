//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/30/21, 20:41:26
// ----------------------------------------------------
// Method: Form_TellSub
// Description
// 
// Parameters
// ----------------------------------------------------
// ----------------------------------------------------
//  Tell(OBJECT Get pointer(Object current); OBJECT Get value(OBJECT Get name(Object current)))
// FormsInForms Example


C_POINTER:C301($1)  //Pointer on the caller
C_VARIANT:C1683($2)  //Value
$event:=FORM Event:C1606
Case of 
	: ($event.code=-100)  //Call upstairs
		Form:C1466.origin:=$event.name
		CALL SUBFORM CONTAINER:C1086($event.code)
	Else 
		//call this form
End case 