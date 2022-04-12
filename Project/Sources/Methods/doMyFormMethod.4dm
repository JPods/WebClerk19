//%attributes = {}
//YYYYY
// doMyFormMethod ( ) – used inside a form that is being operated as ‘dynamic’, execute the code that was associated with the current object in the curent form
var $myName : Text
var $1 : Text  // perhaps given
$formName:=OBJECT Get title:C1068(*; “formName”)  // FORM_GetAsObject() creates an invisible text object of this name, just so we can set its title to what the source form is to help us find the scripts
If ($formName#"")  // error-prevention
	$myName:="{formMethod}"
	$path:="[projectForm]/"+$formName+"/"+$myName
	ON ERR CALL:C155(“doMyScriptOnError”)
	METHOD GET CODE:C1190($path; $theCode)  // once we have the code, we can set it to a temporary project method and execute it
	ON ERR CALL:C155("")  // clear that dude
	If ($theCode#_Blank)
		METHOD SET CODE:C1194(“tempScript”; $theCode)
		EXECUTE METHOD:C1007(“tempScript”)
	End if 
	// Compiler error
	//METHOD SET CODE(“tempScript”; "")  // eliminate any possible error-causing remnants of code. Of course, it is theoretically possible that we could get a problem
End if 