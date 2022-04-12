//%attributes = {"publishedWeb":true}
//([Customer]Zip;[Customer]Zone
C_BOOLEAN:C305($doThis)
C_TEXT:C284($tempStr)
C_POINTER:C301($2; $3; $4; $5)
If (Length:C16($1->)>0)
	$tempStr:=Substring:C12($1->; 1; 5)
	QUERY:C277([Territory:25]; [Territory:25]purpose:6=0; *)
	QUERY:C277([Territory:25];  & [Territory:25]beginningZip:4<=$tempStr; *)
	QUERY:C277([Territory:25];  & [Territory:25]endingZip:5>=$tempStr)
	Case of 
		: (Records in selection:C76([Territory:25])=1)
			KeyModifierCurrent
			If ((OptKey=0) & (allowAlerts_boo))
				CONFIRM:C162("Enter "+[Territory:25]salesNameID:1+" as Sales and "+[Territory:25]repID:2+" as Rep?")
				$doThis:=(OK=1)
			Else 
				$doThis:=True:C214
			End if 
			If ($doThis)
				If (Count parameters:C259>2)
					$2->:=[Territory:25]salesNameID:1
					$3->:=[Territory:25]repID:2
				End if 
				If (Count parameters:C259>4)
					$4->:=[Territory:25]salesNameID:1
					$5->:=[Territory:25]repID:2
				End if 
			End if 
			
			Case of 
				: (Table:C252($1)=(Table:C252(->[Customer:2])))
					[Customer:2]territoryid:120:=[Territory:25]territoryid:3
				: (Table:C252($1)=(Table:C252(->[Lead:48])))
					[Lead:48]territoryid:57:=[Territory:25]territoryid:3
			End case 
			
		: (Records in selection:C76([Territory:25])>1)
			If (Not:C34(allowAlerts_boo))  //block all       
				BEEP:C151
				BEEP:C151
				BEEP:C151
			End if 
		: (Records in selection:C76([Territory:25])=0)
			If (allowAlerts_boo)  //block all       
				BEEP:C151
			End if 
	End case 
	QUERY:C277([Territory:25]; [Territory:25]purpose:6=1; *)
	QUERY:C277([Territory:25];  & [Territory:25]beginningZip:4<=$tempStr; *)
	QUERY:C277([Territory:25];  & [Territory:25]endingZip:5>=$tempStr)
	If (Records in selection:C76([Territory:25])>0)
		FIRST RECORD:C50([Territory:25])
		// ### bj ### 20210221_1259
		// fixed territory being pushed into taxjurisdiction
		Case of 
			: (ptCurTable=(->[Customer:2]))
				[Customer:2]territoryid:120:=[Territory:25]territoryid:3
			: (ptCurTable=(->[Order:3]))
				//[Order]taxJuris:=[Territory]territoryid
				vMod:=calcOrder(True:C214)
				//If ([Customer]taxJuris="")
				//[Customer]taxJuris:=[Territory]territoryid
				//End if 
			: (ptCurTable=(->[Lead:48]))
				[Lead:48]territoryid:57:=[Territory:25]territoryid:3
			: (ptCurTable=(->[Contact:13]))
				//[Contact]taxJuris:=[Territory]territoryID
			: (ptCurTable=(->[Invoice:26]))
				//[Invoice]taxJuris:=[Territory]territoryid
				
				vMod:=calcInvoice(True:C214)
				//If ([Customer]taxJuris="")
				//[Customer]taxJuris:=[Territory]territoryid
				//End if 
			: (ptCurTable=(->[Proposal:42]))
				//[Proposal]taxJuris:=[Territory]territoryid
				
				vMod:=calcProposal(True:C214)
				//If ([Customer]taxJuris="")
				//[Customer]taxJuris:=[Territory]territoryid
				//End if 
		End case 
	End if 
End if 