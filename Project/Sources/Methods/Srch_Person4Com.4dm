//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/12/06, 07:23:24
// ----------------------------------------------------
// Method: Srch_Person4Com
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($w)
C_TEXT:C284($lastName)
C_TEXT:C284($firstName)
If (Length:C16(srName)>0)
	$w:=Position:C15(Char:C90(44); srName)
	Case of 
		: ($w=1)
			$lastName:=""
			$firstName:=Substring:C12(srName; $w+1; 40)+"@"
		: ($w>1)
			$lastName:=Substring:C12(srName; 1; $w-1)+"@"
			$firstName:=Substring:C12(srName; $w+1)+"@"
		Else 
			$lastName:=srName+"@"
			$firstName:=""
	End case 
	srNameLast:=$lastName
	srNameFirst:=$firstName
	If ((b1=1) | (iLoInteger1=1))  //customers
		Case of 
			: (($firstName#"") & ($lastName#""))
				QUERY:C277([Customer:2]; [Customer:2]nameFirst:73=$firstName; *)
				QUERY:C277([Customer:2];  & [Customer:2]nameLast:23=$lastName)
			: ($lastName#"")
				QUERY:C277([Customer:2]; [Customer:2]nameLast:23=$lastName)
			Else 
				QUERY:C277([Customer:2]; [Customer:2]nameFirst:73=$firstName)
		End case 
		CREATE SET:C116([Customer:2]; "SrCustSet")
		Case of 
			: (($firstName#"") & ($lastName#""))
				QUERY:C277([Contact:13]; [Contact:13]nameFirst:2=$firstName; *)
				QUERY:C277([Contact:13];  & [Contact:13]nameLast:4=$lastName)
			: ($lastName#"")
				QUERY:C277([Contact:13]; [Contact:13]nameLast:4=$lastName)
			Else 
				QUERY:C277([Contact:13]; [Contact:13]nameFirst:2=$firstName)
		End case 
		RELATE ONE SELECTION:C349([Contact:13]; [Customer:2])
		CREATE SET:C116([Customer:2]; "Current")
		UNION:C120("Current"; "SrCustSet"; "SrCustSet")
		CLEAR SET:C117("Current")
		USE SET:C118("SrCustSet")
		CLEAR SET:C117("SrCustSet")
		If (b4=0)
			REDUCE SELECTION:C351([Contact:13]; 0)
		End if 
	End if 
	
	If (b3=1)  //vendors
		QUERY:C277([Vendor:38]; [Vendor:38]attention:55=srName+"@")
	End if 
	If (b4=1)  //Contacts
		Case of 
			: (($firstName#"") & ($lastName#""))
				QUERY:C277([Contact:13]; [Contact:13]nameFirst:2=$firstName; *)
				QUERY:C277([Contact:13];  & [Contact:13]nameLast:4=$lastName)
			: ($lastName#"")
				QUERY:C277([Contact:13]; [Contact:13]nameLast:4=$lastName)
			Else 
				QUERY:C277([Contact:13]; [Contact:13]nameFirst:2=$firstName)
		End case 
	End if 
End if 