//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/07/17, 10:56:19
// ----------------------------------------------------
// Method: AcceptContactsRetired
// Description
// 
//
// Parameters
// ----------------------------------------------------

If ([Customer:2]dateRetired:111=!00-00-00!)
	
	QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
	QUERY:C277([Contact:13]; [Contact:13]dateRetired:57=Old:C35([Customer:2]dateRetired:111); *)
	QUERY:C277([Contact:13])
	$k:=Records in selection:C76([Contact:13])
	FIRST RECORD:C50([Contact:13])
	For ($i; 1; $k)
		[Contact:13]dateRetired:57:=!00-00-00!
		SAVE RECORD:C53([Contact:13])
		NEXT RECORD:C51([Contact:13])
	End for 
	
Else 
	
	QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1; *)
	QUERY:C277([Contact:13]; [Contact:13]dateRetired:57=!00-00-00!; *)
	QUERY:C277([Contact:13])
	$k:=Records in selection:C76([Contact:13])
	FIRST RECORD:C50([Contact:13])
	For ($i; 1; $k)
		[Contact:13]dateRetired:57:=[Customer:2]dateRetired:111
		SAVE RECORD:C53([Contact:13])
		NEXT RECORD:C51([Contact:13])
	End for 
	
End if 
