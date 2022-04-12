
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/17/18, 10:47:19
// ----------------------------------------------------
// Method: [Message].Input.EmailDropDown
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Data Change:K2:15))
		TRACE:C157
		Case of 
				
				
			: (ddEmail=1)
				TabControl:=1
				FORM GOTO PAGE:C247(TabControl)
				WATextIntoArea(->myWebArea; [QQQMessage:137]Body:12; "view")
				
			: (ddEmail=2)
				TabControl:=1
				FORM GOTO PAGE:C247(TabControl)
				WATextIntoArea(->myWebArea; [QQQMessage:137]Body:12; "edit")
				
			: (ddEmail=3)
				
				CONFIRM:C162("Save Changes to HTML"; " Save "; " Cnacel")
				If (ok=1)
					WA EXECUTE JAVASCRIPT FUNCTION:C1043(myWebArea; "getContent"; $vtContent)
					[QQQMessage:137]Body:12:=$vtContent
				End if 
		End case 
End case 
