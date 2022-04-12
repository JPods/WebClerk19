//%attributes = {"publishedWeb":true}
//Method: PM:  LI_GetUnitPrecision
//Noah Dykoski   October 6, 2000 / 4:45 PM
C_LONGINT:C283($0; $thePrec)  //Unit Precision
C_LONGINT:C283($1; $TableNum)
$TableNum:=$1

C_LONGINT:C283($thePrec)
Case of 
	: ($TableNum=Table:C252(->[Proposal:42]))
		Case of 
			: ((<>tcMONEYCHAR#strCurrency) & ([Proposal:42]currency:55#"") & ([Proposal:42]exchangeRate:54#1) & ([Proposal:42]exchangeRate:54#0))
				$thePrec:=viExDisPrec
			: ((<>tcMONEYCHAR=strCurrency) | ([Proposal:42]currency:55="") | ([Proposal:42]exchangeRate:54=1) | ([Proposal:42]exchangeRate:54=0) | (<>tcMONEYCHAR=""))
				$thePrec:=<>tcDecimalTt
			: (<>tcMONEYCHAR#strCurrency)
				$thePrec:=viExDisPrec  //viExConPrec
			Else 
				$thePrec:=<>tcDecimalTt
		End case 
	: ($TableNum=Table:C252(->[Order:3]))
		Case of 
			: ((<>tcMONEYCHAR#strCurrency) & ([Order:3]currency:69#"") & ([Order:3]exchangeRate:68#1) & ([Order:3]exchangeRate:68#0))
				$thePrec:=viExDisPrec
			: ((<>tcMONEYCHAR=strCurrency) | ([Order:3]currency:69="") | ([Order:3]exchangeRate:68=1) | ([Order:3]exchangeRate:68=0) | (<>tcMONEYCHAR=""))
				$thePrec:=<>tcDecimalTt
			: (<>tcMONEYCHAR#strCurrency)
				$thePrec:=viExDisPrec  //viExConPrec
			Else 
				$thePrec:=<>tcDecimalTt
		End case 
	: ($TableNum=Table:C252(->[Invoice:26]))
		Case of 
			: ((<>tcMONEYCHAR#strCurrency) & ([Invoice:26]currency:62#"") & ([Invoice:26]exchangeRate:61#1) & ([Invoice:26]exchangeRate:61#0))
				$thePrec:=viExDisPrec
			: ((<>tcMONEYCHAR=strCurrency) | ([Invoice:26]currency:62="") | ([Invoice:26]exchangeRate:61=1) | ([Invoice:26]exchangeRate:61=0) | (<>tcMONEYCHAR=""))
				$thePrec:=<>tcDecimalTt
			: (<>tcMONEYCHAR#strCurrency)
				$thePrec:=viExDisPrec  //viExConPrec
			Else 
				$thePrec:=<>tcDecimalTt
		End case 
End case 
$0:=$thePrec