//%attributes = {"publishedWeb":true}
//Procedure: Ship_SrFiles
C_LONGINT:C283($1; $2; $3; $4)  //doSearch;b1;b2;b3
REDUCE SELECTION:C351([Customer:2]; 0)
REDUCE SELECTION:C351([Contact:13]; 0)
REDUCE SELECTION:C351([Vendor:38]; 0)
Case of 
		//: ($1=5)
		//SEARCH(File(File(ptZip)))
		//If (OK=0)
		//$1:=0
		//End if 
	: ($1=1)
		If ($2=1)
			QUERY:C277([Customer:2]; [Customer:2]zip:8=srZip+"@")
		End if 
		If ($3=1)
			QUERY:C277([Contact:13]; [Contact:13]zip:11=srZip+"@")
		End if 
		If ($4=1)
			QUERY:C277([Vendor:38]; [Vendor:38]zip:8=srZip+"@")
		End if 
	: ($1=2)
		If ($2=1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=srAcct+"@")
		End if 
		If ($4=1)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorid:1=srAcct+"@")
		End if 
	: ($1=3)
		If ($2=1)
			QUERY:C277([Customer:2]; [Customer:2]company:2=srCustomer+"@")
		End if 
		If ($3=1)
			QUERY:C277([Contact:13]; [Contact:13]company:23=srCustomer+"@")
		End if 
		If ($4=1)
			QUERY:C277([Vendor:38]; [Vendor:38]company:2=srCustomer+"@")
		End if 
	: ($1=4)
		If ($2=1)
			QUERY:C277([Customer:2]; [Customer:2]phone:13=srPhone+"@")
		End if 
		If ($3=1)
			QUERY:C277([Contact:13]; [Contact:13]phone:30=srPhone+"@")
		End if 
		If ($4=1)
			QUERY:C277([Vendor:38]; [Vendor:38]phone:10=srPhone+"@")
		End if 
	: ($1=6)
		KeyModifierCurrent
		Srch_Person4Com($2; $3; $4; ->srName)
End case 