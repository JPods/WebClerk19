//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/18/18, 14:48:41
// ----------------------------------------------------
// Method: LoadCustomFields
// Description
// 
//
// Parameters
// ----------------------------------------------------

// load user custom fields

// save current selection of GenericChild1
If (Records in selection:C76([GenericChild1:90])>0)
	COPY NAMED SELECTION:C331([GenericChild1:90]; "LoadCustomFields")
End if 
// talk with Jim Medlen  CHANGE TO OBGeneral?????
// ### bj ### 20200623_0339
QUERY:C277([GenericChild1:90]; [GenericChild1:90]Name:3=Table name:C256(ptCurtable); *)
QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]Purpose:4=Current form name:C1298; *)
QUERY:C277([GenericChild1:90];  & ; [GenericChild1:90]A01:40=Current user:C182; *)
QUERY:C277([GenericChild1:90])

If (Records in selection:C76([GenericChild1:90])>0)
	FIRST RECORD:C50([GenericChild1:90])
	For (vi1; 1; Records in selection:C76([GenericChild1:90]))
		If (<>viDebugMode>410)
			ConsoleMessage([GenericChild1:90]A02:41+";"+[GenericChild1:90]A03:42+";"+[GenericChild1:90]A04:43)
		End if 
		SelectSort([GenericChild1:90]A02:41; [GenericChild1:90]A03:42; [GenericChild1:90]A04:43)
		NEXT RECORD:C51([GenericChild1:90])
	End for 
End if 

// restore current selection of GenericChild1
$viResult:=RECORDS IN NAMED SELECTION(->[GenericChild1:90]; "LoadCustomFields")
If ($viResult>0)
	USE NAMED SELECTION:C332("LoadCustomFields")
	CLEAR NAMED SELECTION:C333("LoadCustomFields")
End if 
