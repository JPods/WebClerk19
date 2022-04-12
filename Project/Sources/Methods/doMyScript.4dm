//%attributes = {}
//YYYYY
// Modified by: Bill James (2022-01-06T06:00:00Z)
// Method: doMyScript
// Description 
// Belanger.Chris
// Parameters
// ----------------------------------------------------

doMyScript
// doMyScript ( ) – used inside a form that is being operated as ‘dynamic’, execute the code that was associated with the current object in the curent form
var $myName : Text
var $1 : Text  // perhaps given
$myName:=FORM Event:C1606.objectName  // this is the guy’s code we want to execute. It should be there, because otherwise this method would not be in its script
$formName:=OBJECT Get title:C1068(*; “formName”)  // FORM_GetAsObject() creates an invisible text object of this name, just so we can set its title to what the source form is to help us find the scripts
If ($formName#"")  // error-prevention
	// first, operate the OBJECT METHOD, if it exists. We look for the code, handling possible errors. If we get the code, execute it…
	If ($myName#_Blank)  // the object method?
		$path:="[projectForm]/"+$formName+"/"+$myName
		ON ERR CALL:C155(“doMyScriptOnError”)
		METHOD GET CODE:C1190($path; $theCode)  // once we have the code, we can set it to a temporary project method and execute it
		ON ERR CALL:C155("")  // clear that dude
		If ($theCode#_Blank)
			METHOD SET CODE:C1194(“tempScript”; $theCode)
			EXECUTE METHOD:C1007(“tempScript”)
		End if 
	End if 
End if 