//%attributes = {"publishedWeb":true}
//Procedure: Sr_VendLdCust
REDUCE SELECTION:C351([Customer:2]; 0)  //b1
REDUCE SELECTION:C351([Lead:48]; 0)  //b2
REDUCE SELECTION:C351([Vendor:38]; 0)  //b3
REDUCE SELECTION:C351([Contact:13]; 0)  //b4
C_LONGINT:C283($beginSrch; $endSrch)
KeyModifierCurrent
Case of 
		//: (doSearch=5)
		//SEARCH(File(File(ptZip)))
		//If (OK=0)
		//doSearch:=0
		//End if 
	: (doSearch=1)  // srZip
		If (b1=1)
			QUERY:C277([Customer:2]; [Customer:2]zip:8=srZip+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Customer:2];  & [Customer:2]dateRetired:111=!00-00-00!; *)
			End if 
			QUERY:C277([Customer:2])
		End if 
		If (b2=1)
			QUERY:C277([Lead:48]; [Lead:48]zip:10=srZip+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Lead:48];  & [Lead:48]retired:56=!00-00-00!; *)
			End if 
			QUERY:C277([Lead:48])
		End if 
		If (b3=1)
			QUERY:C277([Vendor:38]; [Vendor:38]zip:8=srZip+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Vendor:38];  & [Vendor:38]dateRetired:90=!00-00-00!; *)
			End if 
			QUERY:C277([Vendor:38])
		End if 
		If (b4=1)
			QUERY:C277([Contact:13]; [Contact:13]zip:11=srZip+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Contact:13];  & [Contact:13]dateRetired:57=!00-00-00!; *)
			End if 
			QUERY:C277([Contact:13])
		End if 
	: (doSearch=2)  // srAcct
		If (b1=1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=srAcct+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Customer:2];  & [Customer:2]dateRetired:111=!00-00-00!; *)
			End if 
			QUERY:C277([Customer:2])
		End if 
		If (b2=1)
			If (Num:C11(srAcct)#0)
				//$beginSrch:=Num(srAcct)
				//$endSrch:=Num(Char(Ascii(srAcct)+1)+Substring(srAcct;2))
				QUERY:C277([Lead:48]; [Lead:48]idNum:32=Num:C11(srAcct))
				//SEARCH([Lead];&[Lead]UniqueID<=$endSrch)
			End if 
		End if 
		If (b3=1)
			QUERY:C277([Vendor:38]; [Vendor:38]vendorid:1=srAcct+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Vendor:38];  & [Vendor:38]dateRetired:90=!00-00-00!; *)
			End if 
			QUERY:C277([Vendor:38])
		End if 
		If (b4=1)
			If (Num:C11(srAcct)#0)
				//$beginSrch:=Num(srAcct)
				//$endSrch:=Num(Char(Ascii(srAcct)+1)+Substring(srAcct;2))
				QUERY:C277([Contact:13]; [Contact:13]idNum:28=Num:C11(srAcct))
			End if 
		End if 
	: (doSearch=3)  //  srCustomer
		If (b1=1)
			QUERY:C277([Customer:2]; [Customer:2]company:2=srCustomer+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Customer:2];  & [Customer:2]dateRetired:111=!00-00-00!; *)
			End if 
			QUERY:C277([Customer:2])
		End if 
		If (b2=1)
			QUERY:C277([Lead:48]; [Lead:48]company:5=srCustomer+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Lead:48];  & [Lead:48]retired:56=!00-00-00!; *)
			End if 
			QUERY:C277([Lead:48])
		End if 
		If (b3=1)
			QUERY:C277([Vendor:38]; [Vendor:38]company:2=srCustomer+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Vendor:38];  & [Vendor:38]dateRetired:90=!00-00-00!; *)
			End if 
			QUERY:C277([Vendor:38])
		End if 
		If (b4=1)
			QUERY:C277([Contact:13]; [Contact:13]company:23=srCustomer+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Contact:13];  & [Contact:13]dateRetired:57=!00-00-00!; *)
			End if 
			QUERY:C277([Contact:13])
		End if 
	: (doSearch=4)  //  srPhone
		If (b1=1)
			QUERY:C277([Customer:2]; [Customer:2]phone:13=srPhone+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Customer:2];  & [Customer:2]dateRetired:111=!00-00-00!; *)
			End if 
			QUERY:C277([Customer:2])
		End if 
		If (b2=1)
			QUERY:C277([Lead:48]; [Lead:48]phone:4=srPhone+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Lead:48];  & [Lead:48]retired:56=!00-00-00!; *)
			End if 
			QUERY:C277([Lead:48])
		End if 
		If (b3=1)
			QUERY:C277([Vendor:38]; [Vendor:38]phone:10=srPhone+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Vendor:38];  & [Vendor:38]dateRetired:90=!00-00-00!; *)
			End if 
			QUERY:C277([Vendor:38])
		End if 
		If (b4=1)
			QUERY:C277([Contact:13]; [Contact:13]phone:30=srPhone+"@"; *)
			If ((CmdKey=0) & (b7=0))
				QUERY:C277([Contact:13];  & [Contact:13]dateRetired:57=!00-00-00!; *)
			End if 
			QUERY:C277([Contact:13])
		End if 
	: (doSearch=6)  // srName
		KeyModifierCurrent
		Srch_Person4Com(b1; b2; b3; ->srName)
	: (doSearch=11)  // srKeyword
		If (b1=1)
			KeyWordByAlpha(Table:C252(->[Customer:2]); srKeyword)
		End if 
		If (b2=1)
			KeyWordByAlpha(Table:C252(->[Lead:48]); srKeyword)
		End if 
		If (b3=1)
			KeyWordByAlpha(Table:C252(->[Vendor:38]); srKeyword)
		End if 
		If (b4=1)
			KeyWordByAlpha(Table:C252(->[Contact:13]); srKeyword)
		End if 
End case 