Case of 
	: (Form event code:C388=On Load:K2:1)
		TRACE:C157
		Form:C1466.readableUser:=Calendar_UserList
		Form:C1466.loaded:=True:C214
	: (Form event code:C388=On Activate:K2:9)
		If (Form:C1466.loaded#Null:C1517)
			If (Form:C1466.loaded)
				EXECUTE METHOD IN SUBFORM:C1085("calContainer"; "Calendar_update")
			End if 
		End if 
End case 


If (False:C215)  // called elsewhere
	Case of 
		: (Form event code:C388=On Load:K2:1)
			Form:C1466.view:="month"
			Form:C1466.date:=Current date:C33
			Form:C1466.url:=Get 4D folder:C485(Current resources folder:K5:16)+"fullcalendar"+Folder separator:K24:12+"view.html"
			OBJECT Get pointer:C1124(Object named:K67:5; "radioMonth")->:=1
			WA SET PREFERENCE:C1041(*; "webArea"; WA enable JavaScript:K62:4; True:C214)
			WA OPEN URL:C1020(*; "webArea"; Form:C1466.url)
			SET WINDOW TITLE:C213("Calendar for "+CurrentUser_Get)
			
			C_LONGINT:C283($l; $t; $r; $b)
			OBJECT GET COORDINATES:C663(*; "radioMonth"; $l; $t; $r; $b)
			OBJECT SET COORDINATES:C1248(*; "viewRect"; $l; $t; $r; $b)
			
		: (Form event code:C388=On Activate:K2:9)
			Calendar_update
			
	End case 
End if 