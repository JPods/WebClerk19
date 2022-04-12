//%attributes = {"publishedWeb":true}
C_LONGINT:C283($incLn; $kntLn; $theFile; $curLine)
C_REAL:C285($exchange)
If (<>tcMONEYCHAR#"")
	Case of 
		: (ptCurTable=(->[Order:3]))
			If ((<>tcMONEYCHAR#[Order:3]currency:69) & ([Order:3]exchangeRate:68#0) & ([Order:3]exchangeRate:68#1))  //([Order]Currency#""))
				vLineMod:=True:C214
				Exch_Ord
			End if 
		: ((ptCurTable=(->[Invoice:26])) | (ptCurTable=(->[Control:1])))  //invoice or apply pay window
			If ((<>tcMONEYCHAR#[Invoice:26]currency:62) & ([Invoice:26]exchangeRate:61#0) & ([Invoice:26]exchangeRate:61#1))  //([Invoice]Currency#""))
				vLineMod:=True:C214
				Exch_Inv
			End if 
		: (ptCurTable=(->[Proposal:42]))
			If ((<>tcMONEYCHAR#[Proposal:42]currency:55) & ([Proposal:42]exchangeRate:54#0) & ([Proposal:42]exchangeRate:54#1))  //([Proposal]Currency#""))
				vLineMod:=True:C214
				Exch_Pp
			End if 
		: (ptCurTable=(->[PO:39]))
			If ((<>tcMONEYCHAR#[PO:39]currency:46) & ([PO:39]exchangeRate:45#0) & ([PO:39]exchangeRate:45#1))  //([PO]Currency#""))
				vLineMod:=True:C214
				Exch_Po
				OBJECT SET ENTERABLE:C238([PO:39]exchangeRate:45; False:C215)
			End if 
	End case 
End if 