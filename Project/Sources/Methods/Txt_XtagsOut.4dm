//%attributes = {"publishedWeb":true}

//

//
//
//scripts
vText1:=""
vR1:=0
vR2:=2
vR3:=2.5
vR4:=0.75
v1:=Char:C90(34)
vi2:=Records in selection:C76([Invoice:26])
FIRST RECORD:C50([Invoice:26])
QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="copy"; *)
QUERY:C277([TallyResult:73];  & [TallyResult:73]name:1="Paste")
For (vi1; 1; vi2)
	QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
	vi4:=Records in selection:C76([InvoiceLine:54])
	FIRST RECORD:C50([InvoiceLine:54])
	For (vi3; 1; vi4)
		If ([InvoiceLine:54]comment:40#"")
			vi7:=vi7+1
			vText5:=Replace string:C233(vText3; "_jit_0_vR2jj"; String:C10(vi7))
			vText1:=vText1+"\r"+vText5+[InvoiceLine:54]comment:40+"<&te>"
		End if 
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
	NEXT RECORD:C51([Invoice:26])
End for 
SET TEXT TO PASTEBOARD:C523(vText1)