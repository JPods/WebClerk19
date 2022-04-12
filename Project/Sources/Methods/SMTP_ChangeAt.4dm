//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: SMTP_ChangeAt
	//Date: 07/01/02
	//Who: Bill
	//Description: Changing '@', variables added to pages to display '@'
End if 
//
CONFIRM:C162("Exchange the @ to &~, makes field searchable")
If (OK=1)
	C_LONGINT:C283($i; $k; $p)
	MESSAGE:C88("Posting Customers")
	QUERY:C277([QQQCustomer:2]; [QQQCustomer:2]email:81#"")
	$k:=Records in selection:C76([QQQCustomer:2])
	FIRST RECORD:C50([QQQCustomer:2])
	For ($i; 1; $k)
		$p:=Position:C15(Char:C90(64); [QQQCustomer:2]email:81)  // suppression @
		If ($p>0)
			[QQQCustomer:2]email:81:=Substring:C12([QQQCustomer:2]email:81; 1; $p-1)+"&~"+Substring:C12([QQQCustomer:2]email:81; $p+1)
			SAVE RECORD:C53([QQQCustomer:2])
		End if 
		NEXT RECORD:C51([QQQCustomer:2])
	End for 
	//
	MESSAGE:C88("Posting Leads")
	QUERY:C277([Lead:48]; [Lead:48]Email:33#"")
	$k:=Records in selection:C76([Lead:48])
	FIRST RECORD:C50([Lead:48])
	For ($i; 1; $k)
		$p:=Position:C15(Char:C90(64); [Lead:48]Email:33)  // suppression @
		If ($p>0)
			[Lead:48]Email:33:=Substring:C12([Lead:48]Email:33; 1; $p-1)+"&~"+Substring:C12([Lead:48]Email:33; $p+1)
			SAVE RECORD:C53([Lead:48])
		End if 
		NEXT RECORD:C51([Lead:48])
	End for 
	//
	MESSAGE:C88("Posting Vendors")
	QUERY:C277([QQQVendor:38]; [QQQVendor:38]Email:59#"")
	$k:=Records in selection:C76([QQQVendor:38])
	FIRST RECORD:C50([QQQVendor:38])
	For ($i; 1; $k)
		$p:=Position:C15(Char:C90(64); [QQQVendor:38]Email:59)  // suppression @
		If ($p>0)
			[QQQVendor:38]Email:59:=Substring:C12([QQQVendor:38]Email:59; 1; $p-1)+"&~"+Substring:C12([QQQVendor:38]Email:59; $p+1)
			SAVE RECORD:C53([QQQVendor:38])
		End if 
		NEXT RECORD:C51([QQQVendor:38])
	End for 
	//
	MESSAGE:C88("Posting Contacts")
	QUERY:C277([QQQContact:13]; [QQQContact:13]Email:35#"")
	$k:=Records in selection:C76([QQQContact:13])
	FIRST RECORD:C50([QQQContact:13])
	For ($i; 1; $k)
		$p:=Position:C15(Char:C90(64); [QQQContact:13]Email:35)  // suppression @
		If ($p>0)
			[QQQContact:13]Email:35:=Substring:C12([QQQContact:13]Email:35; 1; $p-1)+"&~"+Substring:C12([QQQContact:13]Email:35; $p+1)
			SAVE RECORD:C53([QQQContact:13])
		End if 
		NEXT RECORD:C51([QQQContact:13])
	End for 
	//
	MESSAGE:C88("Posting Reps")
	QUERY:C277([Rep:8]; [Rep:8]Email:22#"")
	$k:=Records in selection:C76([Rep:8])
	FIRST RECORD:C50([Rep:8])
	For ($i; 1; $k)
		$p:=Position:C15(Char:C90(64); [Rep:8]Email:22)  // suppression @
		If ($p>0)
			[Rep:8]Email:22:=Substring:C12([Rep:8]Email:22; 1; $p-1)+"&~"+Substring:C12([Rep:8]Email:22; $p+1)
			SAVE RECORD:C53([Rep:8])
		End if 
		NEXT RECORD:C51([Rep:8])
	End for 
	//
	MESSAGE:C88("Posting Remote Users")
	QUERY:C277([QQQRemoteUser:57]; [QQQRemoteUser:57]email:14#"")
	$k:=Records in selection:C76([QQQRemoteUser:57])
	FIRST RECORD:C50([QQQRemoteUser:57])
	For ($i; 1; $k)
		$p:=Position:C15(Char:C90(64); [QQQRemoteUser:57]email:14)  // suppression @
		If ($p>0)
			[QQQRemoteUser:57]email:14:=Substring:C12([QQQRemoteUser:57]email:14; 1; $p-1)+"&~"+Substring:C12([QQQRemoteUser:57]email:14; $p+1)
			SAVE RECORD:C53([QQQRemoteUser:57])
		End if 
		NEXT RECORD:C51([QQQRemoteUser:57])
	End for 
End if 

REDRAW WINDOW:C456