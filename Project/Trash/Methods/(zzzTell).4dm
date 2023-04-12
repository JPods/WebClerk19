//%attributes = {}
// Tell(OBJECT Get pointer(Object current); OBJECT Get value(OBJECT Get name(Object current)))


// Modified by: Bill James (2022-03-27T05:00:00Z)
// Method: Tell
// Description  From FormsInForms
// Parameters
// ----------------------------------------------------


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